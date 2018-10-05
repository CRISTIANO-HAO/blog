<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE>
<html>
<head>
    <base href="<%=basePath%>">

    <title>早起不吃虫的博客</title>

    <meta http-equiv="keywords" content="早起不吃虫，个人博客, 个人网站,首页, web前端,JavaScript,css,html,Java,MySQL,NodeJs">
    <meta http-equiv="description" content="早起不吃虫的技术博客">
    <meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
    <meta name="keywords" content="早起不吃虫，个人博客, 个人网站,首页, web前端,JavaScript,css,html,Java,MySQL,NodeJs">
    <meta name="author" content="早起不吃虫，豪腾飞，haotengfei">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="shortcut icon" href="<%=basePath %>resource/front/image/favicon.ico" type="image/x-icon" />

    <link rel="stylesheet" href="<%=basePath %>resource/front/css/common.css"/>
    <link rel="stylesheet" href="<%=basePath %>resource/front/css/highlight.css"/>
    <link rel="stylesheet" href="<%=basePath %>resource/front/css/index.css"/>
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
            <div id="column">
                <ul id="column-ul" class="clear">
                    <li class="active">首页</li>
                    <li>热门</li>
                    <li>前端</li>
                    <li>后端</li>
                    <li>扯淡</li>
                    <li>工具</li>
                </ul>
            </div>
            <div id="nav-column" class="clear">
                <div id="logo" class="left">
                    早起不吃虫
                </div>
                <div id="mobile-menu" class="right">
                    <i class="icon"></i>
                </div>
                <nav id="nav">
                    <ul class="clear">
                        <li>
                            <i></i>
                            <span>首页</span>
                        </li>
                        <li>
                            <i></i>
                            <span>热门</span>
                        </li>
                        <li>
                            <i></i>
                            <span>前端</span>
                        </li>
                        <li>
                            <i></i>
                            <span>后端</span>
                        </li>
                        <li>
                            <i></i>
                            <span>扯淡</span>
                        </li>
                        <li>
                            <i></i>
                            <span>工具</span>
                        </li>
                    </ul>
                </nav>
            </div>
            <div id="category-shrink">
                <div class="category-msg">
                    <i class="scale_yaodong"></i>
                    <span>分类</span>
                </div>
                <section class="category-box">
                    <ul class="clear">
                        <c:forEach items="${categories}" var="category">
                            <li class="left">
                                <i class="scale_yaodong"></i>
                                <span>${category.categoryName}</span>
                            </li>
                        </c:forEach>
                    </ul>
                </section>
            </div>
            <div id="search">
                <form onsubmit="return false;">
                    <input id="search-in" type="text" placeholder="搜索">
                    <input id="submit-in" class="scale_yaodong" type="button">
                </form>
            </div>
        </div>
        <div id="content" class="clear">
            <div id="article-list" class="left">
                <div id="article-list-header">
                    <div id="search-param">
                        <span>您搜索的是：</span><span id="search-keyword">前端</span>
                    </div>
                    <div id="category-param">
                        <span>分类：</span><span id="category-keyword">前端</span>
                    </div>
                    <div id="archives-param">
                        <span>归档：</span><span id="archives-keyword">2018-08</span>
                    </div>
                    <div id="nav-param">
                        <span>专栏：</span><span id="nav-keyword">首页</span>
                    </div>
                </div>
                <div id="article-list-container">
                    <%--<div class="article-item">
                        <h3 class="article-title"><a href="<%=basePath%>article/1234567">Javascript深入浅出</a></h3>
                        <div class="article-summary">今天去交警中队接受法律制裁，因为昨天用手机进行了网上预约，在前面排了52号人的情况下直接在窗口把事办了。
                            从公司出发，到最后拿了单子回到公司支付宝交款，居然不到半个小时……
                            穿过旁边塑料椅子上的重重视线享受这莫名其妙的“特权”，真是有点儿魔幻。
                            要知道去年销分的时候中午饭我都没吃去排的队……
                        </div>
                        <div class="article-msg clear">
                            <div class="left">
                                <div class="article-publishTime">2018-05-01 12:20:21</div>
                                <div class="article-tags">
                                    <span class="tag-msg">标签：</span>
                                    <span class="tag-item">js</span>；
                                    <span class="tag-item">入门</span>
                                </div>
                            </div>
                            <div class="right comment-msg" title="评论">
                                <i class="scale_yaodong"></i>
                                <span class="article-commentNum">13</span>
                            </div>
                            <div class="right click-msg" title="阅读量">
                                <i class="scale_yaodong"></i>
                                <span class="article-clickNum">211</span>
                            </div>
                        </div>
                    </div>--%>
                </div>
                <div id="loading">
                    <span class="scale-item"></span>
                    <span class="scale-item"></span>
                    <span class="scale-item"></span>
                    <span class="scale-item"></span>
                    <span class="scale-item"></span>
                </div>
                <div id="loadingCompleted">
                    <i></i>
                    <span>全部加载完成...</span>
                </div>
            </div>
            <div id="article-correlation" class="right">
                <div class="separation-line"></div>
                <div id="category">
                    <div class="category-msg">
                        <i class="scale_yaodong"></i>
                        <span>分类</span>
                    </div>
                    <section class="category-box">
                        <ul class="clear">
                            <c:forEach items="${categories}" var="category">
                                <li class="left">
                                    <i class="scale_yaodong"></i>
                                    <span>${category.categoryName}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </section>
                </div>
                <div class="separation-line"></div>
                <div id="archives">
                    <div class="archives-msg">
                        <i class="scale_yaodong"></i>
                        <span>归档</span>
                    </div>
                    <section class="archives-box">
                        <ul>
                            <c:forEach items="${archives}" var="archive">
                                <li data-timerange="${archive.year}-${archive.month}">
                                    <i class="scale_yaodong"></i>
                                    <span>${archive.year}年${archive.month}月</span>
                                    <span>(${archive.count})</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </section>
                </div>
                <div class="separation-line"></div>
                <div id="comment">
                    <div class="comment-msg">
                        <i class="scale_yaodong"></i>
                        <span>最新评论</span>
                    </div>
                    <section class="comment-box">
                        <ul>
                            <c:choose>
                                <c:when test="${comments.size() > 0}">
                                    <c:forEach items="${comments}" var="comment">
                                        <li>
                                            <p class="comment-content">
                                                <i class="scale_yaodong"></i>
                                                ${comment.content}
                                            </p>
                                            <div class="flex">
                                                <span class="comment-username">发表 -- ${comment.username}</span>
                                                <span class="comment-article"><a target="_blank" href="<%=basePath %>article/${comment.articleId}">${comment.title}</a></span>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <li>
                                        <p>
                                            <i class="scale_yaodong"></i>
                                            暂无最新评论...
                                        </p>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </section>
                </div>
            </div>
        </div>
        <div id="footer">
            <p>Designed & Powerd by cristiano-HAO</p>
            <p>Copyright© 2018 早起不吃虫的博客 </p>
            <p>粤ICP备18104892号</p>
        </div>
    </div>
</div>
<div id="backToTop">
    <div class="top">回到</div>
    <div class="bottom">顶部</div>
</div>
<script src="<%=basePath %>resource/common/js/jquery-2.0.3.js"></script>
<script src="<%=basePath %>resource/front/js/utils.js"></script>
<script src="<%=basePath %>resource/front/js/index.js"></script>
</body>
</html>
