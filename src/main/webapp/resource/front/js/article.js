$(document).ready(function () {
    /*
    * 回到顶部事件监听
    * */
    utils.backToTop && utils.backToTop();
    /*
    * 定义评论富文本对象全局容器
    * */
    var allEditorContaintor = {
        rootEditor: new editor('#rootEditor .comment-form-text')
    };

    /*
    * 删除多余富文本对象
    *
    * */
    function deleteEditor() {
        for (key in allEditorContaintor) {
            //保留根评论框对象
            if (key !== "rootEditor") {
                delete allEditorContaintor[key];
            }
        }
    }

    /*
    * 初始加载
    *
    * */
    {
        //从cookie取出评论信息
        var rootForm = $('#rootEditor');
        rootForm.find('.username').val(utils.cookie.getCookie("username"));
        rootForm.find('.user-email').val(utils.cookie.getCookie("email"));
        rootForm.find('.user-website').val(utils.cookie.getCookie("website"));
        //获取文章评论列表
        getArticleComment();
    }

    /*
    * 点击提交评论
    *
    * */
    $("#comment").on("click", ".submit-btn", function (e) {
        var commentForm = $(this).closest(".comment-form");
        var editor = allEditorContaintor[commentForm.attr("id")];
        var isReply = !commentForm.attr("id");
        var pid = commentForm.find(".commentId").val() || 0;
        var username = commentForm.find(".username").val();
        var email = commentForm.find(".user-email").val();
        var website = commentForm.find(".user-website").val();
        var content = editor.txt.html();
        var articleId = $("#articleId").val();

        var data = {
            pid: pid,
            username: username,
            website: website,
            email: email,
            content: content,
            articleId: articleId
        };

        //校验评论信息
        if (!msgValidate(data, commentForm)) {
            //提示信息显示
            commentForm.find(".tip").show();
            return;
        } else {
            commentForm.find(".tip").hide();
        }

        $.ajax({
            type: "POST",
            url: "comment/submit",
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            beforeSend: function () {
                $('#mask').show();
            },
            data: JSON.stringify(data),
            success: function (result) {
                if (result.success && result.status === 200) {
                    //清空评论内容
                    commentForm.find(".comment-form-text .w-e-text").html("");
                    //设置评论的cookie信息
                    utils.cookie.setCookie('username', data.username);
                    utils.cookie.setCookie('email', data.email);
                    utils.cookie.setCookie('website', data.website);
                    //渲染评论列表
                    getArticleComment();
                    //删除多余的评论富文本对象
                    deleteEditor();
                } else {
                    alert("发表评论失败！")
                }
            }
        }).always(function () {
            $('#mask').hide();
        });
    });

    /*
    * CTRL + 回车键发布评论
    *
    * */
    $("body").on("keypress", ".comment-form .comment-content", function (e) {
        if (e.ctrlKey && (e.which == 13 || e.which == 10)) {
            var commentForm = $(this).closest(".comment-form");
            commentForm.find(".submit-btn").trigger("click");
        }
    })

    /*
    * 评论信息校验
    *
    * */
    function msgValidate(data, self) {
        var url_reg = new RegExp("^[A-Za-z]+://[A-Za-z0-9-_]+\\.[A-Za-z0-9-_%&\?\/.=]+[A-Za-z0-9-_%&\?\/.=#]+?$");
        var email_reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
        //判断是否全部符合校验要求
        var allIsValidate = true;

        //非空校验
        if (data.username === "") {
            self.find(".username").addClass("isEmpty");
            allIsValidate = false;
        } else {
            self.find(".username").removeClass("isEmpty");
        }
        if (data.email === "" || !email_reg.test(data.email)) {
            self.find(".user-email").addClass("isEmpty");
            allIsValidate = false;
        } else {
            self.find(".user-email").removeClass("isEmpty");
        }
        //匹配标签之间有一段文字的字符串；或者是纯文字无标签;或者纯表情包
        if (/(?=>[^<>/]+<)/g.test(data.content) || /(?!^\s+$)^[^<>/]+$/g.test(data.content) || /<\s*img\s+[^<>]+>/.test(data.content)) {
            self.find(".comment-form-text").removeClass("isEmpty");
        } else {
            self.find(".comment-form-text").addClass("isEmpty");
            allIsValidate = false;
        }

        //当网址不为空时，校验其准确性
        if (data.website && !url_reg.test(data.website)) {
            self.find(".user-website").addClass("isEmpty");
            allIsValidate = false;
        } else {
            self.find(".user-website").removeClass("isEmpty");
        }

        return allIsValidate;
    }

    /*
    * 点击打开评论框
    * 
    * */
    $("#comment").on("click", ".comment-item .reply-btn", function () {
        var self = $(this);
        var answerBox = self.closest(".answer-box");
        //返回评论回复框信息
        var commentBoxObj = patchAnswerBox(answerBox);
        if (answerBox.find(".comment-form").length == 0) {
            answerBox.append(commentBoxObj.htmlStr);
            //创建评论富文本对象
            allEditorContaintor[commentBoxObj.editorId] = new editor("#" + commentBoxObj.editorId + " .comment-form-text");
            self.html("取消");
        } else {
            //删除创建的评论富文本对象
            delete allEditorContaintor[answerBox.find(".comment-form").attr("id")];
            answerBox.find(".comment-form").remove();
            self.html("回复");
        }
    });

    /*
    * 拼凑回复框
    *
    * */
    function patchAnswerBox(answerBox) {
        var obj = {
            htmlStr: "",
            editorId: "editor" + Math.ceil(100000000 * Math.random())
        }
        obj.htmlStr += '<div id="' + obj.editorId + '" class="comment-form">\n' +
            '                                    <div class="avatar-wrap left">\n' +
            '                                        <div class="avatar"></div>\n' +
            '                                    </div>\n' +
            '                                    <div class="comment-form-info clear">\n' +
            '                                        <div class="tip">标红项必填或不合法</div>\n' +
            '                                        <div class="comment-form-input">\n' +
            '                                            <div class="input-wrap">\n' +
            '                                                <input class="commentId" type="hidden" value="' + answerBox.find(".commentId").val() + '"/>\n' +
            '                                                <input type="text" class="username" value="' + utils.cookie.getCookie("username") + '" placeholder="您的名称">\n' +
            '                                            </div>\n' +
            '                                            <div class="input-wrap">\n' +
            '                                                <input type="text" class="user-email" value="' + utils.cookie.getCookie("email") + '" placeholder="您的邮箱">\n' +
            '                                            </div>\n' +
            '                                            <div class="input-wrap">\n' +
            '                                                <input type="text" class="user-website" value="' + utils.cookie.getCookie("website") + '" placeholder="您的博客网址">\n' +
            '                                            </div>\n' +
            '                                        </div>\n' +
            '                                        <div class="comment-form-text">\n' +
            // '                                            <textarea rows="5" class="comment-content"></textarea>\n' +
            '                                        </div>\n' +
            '                                        <div class="comment-form-btn">\n' +
            '                                            <span>Ctrl + 回车 直接提交</span>\n' +
            '                                            <button class="submit-btn">发布评论</button>\n' +
            '                                        </div>\n' +
            '                                    </div>\n' +
            '                                </div>';
        return obj;
    }

    /*
    * 获取文章评论
    *
    * */
    function getArticleComment() {
        var articleId = $("#articleId").val();
        $.ajax({
            url: "comment/list/" + articleId,
            type: "GET",
            success: function (result) {
                renderCommentList(result.result);
            }
        })
    }

    /*
    * 渲染评论列表
    * */
    function renderCommentList(arr) {
        if (Object.prototype.toString.call(arr) !== "[object Array]") {
            return;
        }
        var commentContainer = $("#comment-list");
        var htmlStr = {str: ""};
        if (arr.length > 0) {
            iretation(arr, htmlStr);
        } else {
            htmlStr += '<div class="nothing">暂无相关评论...</div>';
        }

        commentContainer.html(htmlStr.str);

        //迭代拼凑字符串
        function iretation(arr, htmlStr) {
            for (var i = 0; i < arr.length; i++) {
                htmlStr.str += '<div class="comment-item">\n' +
                    '                   <div class="avatar-wrap left">\n' +
                    '                       <div class="avatar"></div>\n' +
                    '                   </div>\n' +
                    '                   <div class="comment-wrap">\n' +
                    ( arr[i]["website"] ? ('<a class="username hasWebsite" target="_blank" href="'+ arr[i]["website"] +'">' + arr[i]["username"] + '</a>\n') :
                    ('                       <a class="username" >' + arr[i]["username"] + '</a>\n') ) +
                    '                       <div class="comment-text">' + arr[i]["content"] + '</div>\n' +
                    '                       <div class="answer-box">\n' +
                    '                           <span class="publishTime">' + $.utils().timeFormat(arr[i]["publishTime"]) + '</span>\n' +
                    '                           <a class="reply-btn">回复</a>\n' +
                    '                           <input class="commentId" type="hidden" value="' + arr[i]["id"] + '"/>\n' +
                    '                       </div>\n';
                //迭代拼凑子评论
                if (arr[i]["childrenComment"].length > 0) {
                    iretation(arr[i]["childrenComment"], htmlStr);
                }
                //加上闭合标签
                htmlStr.str += '    </div>\n' +
                    '                </div>';
            }
        }
    }

    /*
    * 生成文章目录
    * */
    utils.renderCatalog.init("markdown-body","catalog-content");
    //解决IOS移动端无法触发 :hover 的问题
    document.body.addEventListener('touchstart', function(){ });
})