$(document).ready(function () {
    $(window).scroll(function () {
        //小屏幕下底部导航的显示隐藏
        if (window.innerWidth < 768){
            if($(window).scrollTop() > 100 && Math.ceil($(window).height() + $(window).scrollTop()) < $(document).height()){
                $("#nav-column").css("transform","translateY(100%)")
            }else {
                $("#nav-column").css("transform","")
            }
        }
        //文字展现效果
        scrollShowArticle();
        //获取文章下一页
        loadArticle.getNextPage();
    });
    
    /*文章展现效果*/
    scrollShowArticle();
    function scrollShowArticle() {
        $("#article-list .article-item").eq(0).addClass("show");
        $("#article-list .article-item").each(function () {
            if(($(document).scrollTop() + $(window).height() - 50) > $(this).offset().top){
                $(this).addClass("show");
            }
        })
    }

    /*小屏幕下分类的隐藏与展现*/
    $("#category-shrink").on("click",".category-msg",function () {
        $(this).toggleClass("show");
        $("#category-shrink .category-box").toggleClass("show");
    });

    /*底部导航菜单点击时添加全局类，区分展示效果*/
    $("#mobile-menu, #shadow").on("click", function () {
        $("html").toggleClass("menu-show");
        $(window).bind("touchmove", function () {
            //return false
            if($("html").hasClass("menu-show")){
                return false;
            }
        })
        $("#mobi-menu").blur();
    });


    /*
    * 定义文章加载列表组件
    *
    * */
    var loadArticle = {
        url:"article/list",
        //每次加载文章个数
        pageSize: 30,
        //是否已经全部加载完成
        hasLoadAll: false,
        /*页面到达底部时，加载下一页*/
        getNextPage:function() {
            var self = this;
            //文章未充满屏幕或者到达底部，则请求下一页
            if ($("#article-list").height() < $(window).height() || Math.ceil($(window).height() + $(window).scrollTop()) >= $(document).height()){
                //已经加载完毕，不再触发请求；
                if (self.hasLoadAll){return;}
                $.ajax({
                    url:self.url,
                    type:"POST",
                    beforeSend:function () {
                        $("#loading").show();
                    },
                    data:{
                        //加载文章列表起始序号
                        pageIndex:$("#article-list .article-item").length,
                        //每次加载文章个数
                        pageSize: self.pageSize,
                    },
                    success:function (result) {
                        //全部请求完成后，阻止继续请求
                        if (result.result.length < self.pageSize){
                            self.hasLoadAll = true;
                        }
                        console.log(result)
                        //防止连续触发
                        setTimeout(function () {
                            $("#loading").hide();
                            self.renderArticleList(result.result);
                            //全部请求完成后，显示结束标志
                            if (result.result.length < self.pageSize){
                                $("#loadingCompleted").show();
                            }
                        },500);
                    }
                });
            }
        },
        //渲染文章列表
        renderArticleList:function(arr) {
            if (Object.prototype.toString.call(arr) !== "[object Array]"){
                return;
            }
            var htmlStr = "";
            arr.forEach(function (el) {
                htmlStr += '<div class="article-item">\n' +
                    '                        <h3 class="article-title"><a href="article/1234567">'+ el["title"] +'</a></h3>\n' +
                    '                        <div class="article-summary">'+ el["summaryHtmlContent"]+'</div>\n' +
                    '                        <div class="article-msg clear">\n' +
                    '                            <div class="left">\n' +
                    '                                <div class="article-publishTime">'+ $.utils().timeFormat(el["publishTime"]) +'</div>\n' +
                    '                                <div class="article-tags">\n' +
                    '                                    <span class="tag-msg">标签：</span>\n';
                for(var i = 0;i < el.tags.length;i++){ htmlStr += '<span class="tag-item">'+ el.tags[i].tagName +'</span>；\n'} ;
                htmlStr +=  '                                </div>\n' +
                    '                            </div>\n' +
                    '                            <div class="right comment-msg" title="评论">\n' +
                    '                                <i class="scale_yaodong"></i>\n' +
                    '                                <span class="article-commentNum">13</span>\n' +
                    '                            </div>\n' +
                    '                            <div class="right click-msg" title="阅读量">\n' +
                    '                                <i class="scale_yaodong"></i>\n' +
                    '                                <span class="article-clickNum">211</span>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>'
            });
            $("#article-list-container").append(htmlStr);
            //触发滚动事件，添加文章出现的效果
            $(window).trigger("scroll");
        }
    }

    //初始加载文章列表
    loadArticle.getNextPage();

    /*
    * 点击column获取不同类型文章
    *
    * */
    $("#column #column-ul li").click(function () {
        var self = $(this);
        var column = self.text().trim();
        //点击获取active
        self.addClass("active");
        self.siblings().removeClass("active");
        //点击重置请求的url;
        if(column === "首页"){
            loadArticle.url = "article/list";
        }else if (column === "热门"){
            loadArticle.url = "article/list";
        }else {
            loadArticle.url = "article/column/" + column;
        }

        //先清空原有的文章
        $("#article-list-container").html("");
        $("#loadingCompleted").hide();
        //重置请求组件
        loadArticle.hasLoadAll = false;
        loadArticle.getNextPage();
    })
})
