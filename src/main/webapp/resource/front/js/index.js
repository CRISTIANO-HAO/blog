$(document).ready(function () {
    $(window).scroll(function () {
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
    })
})
