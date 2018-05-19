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

    <title>My Admination</title>

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
            <div id="search">
                <form>
                    <input id="search-in" type="text" placeholder="搜索">
                    <input id="submit-in" type="submit" value="">
                </form>
            </div>
        </div>
        <div id="content" class="clear">
            <div id="article-list" class="left">
                <div class="article-item">
                    <h3 class="article-title">Javascript深入浅出</h3>
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
                            <i></i>
                            <span class="article-commentNum">13</span>
                        </div>
                        <div class="right click-msg" title="阅读量">
                            <i></i>
                            <span class="article-clickNum">211</span>
                        </div>
                    </div>
                </div>
                <div class="article-item" >
                    <h3 class="article-title">Javascript深入浅出</h3>
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
                            <i></i>
                            <span class="article-commentNum">13</span>
                        </div>
                        <div class="right click-msg" title="阅读量">
                            <i></i>
                            <span class="article-clickNum">211</span>
                        </div>
                    </div>
                </div>
                <div class="article-item">
                    <h3 class="article-title">Javascript深入浅出</h3>
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
                            <i></i>
                            <span class="article-commentNum">13</span>
                        </div>
                        <div class="right click-msg" title="阅读量">
                            <i></i>
                            <span class="article-clickNum">211</span>
                        </div>
                    </div>
                </div>
                <div class="article-item">
                    <h3 class="article-title">Javascript深入浅出</h3>
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
                            <i></i>
                            <span class="article-commentNum">13</span>
                        </div>
                        <div class="right click-msg" title="阅读量">
                            <i></i>
                            <span class="article-clickNum">211</span>
                        </div>
                    </div>
                </div>
                <div class="article-item">
                    <h3 class="article-title">Javascript深入浅出</h3>
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
                            <i></i>
                            <span class="article-commentNum">13</span>
                        </div>
                        <div class="right click-msg" title="阅读量">
                            <i></i>
                            <span class="article-clickNum">211</span>
                        </div>
                    </div>
                </div>
            </div>
            <div id="article-correlation" class="right">
                <div id="category">
                    <div class="category-msg">
                        <i></i>
                        <span>分类</span>
                    </div>
                    <section id="category-box">
                        <ul class="clear">
                            <li class="left">
                                <i></i>
                                <span>Javascript</span>
                            </li>
                            <li class="left">
                                <i></i>
                                <span>CSS</span>
                            </li>
                            <li class="left">
                                <i></i>
                                <span>HTML5</span>
                            </li>
                            <li class="left">
                                <i></i>
                                <span>Java</span>
                            </li>
                            <li class="left">
                                <i></i>
                                <span>Spring</span>
                            </li>
                            <li class="left">
                                <i></i>
                                <span>MyBatis</span>
                            </li>
                        </ul>
                    </section>
                </div>
            </div>
        </div>
        <div id="footer"></div>
    </div>
</div>
</body>
</html>
