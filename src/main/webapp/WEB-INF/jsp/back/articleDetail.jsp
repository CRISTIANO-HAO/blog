<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh">
    <head>
    	<base href="<%=basePath%>">
        <meta charset="utf-8" />
        <title>Simple example - Editor.md examples</title>
        <link rel="stylesheet" href="<%=basePath %>resource/markdown/css/editormd.css" />
        <link rel="stylesheet" href="<%=basePath %>resource/common/css/common.css"/>
        <link rel="stylesheet" href="<%=basePath %>resource/back/css/articleDetail.css" />
        <link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon" />
    </head>
    <body>
        <header class="clear">
            <div class="head-left left">
                <a href="javascript:location.href = document.referrer"><span>Hello Mr.HAO</span></a>
            </div>
            <div class="head-right">
                <div class="left">
                    <span></span>
                </div>
                <div class="right">
                    <span>文章管理系统</span>
                </div>
            </div>
        </header>
        <main>
            <div class="content">
                ${article.htmlContent}
            </div>
            <div class="comment">
                <h4>全部留言</h4>
                <div id="commentTree">
                    <div class="comment-item clear">
                        <div class="user-profile">
                            <a>
                                <img src="<%=basePath %>resource/back/img/visitor.jpg">
                            </a>
                        </div>
                        <div class="comment-main">
                            <div class="comment-msg clear">
                                <div class="user-msg left">
                                    <a class="user-name" href="/admin">早起不吃虫</a>
                                    <span class="comment-time">2018-05-01 18:17:30</span>
                                </div>
                                <div class="agree-disagree right">
                                    <i class="fa fa-thumbs-up">(10)</i>
                                    <i class="fa fa-thumbs-down">(0)</i>
                                    <span class="return-comment">回复</span>
                                </div>
                            </div>
                            <div class="comment-content">
                                <p>这是一条无聊的评论。。。。</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <textarea rows="4" id="msgContent"></textarea>
                    <div class="clear">
                        <button type="button" id="sendMsg">留言</button>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>