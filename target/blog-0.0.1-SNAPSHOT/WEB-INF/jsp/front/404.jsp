<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
        <base href="<%=basePath%>">

        <title>早起不吃虫的博客</title>
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
      <link rel="shortcut icon" href="<%=basePath %>resource/front/image/favicon.ico" type="image/x-icon" />
      <!--
      <link rel="stylesheet" type="text/css" href="styles.css">
      -->
      <script type="text/javascript" src="<%=basePath %>resource/common/js/jquery-2.0.3.js"></script>
  </head>
  
  <body>
    <h1>无法找到相关页面</h1>
  </body>
</html>
