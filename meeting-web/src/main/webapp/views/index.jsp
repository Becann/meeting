<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--360浏览器优先以webkit内核解析-->


    <title> - 主页示例</title>

    <link rel="shortcut icon" href="../hAdmin/favicon.ico"> <link href="../hAdmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="../hAdmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="../hAdmin/css/animate.css" rel="stylesheet">
    <link href="../hAdmin/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg" onload="set_time()">
    <div class="row">
        <div class="col-sm-12">
            <div class="wrapper wrapper-content animated fadeInUp">
                <ul class="notes">
                <c:if test="${admin.role eq 'admin' }">
                    	<li>              
                        <div>
                            <small><label id="now_time"></label></small>
                            <h4>请看这里^-^</h4>
                            <p>您好！管理员${admin.name},欢迎使用cgu会议纪要管理系统，您可以查看所有用户信息，可以新增会议记录，也可以查看修改所有用户创建的会议记录，所有操作请从管理菜单开始。</p>
                            <!-- <a href="pin_board.html#"><i class="fa fa-trash-o "></i></a> -->
                        </div>
                      </li>
                      </c:if>
                       <c:if test="${admin.role eq 'user' }">
                       <li>
                        <div>
                            <small><label id="now_time"></small>
                            <h4>请看这里^-^</h4>
                            <p>您好！${admin.name},作为普通用户，你只能编辑会议纪要记录和查看自己编辑过的记录，从功能菜单开始使用吧！</p>
                            <!-- <a href="pin_board.html#"><i class="fa fa-trash-o "></i></a> -->
                        </div>
                        </li>
                        </c:if>
                        
                     
                   
                </ul>
            </div>
        </div>
    </div>
    <!-- 全局js -->
    <script src="../hAdmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="../hAdmin/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="../hAdmin/js/plugins/layer/layer.min.js"></script>
   
    <!-- 自定义js -->
    <script src="../hAdmin/js/content.js"></script>
    <script type="text/javascript">
  
        
    function set_time() {   
        	var mydate= new Date().toLocaleString();
        	$("#now_time").text(mydate);
        setTimeout(function() {   
            set_time() }  
            ,1000)   
        }

	
    
    
    </script>
</body>

</html>



