$(document).ready(function () {

    //监听页面滚动事件
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
        if (loadArticle.pageIndex > 0){
            loadArticle.getNextPage();
        }
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
        //请求开关，等待一次请求完成后，才能继续请求
        requestFlag: true,
        //重置请求组件的配置
        reset:function () {
            //防止滚动中途点击，重置容器位置
            $(window).scrollTop(0);
            //先清空原有的文章
            $("#article-list-container").html("");
            $("#loadingCompleted").hide();
            this.hasLoadAll = false;
            this.pageIndex = 0;
        },
        //请求url
        url:"article/list",
        //文章加载起始位置
        pageIndex:0,
        //每次加载文章个数
        pageSize: 3,
        //是否已经全部加载完成
        hasLoadAll: false,
        /*页面到达底部时，加载下一页*/
        getNextPage:function() {
            var self = this;
            //文章未充满屏幕或者到达底部，则请求下一页
            if ($("#article-list").height() < $(window).height() || Math.ceil($(window).height() + $(window).scrollTop()) >= $(document).height()){
                //已经加载完毕，不再触发请求；请求进行中也无法发起第二次请求
                if (self.hasLoadAll || !self.requestFlag){return;}
                $.ajax({
                    url:self.url,
                    type:"POST",
                    beforeSend:function () {
                        $("#loading").show();
                        //关闭请求开关
                        self.requestFlag = false;
                    },
                    data:{
                        //加载文章列表起始序号
                        pageIndex: self.pageIndex,
                        //每次加载文章个数
                        pageSize: self.pageSize,
                    },
                    success:function (result) {
                        //全部请求完成后，阻止继续请求
                        if (result.result.length < self.pageSize){
                            self.hasLoadAll = true;
                        }
                        //防止连续触发
                        setTimeout(function () {
                            $("#loading").hide();
                            self.renderArticleList(result.result);
                            //重置文章起始位置
                            self.pageIndex = $("#article-list .article-item").length;
                            //全部请求完成后，显示结束标志
                            if (result.result.length < self.pageSize){
                                if (result.result.length === 0 && self.pageIndex === 0){
                                    $("#loadingCompleted>span").html("暂无相关文章...");
                                }else {
                                    $("#loadingCompleted>span").html("全部加载完成...");
                                }
                                $("#loadingCompleted").show();
                            }
                        },500);
                    }
                }).always(function () {
                    //等到请求文章全部渲染，重置打开请求开关
                    setTimeout(function () {
                        self.requestFlag = true;
                    },600)
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
                    '                        <h3 class="article-title"><a target="view_window" href="article/' + el["articleId"] + '">'+ el["title"] +'</a></h3>\n' +
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
    
    
    /*
    * 点击各项搜索分类隐藏显示处理
    * 
    * */
    function clickController(_this) {
        var column = $('#column-ul');
        var category = $('#category ul');
        var archives = $('#archives ul');
        var category_shrink = $('#category-shrink');
        var nav = $('#nav');
        var header = $('#article-list-header');

        //重置各个列表状态
        column.find('li').removeClass("active");
        category.find("li").removeClass("active");
        archives.find("li").removeClass("active");
        category_shrink.find("li").removeClass("active");
        header.children().hide();

        if (_this.closest("#column-ul").length > 0){
            header.hide();
        }else {
            column.find("li").eq(0).addClass("active");
            header.show();
        }
    }
    


    /*
    * 点击column获取不同类型文章
    *
    * */
    $("#column #column-ul li").click(function () {
        var self = $(this);
        var column = self.text().trim();
        //重置列表状态
        clickController(self);
        //点击获取active
        self.addClass("active");
        //点击重置请求的url;
        if(column === "首页"){
            loadArticle.url = "article/list";
        }else if (column === "热门"){
            loadArticle.url = "article/list";
        }else {
            loadArticle.url = "article/column/" + column;
        }

        //重置请求组件
        loadArticle.reset();
        loadArticle.getNextPage();
    });


    /*
    * 点击nav获取小屏幕下专栏文章列表
    *
    * */
    $("#nav ul li").click(function () {
        var self = $(this);
        var column = self.find("span").text().trim();
        //重置列表状态
        clickController(self);

        $('#mobile-menu').trigger("click");
        //提示头显示
        $('#nav-keyword').html(column);
        $('#nav-param').show();

        //点击重置请求的url;
        if(column === "首页"){
            loadArticle.url = "article/list";
        }else if (column === "热门"){
            loadArticle.url = "article/list";
        }else {
            loadArticle.url = "article/column/" + column;
        }

        //重置请求组件
        loadArticle.reset();
        loadArticle.getNextPage();
    });



    
    /*
    * 点击搜索关键词
    * 
    * */
    $("#submit-in").click(function () {
        var self = $(this);
        //重置列表状态
        clickController(self);
        //获取搜索关键词
        var keyword = $("#search-in").val().trim();

        //搜索关键词为空，返回首页
        if (keyword === ""){
            loadArticle.url = "article/list";
            $("#search-param").hide();
        }else {
            loadArticle.url = "article/search/" + keyword;
            $("#search-param").show();
            $("#search-keyword").html($("#search-in").val());
        }
        //重置请求组件参数
        loadArticle.reset();
        loadArticle.getNextPage();
    })

    /*
    * 回车搜索文章
    *
    * */
    $("#search-in").on("keypress",function (event) {
        if(event.keyCode == 13){
            $("#submit-in").trigger("click");
        }
    });


    /*
    * 点击加载分类列表
    *
    * */
    $('#category').on('click',"ul li",function () {
        var self = $(this);
        var category = self.find("span").html().trim();

        //重置列表状态
        clickController(self);
        self.addClass("active");

        //提示头显示
        $('#category-keyword').html(category);
        $('#category-param').show();

        //重置请求组件
        loadArticle.url = "article/category/" + category;
        loadArticle.reset();
        loadArticle.getNextPage();
    });


    /*
    *小屏幕下分类的隐藏与展现
    *
    * */
    $("#category-shrink").on("click",".category-msg",function () {
        $(this).toggleClass("show");
        $("#category-shrink .category-box").toggleClass("show");
    });


    /*
    * 点击加载小屏幕下分类列表
    *
    * */
    $('#category-shrink').on('click',"ul li",function () {
        var self = $(this);
        var category = self.find("span").html().trim();

        //重置列表状态
        clickController(self);
        self.addClass("active");

        //提示头显示
        $('#category-keyword').html(category);
        $('#category-param').show();
        $('#category-shrink').find('.category-msg').trigger('click');

        //重置请求组件
        loadArticle.url = "article/category/" + category;
        loadArticle.reset();
        loadArticle.getNextPage();
    });


    /*
    * 点击加载归档列表
    *
    * */
    $("#archives").on("click","ul li",function () {
        var self = $(this);
        var timerange = self.attr("data-timerange");

        //重置列表状态
        clickController(self);
        self.addClass("active");

        //提示头显示
        $('#archives-keyword').html(timerange);
        $('#archives-param').show();

        //重置请求组件
        loadArticle.url = "article/archives/" + timerange;
        loadArticle.reset();
        loadArticle.getNextPage();
    })


    /*
    * 初始加载文章列表
    *
    * */
    {
        //初始加载文章列表
        loadArticle.getNextPage();
    }
})
