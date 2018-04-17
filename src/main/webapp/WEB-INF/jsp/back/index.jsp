<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="<%=basePath %>resource/back/css/index.css"/>

</head>

<body>
<div class="wrapper">
    <header class="clear">
        <div class="head-left left">
            <span>HELLO Mr.HAO</span>
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
            <input type="text" placeholder="Search...">
            <button><i class="fa fa-search"></i></button>
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
                            <th style="width: 10px">#</th>
                            <th>Task</th>
                            <th>Progress</th>
                            <th style="width: 40px">Label</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1.</td>
                            <td>Update software</td>
                            <td>
                                <div class="progress progress-xs">
                                    <div class="progress-bar progress-bar-danger" style="width: 55%"></div>
                                </div>
                            </td>
                            <td><span class="badge bg-red">55%</span></td>
                        </tr>
                        <tr>
                            <td>1.</td>
                            <td>Update software</td>
                            <td>
                                <div class="progress progress-xs">
                                    <div class="progress-bar progress-bar-danger" style="width: 55%"></div>
                                </div>
                            </td>
                            <td><span class="badge bg-red">55%</span></td>
                        </tr>
                        <tr>
                            <td>1.</td>
                            <td>Update software</td>
                            <td>
                                <div class="progress progress-xs">
                                    <div class="progress-bar progress-bar-danger" style="width: 55%"></div>
                                </div>
                            </td>
                            <td><span class="badge bg-red">55%</span></td>
                        </tr>
                        </tbody>
                    </table>
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
        pageIndex:2,
        pageNum: 8,
        target:"#pagination"
    });

    $.ajax({
        url: "admin/article/list/page/1",
        type:"POST",
        //contentType: "application/json",
        contentType: "application/x-www-form-urlencoded",
        data : {
            pageSize: 10,
            searchParam: "00",
        },
        success: function (result) {
            console.log(result)
        }
    })
</script>
</body>
</html>
