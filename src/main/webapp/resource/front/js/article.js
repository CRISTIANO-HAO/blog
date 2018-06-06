$(document).ready(function () {
    /*
    * 点击提交评论
    *
    * */
    $("#comment").on("click",".submit-btn",function (e) {
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

        //校验评论信息
        if (!msgValidate(data,commentForm)){
            return;
        }

        $.ajax({
            type:"POST",
            url:"comment/submit",
            contentType: "application/json;charset=UTF-8",
            dataType:"json",
            beforeSend:function () {

            },
            data:JSON.stringify(data),
            success:function (result) {
                if (result.success){
                    getArticleComment();
                }
            }
        })
    });

    /*
    * 评论信息校验
    *
    * */
    function msgValidate(data,self) {
        if (!(data.username && data.email && data.content)){
            if(data.username === ""){
                self.find(".username").addClass("isEmpty");
            }else {
                self.find(".username").removeClass("isEmpty");
            }
            if(data.email === ""){
                self.find(".user-email").addClass("isEmpty");
            }else {
                self.find(".user-email").removeClass("isEmpty");
            }
            if(data.content === ""){
                self.find(".comment-content").addClass("isEmpty");
            }else {
                self.find(".comment-content").removeClass("isEmpty");
            }
            return false;
        }
    }
    
    /*
    * 点击打开评论框
    * 
    * */
    $("#comment").on("click",".comment-item .reply-btn",function () {
        var answerBox = $(this).closest(".answer-box");
        var htmlStr = patchAnswerBox(answerBox);
        if (answerBox.find(".comment-form").length == 0){
            answerBox.append(htmlStr);
        }else {
            answerBox.find(".comment-form").remove();
        }
    });

    /*
    * 拼凑回复框
    *
    * */
    function patchAnswerBox(answerBox) {
        var htmlStr = "";
        htmlStr += '<div class="comment-form">\n' +
            '                                    <div class="avatar-wrap left">\n' +
            '                                        <div class="avatar"></div>\n' +
            '                                    </div>\n' +
            '                                    <div class="comment-form-info clear">\n' +
            '                                        <div class="comment-form-input">\n' +
            '                                            <div class="input-wrap">\n' +
            '                                                <input class="commentId" type="hidden" value="'+ answerBox.find(".commentId").val() +'"/>\n' +
            '                                                <input type="text" class="username" placeholder="您的名称">\n' +
            '                                            </div>\n' +
            '                                            <div class="input-wrap">\n' +
            '                                                <input type="text" class="user-email" placeholder="您的邮箱">\n' +
            '                                            </div>\n' +
            '                                            <div class="input-wrap">\n' +
            '                                                <input type="text" class="user-website" placeholder="你的网站">\n' +
            '                                            </div>\n' +
            '                                        </div>\n' +
            '                                        <div class="comment-form-text">\n' +
            '                                            <textarea rows="5" class="comment-content"></textarea>\n' +
            '                                        </div>\n' +
            '                                        <div class="comment-form-btn">\n' +
            '                                            <span>Ctrl + 回车 直接提交</span>\n' +
            '                                            <button class="submit-btn">发布评论</button>\n' +
            '                                        </div>\n' +
            '                                    </div>\n' +
            '                                </div>';
        return htmlStr;
    }

    /*
    * 获取文章评论
    *
    * */
    function getArticleComment() {
        var articleId = $("#articleId").val();
        $.ajax({
            url:"comment/list/" + articleId,
            type: "GET",
            success:function (result) {
                renderCommentList(result.result);
            }
        })
    }
    getArticleComment();

    /*
    * 渲染评论列表
    * */
    function renderCommentList(arr) {
        if (Object.prototype.toString.call(arr) !== "[object Array]"){
            return;
        }
        var commentContainer = $("#comment-list");
        var htmlStr = {str:""};
        iretation(arr,htmlStr);
        commentContainer.html(htmlStr.str);
        //迭代拼凑字符串
        function iretation(arr,htmlStr) {
            for (var i = 0; i < arr.length; i++){
                htmlStr.str += '<div class="comment-item">\n' +
                '                   <div class="avatar-wrap left">\n' +
                '                       <div class="avatar"></div>\n' +
                '                   </div>\n' +
                '                   <div class="comment-wrap">\n' +
                '                       <a class="username">' + arr[i]["username"] +'</a>\n' +
                '                       <div class="comment-text">'+ arr[i]["content"] +'</div>\n' +
                '                       <div class="answer-box">\n' +
                '                           <span class="publishTime">'+ $.utils().timeFormat(arr[i]["publishTime"]) +'</span>\n' +
                '                           <a class="reply-btn">回复</a>\n' +
                '                           <input class="commentId" type="hidden" value="'+ arr[i]["id"] +'"/>\n' +
                '                       </div>\n';
                //迭代拼凑子评论
                if(arr[i]["childrenComment"].length > 0){
                    iretation(arr[i]["childrenComment"],htmlStr);
                }
                //加上闭合标签
                htmlStr.str += '    </div>\n' +
                '                </div>';
            }
        }
    }
})