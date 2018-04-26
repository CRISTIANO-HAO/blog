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
                <span>Hello Mr.HAO</span>
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
                <div class="left">
                    <div>
                        <h3>文章标题</h3>
                        <input type="text" name="title" value="${article.title}">
                    </div>
                    <div class="categoryDiv">
                        <h3>文章分类</h3>
                        <div>
                            <div class="categoryList">
                                <c:forEach items="${article.categories}" var="category" varStatus="categoryIndex" >
                                    <c:if test="${categoryIndex.index < (article.categories.size() - 1)}">
                                        <span>${category.categoryName}；</span>
                                    </c:if>
                                    <c:if test="${categoryIndex.index == (article.categories.size() - 1)}">
                                        <span>${category.categoryName}</span>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="categoryUl">
                            <ul class="hide">
                                <c:forEach items="${categories}" var="category">
                                    <c:set var="flag" value="false"></c:set>
                                    <c:forEach items="${article.categories}" var="articleCatecory">
                                        <c:if test="${category.categoryName == articleCatecory.categoryName}">
                                            <c:set var="flag" value="true"></c:set>
                                        </c:if>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${flag == true}">
                                            <li class="choseCategory">
                                                <span> ${category.categoryName}</span>
                                                <input type="hidden" name="categoryId" value="${category.categoryId}">
                                            </li>
                                            <c:set var="flag" value="false"></c:set>
                                        </c:when>
                                        <c:otherwise>
                                            <li>
                                                <span> ${category.categoryName}</span>
                                                <input type="hidden" name="categoryId" value="${category.categoryId}" disabled>
                                            </li>
                                            <c:set var="flag" value="false"></c:set>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="right">
                    <div class="btnDiv">
                        <button id="saveBtn" type="button">保存</button>
                        <button id="publishBtn" type="button">发布</button>
                        <button id="deleteBtn" type="button">删除</button>
                    </div>
                    <div class="tagDiv">
                        <h3>文章标签</h3>
                        <input type="text" name="tag" value="<c:forEach items="${article.tags}" var="tag">${tag.tagName}；</c:forEach>">
                    </div>
                </div>
            </div>
            <div id="layout">
                <div id="test-editormd">
                    <textarea style="display:none;" name="markdownContent">${article.markdownContent}</textarea>
                </div>
            </div>
            <div class="article-summary">
                <h3>文章摘要</h3>
                <textarea rows="5" name="summaryContent">${article.summaryContent}</textarea>
            </div>
        </main>

        <script src="<%=basePath %>resource/common/js/jquery-2.0.3.js"></script>
        <script src="<%=basePath %>resource/markdown/editormd.min.js"></script>
        <script type="text/javascript">
			var testEditor;

            $(function() {
                testEditor = editormd("test-editormd", {
                    width   : "90%",
                    height  : 640,
                    syncScrolling : "single",
                    saveHTMLToTextarea : true,    // 保存 HTML 到 Textarea
                    path    : "<%=basePath %>" + "resource/markdown/lib/"
                });
            });
            
            $('#saveBtn').click(function(){
                var categories = [];
                var categoriesInput = $('input[name = categoryId][disabled != disabled]');
                categoriesInput.each(function () {
                    var id = $(this).val();
                    categories.push({categoryId:id});
                })

                var data = {
                    articleId : "${article.articleId}",
                    markdownContent: testEditor.getMarkdown(),
                    htmlContent:testEditor.getHTML(),
                    summaryContent: $('textarea[name = summaryContent]').val(),
                    categories:categories,
                };
                $.ajax({
                    type: "POST",
                    url: "admin/article/add",
                    contentType: "application/json",
                    data:JSON.stringify(data),
                    success: function(result){
                        console.log(result)
                    },
                });
        	});

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
            })
        </script>
    </body>
</html>