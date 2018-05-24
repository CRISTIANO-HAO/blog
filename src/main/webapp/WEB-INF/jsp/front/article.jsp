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

    <title>博客</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">

    <link rel="stylesheet" href="<%=basePath %>resource/front/css/common.css"/>
    <link rel="stylesheet" href="<%=basePath %>resource/front/css/index.css"/>

</head>
<body>
<div id="container">
    <div id="container-inner">
        <div id="header">
            <div id="column">
                <ul id="column-ul" class="clear">
                    <li id="homepage">首页</li>
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
                        <li class="left">
                            <i class="scale_yaodong"></i>
                            <span>Javascript</span>
                        </li>
                        <li class="left">
                            <i class="scale_yaodong"></i>
                            <span>CSS</span>
                        </li>
                        <li class="left">
                            <i class="scale_yaodong"></i>
                            <span>HTML5</span>
                        </li>
                        <li class="left">
                            <i class="scale_yaodong"></i>
                            <span>Java</span>
                        </li>
                        <li class="left">
                            <i class="scale_yaodong"></i>
                            <span>Spring</span>
                        </li>
                        <li class="left">
                            <i class="scale_yaodong"></i>
                            <span>MyBatis</span>
                        </li>
                    </ul>
                </section>
            </div>
            <div id="search">
                <form>
                    <input id="search-in" type="text" placeholder="搜索">
                    <input id="submit-in" class="scale_yaodong" type="submit" value="">
                </form>
            </div>
        </div>
        <div id="content">
            <div id="article-detail"></div>
            <div id="comment">
                <div class="comment-form">
                    <div class="avatar-wrap left">
                        <div class="avatar"></div>
                    </div>
                    <div class="comment-form-info clear">
                        <div class="comment-form-input">
                            <div class="input-wrap">
                                <input type="text">
                            </div>
                            <div class="input-wrap">
                                <input type="text">
                            </div>
                            <div class="input-wrap">
                                <input type="text">
                            </div>
                        </div>
                        <div class="comment-form-text">
                            <textarea rows="5"></textarea>
                        </div>
                        <div class="comment-form-btn">
                            <span>Ctrl + 回车 直接提交</span>
                            <button>发布评论</button>
                        </div>
                    </div>
                </div>
                <div id="comment-list">
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
                <div id="comment-footer"></div>
            </div>
        </div>
        <div id="footer"></div>
    </div>
</div>
<script src="<%=basePath %>resource/common/js/jquery-2.0.3.js"></script>
<script src="<%=basePath %>resource/front/js/index.js"></script>
</body>
</html>