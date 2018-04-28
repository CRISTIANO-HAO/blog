<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath %>resource/common/js/jquery-2.0.3.js"></script>
  </head>
  
  <body>
    This is my JSP page. <br>
    <h1>验证MVC参数传递</h1>
 
    	<input type="text" name="title" placeholder="请输入标题"><br>
    	<input type="text" name="categoryName" placeholder="请输入标签名"><br>
    	<input type="text" name="categoryName" placeholder="请输入标签名"><br>
    	<input type="text" name="categoryName" placeholder="请输入标签名"><br>
    	<button id="button">提交</button>

    <script type="text/javascript">
    	
    	$('#button').click(function(){
    		
    		$.ajax({
	    		url: '<%=basePath %>article/addArticleAndTag',
	    		type: 'POST',
	    		contentType:'application/json',
	    		data:JSON.stringify({title: "你好啊"}),
	    		success: function(result){
	    			console.log(result)
	    		}
	    	})
    	})
    </script>
  </body>
</html>
