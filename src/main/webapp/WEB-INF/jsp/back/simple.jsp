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
        <link rel="stylesheet" href="<%=basePath %>resource/back/css/simple.css" />
        <link rel="stylesheet" href="<%=basePath %>resource/markdown/css/editormd.css" />
        <link rel="shortcut icon" href="https://pandao.github.io/editor.md/favicon.ico" type="image/x-icon" />
    </head>
    <body>
        <div id="layout">
            <header>
                <h1>Simple example</h1>
            </header>
            <div>
            	<button id="saveBtn">保存文章</button>
            </div>
            <div id="test-editormd">
                <textarea style="display:none;">[TOC]

#### Disabled options

- TeX (Based on KaTeX);
- Emoji;
- Task lists;
- HTML tags decode;
- Flowchart and Sequence Diagram;

#### Editor.md directory

    editor.md/
            lib/
            css/
            scss/
            tests/
            fonts/
            images/
            plugins/
            examples/
            languages/     
            editormd.js
            ...

```html
&lt;!-- English --&gt;
&lt;script src="../dist/js/languages/en.js"&gt;&lt;/script&gt;

&lt;!-- 繁體中文 --&gt;
&lt;script src="../dist/js/languages/zh-tw.js"&gt;&lt;/script&gt;
```
</textarea>
            </div>
        </div>
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
            	var tags = [{tagName:"CSS",tagId:3},{tagName:"前端",tagId:1},{tagName:"后端",tagId:2}];
            	var data = {
	        			markdownContent: testEditor.getMarkdown(),
	        			htmlContent:testEditor.getHTML(),
	        			tags:tags
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
        </script>
    </body>
</html>