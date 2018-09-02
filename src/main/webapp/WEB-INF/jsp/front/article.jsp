<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ftm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE>
<html>
<head>
    <base href="<%=basePath%>">

    <title>${article.title}</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="早起不吃虫,个人博客,个人网站,首页,web前端,JavaScript,css,html,Java,MySQL,NodeJs,<c:forEach items="${article.tags}" var="tag" varStatus="tagIndex">${tag.tagName},</c:forEach>">
    <meta http-equiv="description" content="早起不吃虫的技术博客">
    <meta name="keywords" content="早起不吃虫，个人博客, 个人网站,首页, web前端,JavaScript,css,html,Java,MySQL,NodeJs,">
    <meta name="author" content="早起不吃虫，豪腾飞，haotengfei">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="shortcut icon" href="<%=basePath %>resource/front/image/favicon.ico" type="image/x-icon" />

    <link rel="stylesheet" href="<%=basePath %>resource/front/css/common.css"/>
    <link rel="stylesheet" href="<%=basePath %>resource/front/css/highlight.css"/>
    <link rel="stylesheet" href="<%=basePath %>resource/front/css/article.css"/>
    <script type="text/javascript" defer>
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?0d4eba17fe032a7fa1c873a28dbc4f36";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <!--[if gt IE 10]> IE10以上版本可识别<![endif]-->
</head>
<body>
<div id="container">
    <div id="container-inner">
        <div id="header">
            <div id="article-msg">
                <div><a href="">早起不吃虫</a></div>
            </div>
        </div>
        <div id="content">
            <div id="article-detail">
                <div class="article-category clear">
                    <div class="category-detail left">分类：
                        <c:forEach items="${article.categories}" var="category" varStatus="categoryIndex">
                            <c:choose>
                                <c:when test="${(article.categories.size()-1) != categoryIndex.index}">
                                    <span>${category.categoryName}</span>；
                                </c:when>
                                <c:otherwise>
                                    <span>${category.categoryName}</span>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="prevAndNext right">
                        <div class="prevArticle">上一篇：
                            <c:choose>
                                <c:when test="${article.prevArticleId != ''}">
                                    <a href="article/${article.prevArticleId}">${article.prevTitle}</a>
                                </c:when>
                                <c:otherwise>没有上一篇文章了</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="nextArticle">下一篇：
                            <c:choose>
                                <c:when test="${article.nextArticleId != ''}">
                                    <a href="article/${article.nextArticleId}">${article.nextTitle}</a>
                                </c:when>
                                <c:otherwise>没有下一篇文章了</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <h1 class="article-title">
                    ${article.title}
                    <input type="hidden" id="articleId" value="${article.articleId}">
                </h1>
                <div class="article-tag">
                    <div class="article-writer clear">
                        <div class="left">作者：早起不吃虫</div>
                        <div class="right">日期：<ftm:formatDate value="${article.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                    </div>
                    <div>标签：
                        <c:forEach items="${article.tags}" var="tag" varStatus="tagIndex">
                            <c:choose>
                                <c:when test="${(article.tags.size()-1) != tagIndex.index}">
                                    <span>${tag.tagName}；</span>
                                </c:when>
                                <c:otherwise>
                                    <span>${tag.tagName}</span>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                </div>
                <div class="markdown highlight">
                    ${article.htmlContent}
                </div>
            </div>
            <div id="comment">
                <div id="rootEditor" class="comment-form">
                    <div class="tip">标红项必填或不合法</div>
                    <div class="avatar-wrap left">
                        <div class="avatar"></div>
                    </div>
                    <div class="comment-form-info clear">
                        <div class="comment-form-input">
                            <div class="input-wrap">
                                <input type="text" class="username" placeholder="您的名称">
                            </div>
                            <div class="input-wrap">
                                <input type="email" class="user-email" placeholder="您的邮箱">
                            </div>
                            <div class="input-wrap">
                                <input type="text" class="user-website" placeholder="您的博客网址">
                            </div>
                        </div>
                        <div class="comment-form-text">
                            <%--<textarea rows="5" class="comment-content"></textarea>--%>
                        </div>
                        <div class="comment-form-btn">
                            <span>Ctrl + 回车 直接提交</span>
                            <button class="submit-btn">发布评论</button>
                        </div>
                    </div>
                </div>
                <div id="comment-list">
                    <div class="nothing">暂无相关评论...</div>
                    <%--<div class="comment-item">
                        <div class="avatar-wrap left">
                            <div class="avatar"></div>
                        </div>
                        <div class="comment-wrap">
                            <a class="username">瑞尔斯</a>
                            <div class="comment-text">
                                福州这边 有福州交警 app，可以在线预约，免扣 分。然后通过12123app在线交款，神奇的逻辑
                            </div>
                            <div class="answer-box">
                                <span class="publishTime">2018-05-06 08:09:23</span>
                                <a class="reply-btn">回复</a>
                                <div class="comment-form">
                                    <div class="avatar-wrap left">
                                        <div class="avatar"></div>
                                    </div>
                                    <div class="comment-form-info clear">
                                        <div class="comment-form-input">
                                            <div class="input-wrap">
                                                <input type="text" class="username" placeholder="您的名称">
                                            </div>
                                            <div class="input-wrap">
                                                <input type="text" class="user-email" placeholder="您的邮箱">
                                            </div>
                                            <div class="input-wrap">
                                                <input type="text" class="user-website" placeholder="你的网站">
                                            </div>
                                        </div>
                                        <div class="comment-form-text">
                                            <textarea rows="5" class="comment-content"></textarea>
                                        </div>
                                        <div class="comment-form-btn">
                                            <span>Ctrl + 回车 直接提交</span>
                                            <button class="submit-btn">发布评论</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="comment-item">
                                <div class="avatar-wrap left">
                                    <div class="avatar"></div>
                                </div>
                                <div class="comment-wrap">
                                    <a class="username">瑞尔斯</a>
                                    <div class="comment-text">
                                        福州这边 有福州交警 app，可以在线预约，免扣 分。然后通过12123app在线交款，神奇的逻辑
                                    </div>
                                    <div class="answer-box">
                                        <span class="publishTime">2018-05-06 08:09:23</span>
                                        <a class="reply-btn">回复</a>
                                    </div>
                                    <div class="comment-item">
                                        <div class="avatar-wrap left">
                                            <div class="avatar"></div>
                                        </div>
                                        <div class="comment-wrap">
                                            <a class="username">瑞尔斯</a>
                                            <div class="comment-text">
                                                福州这边 有福州交警 app，可以在线预约，免扣 分。然后通过12123app在线交款，神奇的逻辑
                                            </div>
                                            <div class="answer-box">
                                                <span class="publishTime">2018-05-06 08:09:23</span>
                                                <a class="reply-btn">回复</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="comment-item">
                                <div class="avatar-wrap left">
                                    <div class="avatar"></div>
                                </div>
                                <div class="comment-wrap">
                                    <a class="username">瑞尔斯</a>
                                    <div class="comment-text">
                                        福州这边 有福州交警 app，可以在线预约，免扣 分。然后通过12123app在线交款，神奇的逻辑
                                    </div>
                                    <div class="answer-box">
                                        <span class="publishTime">2018-05-06 08:09:23</span>
                                        <a class="reply-btn">回复</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="comment-item">
                        <div class="avatar-wrap left">
                            <div class="avatar"></div>
                        </div>
                        <div class="comment-wrap">
                            <a class="username">瑞尔斯</a>
                            <div class="comment-text">
                                福州这边 有福州交警 app，可以在线预约，免扣 分。然后通过12123app在线交款，神奇的逻辑
                            </div>
                            <div class="answer-box">
                                <span class="publishTime">2018-05-06 08:09:23</span>
                                <a class="reply-btn">回复</a>
                            </div>
                        </div>
                    </div>--%>
                </div>
                <div id="comment-footer"></div>
            </div>
        </div>
        <div id="footer">
            <p>Designed & Powerd by cristiano-HAO</p>
            <p>Copyright© 2018 早起不吃虫的博客 </p>
            <p>粤ICP备18104892号</p>
        </div>
    </div>
</div>
<div id="mask">
    <div class="spinner">
        <div class="spinner-container container1">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
        <div class="spinner-container container2">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
        <div class="spinner-container container3">
            <div class="circle1"></div>
            <div class="circle2"></div>
            <div class="circle3"></div>
            <div class="circle4"></div>
        </div>
    </div>
    <div class="tip-text"></div>
</div>
<div id="backToTop">
    <div class="top">回到</div>
    <div class="bottom">顶部</div>
</div>
<div id="catalog">
    <p>文章目录</p>
    <div id="catalog-content"></div>
</div>
<script type="text/javascript" src="<%=basePath %>resource/common/js/jquery-2.0.3.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/common/js/wangEditor.min.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/front/js/utils.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/front/js/editor.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/front/js/article.js"></script>
</body>
</html>