<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh">

<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="">
    <meta name="description" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>编辑器</title>
	<link rel="stylesheet" type="text/css" href="<%=path%>/fulleditor/css/bootstrap-grid.min.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/fulleditor/css/demo.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.6.0/katex.min.css"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.3.0/styles/monokai-sublime.min.css"/>
	<link href="<%=path%>/fulleditor/css/themes/quill.snow.css" rel="stylesheet">
	<link rel="shortcut icon" href="<%=path%>/hAdmin/favicon.ico"> 
    <link href="<%=path%>/hAdmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="<%=path%>/hAdmin/css/animate.css" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/style.css?v=4.1.0" rel="stylesheet">
	<style type="text/css">
		#editor-container {
		  height: 400px;
		}
	</style>
	<!--[if IE]>
		<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
	<![endif]-->
</head>
<body  class="gray-bg">
	 <div class="wrapper wrapper-content animated fadeInUp">
	 <div class="row">
            <div class="col-sm-12">
                <div class="ibox">
                    <div class="ibox-title">
                        <h5>会议纪要展示</h5>
                    </div>
   
    <div class="ibox-content">
     <div class="form-inline form-group">            
 	 主题：<input type="text" name="title" 
		class="input-xs form-control" placeholder="会议主题" required="" value="${minutes.title}"/>
            作者：<input type="text" name="author" 
        class="input-xs form-control" placeholder="会议创建人" required="" value="${minutes.author}"/>                              
    </div>

   	</div>
   
	<div>
		<div id="standalone-container">		
			<div id="editor-container">
			${minutes.content}
			</div>
		</div>
	</div>

		</div>
		</div>
	</div>
	</div>
	<script src="<%=path%>/fulleditor/dist/katex.min.js"></script>
	<script src="<%=path%>/fulleditor/dist/highlight.min.js"></script>
	<script src="<%=path%>/fulleditor/dist/quill.js"></script>
	<!-- 全局js -->
    <script src="<%=path%>/hAdmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="<%=path%>/hAdmin/js/bootstrap.min.js?v=3.3.6"></script>
    <!-- 自定义js -->
    <script src="<%=path%>/hAdmin/js/content.js?v=1.0.0"></script>
    
	<!-- Initialize Quill editor -->
	<script>
		var quill = new Quill('#editor-container', {
		    modules: {
		      formula: true,
		      syntax: true
		    },
		    placeholder: '',
		    theme: 'snow'
		  });

	</script>
</body>
</html>


