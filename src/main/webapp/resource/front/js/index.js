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

    /*页面到达底部时，加载下一页*/
    function getNextPage() {
        //检测是否到达底部
        if (Math.ceil($(window).height() + $(window).scrollTop()) >= $(document).height()){
            $.ajax({

            })
        }
    }
})
