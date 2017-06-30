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
	<link rel="shortcut icon" href="<%=path%>/hAdmin/favicon.ico"> 
    <link href="<%=path%>/hAdmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    
    
 	<link href="<%=path%>/summernote-master/dist/summernote.css" rel="stylesheet">
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
                        <h5>编辑器</h5>
                    </div>
   
    <div class="ibox-content">
     <div class="form-inline form-group">            
 	 主题：<input type="text" name="title" 
		class="input-xs form-control" placeholder="会议主题" required="" value="${minutes.title}"/>
            作者：<input type="text" name="author" 
        class="input-xs form-control" placeholder="会议创建人" required="" value="${minutes.author}"/> 
        <button id="save_button"class="btn btn-primary btn-sm">保存</button>                              
    </div>

   	</div>

	<div class="summernote">
	${minutes.content}
	</div>						
	</div>

		</div>
		</div>
	</div>
	</div>
	
	<!-- quill -->
	<%-- <script src="<%=path%>/fulleditor/dist/katex.min.js"></script>
	<script src="<%=path%>/fulleditor/dist/highlight.min.js"></script>
	<script src="<%=path%>/fulleditor/dist/quill.js"></script> --%>
	<!-- 全局js -->
    <script src="<%=path%>/hAdmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="<%=path%>/hAdmin/js/bootstrap.min.js?v=3.3.6"></script> 
    <!-- summernote -->
    <script src="<%=path%>/summernote-master/dist/summernote.min.js"></script>
    <!-- 自定义js -->
    <script src="<%=path%>/hAdmin/js/content.js?v=1.0.0"></script>
    <!-- layer -->
    <script src="<%=path%>/layer/layer.js"></script>
	<!-- Initialize Quill editor -->
	<script>
		/* var quill = new Quill('#editor-container', {
		    modules: {
		      formula: true,
		      syntax: true,
		      toolbar: '#toolbar-container'
		    },
		    placeholder: '此处编辑会议纪要',
		    theme: 'snow'
		  }); */
		  $(document).ready(function() {
			  $('.summernote').summernote({
				  height: 300,                 // set editor height
				  minHeight: null,             // set minimum height of editor
				  maxHeight: null,             // set maximum height of editor
				  focus: true                  // set focus to editable area after initializing summernote
				});
			});
	</script>
	<script type="text/javascript">
	
	$(function(){
		$("#save_button").click(function(){
			var content=$('.summernote').summernote('code');
			//alert("content"+content);
			var title=$("input[name='title']").val();
			var author=$("input[name='author']").val();
			if(title==''){
				layer.alert('请填写会议纪要主题', {
					  icon: 0,//0感叹号，1对号，2叉号，3问号，4锁，5哭脸，6笑脸
					  skin: 'layer-ext-moon'
					})
				//layer.alert("请填写会议纪要主题");	
				return;
			}
			if(author==''){
				layer.alert("请填写会议纪要作者",{
					  icon: 0,
					  skin: 'layer-ext-moon'
					});
				return;
			}
			if(content==''){
				layer.alert("请填写会议纪要内容",{
					  icon: 0,
					  skin: 'layer-ext-moon'
					});
				return;
			}
			$.post("<%=path%>/ws/meet/edit",{
				'description':content,
				'title':title,
				'author':author
			},function(data,status){
				var iconnum=1;
				if(data.statusCode==300){
					iconnum=2;
				};
				layer.alert(data.message,{
					icon: iconnum,
					skin: 'layer-ext-moon'
				});
				//var jsondata=JSON.parse(data);
			});
		});
	});
	
	</script>
</body>
</html>


