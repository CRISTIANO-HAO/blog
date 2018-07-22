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

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="shortcut icon" href="<%=basePath %>resource/front/image/favicon.ico" type="image/x-icon" />

    <link rel="stylesheet" href="<%=basePath %>resource/front/css/login.css" type="text/css" />

</head>
<body>
<h1>早起不吃虫的博客</h1>

<h2>Log in to your Account</h2>
<div class="containeragileits">
    <form onsubmit="return login()">
        <input type="text" id="username" Name="username" placeholder="ACCOUNT" required="">
        <input type="password" id="password" Name="password" placeholder="PASSWORD" required="">
        <ul class="agileinfotickwthree">
            <li>
                <input type="checkbox" id="rememberMe">
                <label for="rememberMe"><span></span>Remember me</label>
            </li>
        </ul>
        <div class="aitssendbuttonw3ls">
            <input type="submit" value="LOGIN">
            <p><a href="#">REGISTER NEW ACCOUNT <span>→</span></a></p>
            <div class="clear"></div>
        </div>
    </form>
</div>

<div class="w3footeragile">
    <p> &copy; 2018 Sleek Login Form. All Rights Reserved | Design by <a href="" target="_blank">早起不吃虫的博客</a></p>
</div>
<script src="<%=basePath %>resource/common/js/jquery-2.0.3.js"></script>
<script>
    function login() {
        $.ajax({
            url:"login",
            type:"POST",
            data:JSON.stringify({
                username: $("#username").val(),
                password: $("#password").val(),
                rememberMe: $("#rememberMe").is(":checked")
            }),
            contentType: "application/json;charset=UTF-8",
            success:function (result) {
                if (result.status === 200){
                    location.href = "admin";
                }else {
                    alert("密码或者账号错误！")
                }
            },
            error:function (err) {
                console.log(err)
            }
        });
        return false;
    }
</script>
</body>
</html>