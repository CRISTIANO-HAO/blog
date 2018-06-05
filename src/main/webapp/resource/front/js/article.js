$(document).ready(function () {
    /*
    * 点击提交评论
    *
    * */
    $(".submit-btn").click(function (e) {
        var commentForm = $(this).closest(".comment-form");
        var isReply = !commentForm.attr("id");
        var pid = commentForm.find(".commentId").val() || 0;
        var username = commentForm.find(".username").val();
        var email = commentForm.find(".user-email").val();
        var website = commentForm.find(".user-website").val();
        var content = commentForm.find(".comment-content").val();
        var articleId = $("#articleId").val();

        var data = {
            pid: pid,
            username:username,
            website:website,
            email:email,
            content:content,
            articleId:articleId
        };

        $.ajax({
            type:"POST",
            url:"comment/submit",
            contentType: "application/json;charset=UTF-8",
            dataType:"json",
            beforeSend:function () {

            },
            data:JSON.stringify(data),
            success:function (result) {
                console.log(result)
            }
        })
    })
})