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
        <link rel="stylesheet" href="<%=basePath %>resource/back/css/articleEdit.css" />
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
            <div class="article-title clear">
                <div class="btnDiv">
                    <button id="addBtn" type="button">新建</button>
                    <button id="publishBtn" type="button">发布</button>
                </div>
                <div class="left">
                    <div>
                        <h3>文章标题</h3>
                        <input type="text" name="title" value="${article.title}">
                    </div>
                    <div class="categoryDiv">
                        <h3>文章分类</h3>
                        <div>
                            <div class="categoryList"> </div>
                        </div>
                        <div class="categoryUl">
                            <ul class="hide">
                                <c:forEach items="${categories}" var="category">
                                    <li>
                                        <span> ${category.categoryName}</span>
                                        <input type="hidden" name="categoryId" value="${category.categoryId}" disabled>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="right">
                    <div class="columnDiv">
                        <h3>文章专栏</h3>
                        <div>
                            <div class="columnList"> </div>
                        </div>
                        <div class="columnUl">
                            <ul class="hide">
                                <c:forEach items="${columns}" var="column">
                                    <li>
                                        <span> ${column.columnName}</span>
                                        <input type="hidden" name="columnId" value="${column.columnId}" disabled>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div class="tagDiv">
                        <h3>文章标签</h3>
                        <input type="text" name="tags" placeholder="不同标签请用符号分隔">
                    </div>
                </div>
            </div>
            <div id="layout">
                <h3>文章正文</h3>
                <div id="test-editormd">
                    <textarea style="display:none;" name="markdownContent"></textarea>
                </div>
            </div>
            <div class="article-summary">
                <h3>文章摘要</h3>
                <div id="summaryContent">
                    <textarea rows="5" name="summaryMarkdownContent"></textarea>
                </div>
            </div>
        </main>

        <script src="<%=basePath %>resource/common/js/jquery-2.0.3.js"></script>
        <script src="<%=basePath %>resource/markdown/editormd.min.js"></script>
        <script type="text/javascript">
			var testEditor;
            //markdown插件的初始化
            $(function() {
                testEditor1 = editormd("test-editormd", {
                    width   : "90%",
                    height  : 640,
                    syncScrolling : "single",
                    saveHTMLToTextarea : true,    // 保存 HTML 到 Textarea
                    path    : "<%=basePath %>resource/markdown/lib/"
                });

                testEditor2 = editormd("summaryContent", {
                    width   : "90%",
                    height  : 300,
                    syncScrolling : "single",
                    saveHTMLToTextarea : true,    // 保存 HTML 到 Textarea
                    path    : "<%=basePath %>resource/markdown/lib/"
                });
            });

            //监听标签框的失焦点事件
            $('input[name = tags]').on("blur",function () {
                var val = $(this).val().trim();
                //匹配不是中文，字母，数字跟空格的字符，也就是匹配标点符号
                var reg = /[^\u4E00-\u9FA5\w\s]/g;
                if(val){
                    //用中文的分号分隔
                    val = val.replace(reg,"；");
                    //把重复的间隔符号去掉
                    val = val.replace(/；+/g,"；");
                    if (val[0] == "；"){
                        val = val.slice(1);
                    }
                    $(this).val(val);
                }
            });

            //监听标题输入框的失焦事件
            $('input[name = title]').on("blur",function () {
                var val = $(this).val().trim();
                if(val){
                    $.ajax({
                        url: "<%=basePath %>" + "admin/article/title/ifexist",
                        type: "POST",
                        contentType: "application/x-www-form-urlencoded",
                        data: {
                            title: val
                        },
                        success: function (result) {
                            console.log(result);
                            if (result.result.ifExist){
                                alert("文章标题已经存在！！")
                            }
                        }
                    })
                }
            })

            //点击新增文章
            $('#addBtn').click(function(){
                //拼凑分类字段
                var categories = [];
                var categoriesInput = $('input[name = categoryId][disabled != disabled]');
                categoriesInput.each(function () {
                    var id = $(this).val();
                    categories.push({categoryId:id});
                });

                //拼凑分类字段
                var columns = [];
                var columnsInput = $('input[name = columnId][disabled != disabled]');
                columnsInput.each(function () {
                    var id = $(this).val();
                    columns.push({columnId:id});
                });

                //拼凑标签字段
                var tags  = [];
                var tagsInputArr = $('input[name = tags]').val().split("；");
                tagsInputArr.forEach(function (value) {
                    var tagName = value;
                    //防止空字符串
                    if (tagName){
                        tags.push({tagName:tagName});
                    }
                });

                //封装文章的所有数据
                var data = {
                    articleId : "${article.articleId}",
                    title: $('input[name = title]').val(),
                    markdownContent: testEditor1.getMarkdown(),
                    htmlContent: $("#test-editormd .editormd-preview").html(),
                    summaryMarkdownContent: testEditor2.getMarkdown(),
                    summaryHtmlContent: $("#summaryContent .editormd-preview").html(),
                    categories:categories,
                    tags: tags,
                    columns:columns
                };

                console.log(data)

                //新增文章的请求
                $.ajax({
                    type: "POST",
                    url: "admin/article/add",
                    contentType: "application/json",
                    data:JSON.stringify(data),
                    success: function(result){
                        console.log(result);
                        alert(result.result);
                    },
                });
        	});
            
            //点击发布文章
            $('#publishBtn').click(function () {
                $.ajax({
                    url: "<%=basePath %>" + "admin/article/publish",
                    type:"GET",
                    data: {
                        articleId: "",
                    },
                    success: function () {

                    }
                })
            })

            //文章分类的显示隐藏
            $('.categoryList').click(function () {
                $('.categoryUl ul').toggleClass("hide");
            })

            //分类选项的点击事件
            $('.categoryUl ul li').click(function () {
                var _this = $(this);
                //控制输入框的禁用与选项的显示隐藏
                _input = _this.find("input");
                _input.attr("disabled",!_input.attr("disabled"));
                _this.toggleClass("choseCategory");

                //处理显示框
                var choseCatedgory = _this.find("span").html().trim();
                var content = $('.categoryList').text().replace(/\s/g,"");
                //中文的分号分隔
                var contentArr = content.split('；');
                contentArr.forEach(function (value,index) {
                    //当数组的值为空时；
                    if (value == ""){
                        contentArr[index] = choseCatedgory;
                        return;
                    }
                    //当已经有该类时，删掉；
                    if(value == choseCatedgory){
                        contentArr.splice(index,1);
                        return;
                    }
                    //没有找到该类时，加入；
                    if (index == contentArr.length -1){
                        contentArr.push(choseCatedgory);
                        return;
                    }
                });
                $('.categoryList').html(contentArr.join("；"))
            });

            //文章分类的显示隐藏
            $('.columnList').click(function () {
                $('.columnUl ul').toggleClass("hide");
            })

            //分类选项的点击事件
            $('.columnUl ul li').click(function () {
                var _this = $(this);
                //控制输入框的禁用与选项的显示隐藏
                _input = _this.find("input");
                _input.attr("disabled",!_input.attr("disabled"));
                _this.toggleClass("choseColumn");

                //处理显示框
                var choseColumn = _this.find("span").html().trim();
                var content = $('.columnList').text().replace(/\s/g,"");
                //中文的分号分隔
                var contentArr = content.split('；');
                contentArr.forEach(function (value,index) {
                    //当数组的值为空时；
                    if (value == ""){
                        contentArr[index] = choseColumn;
                        return;
                    }
                    //当已经有该类时，删掉；
                    if(value == choseColumn){
                        contentArr.splice(index,1);
                        return;
                    }
                    //没有找到该类时，加入；
                    if (index == contentArr.length -1){
                        contentArr.push(choseColumn);
                        return;
                    }
                });
                $('.columnList').html(contentArr.join("；"))
            })
        </script>
    </body>
</html>