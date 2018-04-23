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
    <!-- font-Awesome -->
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath %>resource/common/css/common.css"/>
    <link rel="stylesheet" href="<%=basePath %>resource/back/css/index.css"/>

</head>

<body>
<div class="wrapper">
    <header class="clear">
        <div class="head-left left">
            <span>Hello Mr.HAO</span>
        </div>
        <div class="head-right">
            <div class="left">
                <span>图标</span>
            </div>
            <div class="right">
                <span>文章管理系统</span>
            </div>
        </div>
    </header>
    <aside class="main-left left">
        <div class="user-panel clear">
            <div class="left">
                <img src="resource/back/img/user.png">
            </div>
            <div class="right">
                <p>CRISTIANO</p>
                <p>早起不吃虫</p>
            </div>
        </div>
        <div class="search-bar">
            <form action="admin/article/list/page/1" method="post">
                <input type="text" placeholder="Search..." value="${searchParam}" name="searchParam">
                <button type="submit"><i class="fa fa-search"></i></button>
            </form>
        </div>
    </aside>
    <div class="main-right">
        <h3>文章列表</h3>
        <section class="content">
            <div class="box">
                <div class="box-header with-border">
                    <h3 class="box-title">Bordered Table</h3>
                </div>
                <div class="box-body">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>文章标题</th>
                            <th>文章标签</th>
                            <th>文章编辑</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${articleList}" var="article" varStatus="status">
                            <tr>
                                <td>${(page.pageIndex - 1) * page.pageSize + status.index + 1}</td>
                                <td>${article.title}</td>
                                <td>
                                    <c:forEach items="${article.categories}" var="category" varStatus="categoryIndex" >
                                        <c:if test="${categoryIndex.index < (article.categories.size() - 1)}">
                                            <span>${category.categoryName} ;</span>
                                        </c:if>
                                        <c:if test="${categoryIndex.index == (article.categories.size() - 1)}">
                                            <span>${category.categoryName}</span>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <div>
                                        <a href="<%=basePath %>admin/article/get/${article.articleId}">
                                            <span>编辑</span>
                                            <i class="fa fa-eraser"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${articleList.size() == 0}">
                        <div class="noContent">It is over  !!</div>
                    </c:if>
                </div>
                <div class="box-footer clear">
                    <ul id="pagination" class="pagination clear right">
                        <li><a href="#">«</a></li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">»</a></li>
                    </ul>
                </div>
            </div>
        </section>
    </div>
    <footer></footer>
</div>
<script src="<%=basePath %>resource/common/js/jquery-2.0.3.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/back/js/page.js"></script>
<script type="text/javascript">
    pagePagination({
        pageIndex:"${page.pageIndex}",
        pageNum: "${page.totalPages}",
        target:"#pagination",
        url:"<%=basePath %>admin/article/list/page/",
        searchParam : "${searchParam}",
    });

    $.ajax({
        url: "admin/article/list/page/1",
        type:"POST",
        contentType: "application/x-www-form-urlencoded",
        data : {
            // pageSize: 10,
            // searchParam: "00",
        },
        success: function (result) {
            console.log(result);
        }
    })
</script>
</body>
</html>
