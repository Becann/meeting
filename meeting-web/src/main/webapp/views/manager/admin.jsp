<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title> CGU会议纪要- 主页</title>

    <meta name="keywords" content="">
    <meta name="description" content="">

    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->

    <link rel="shortcut icon" href="<%=path%>/hAdmin/favicon.ico"> <link href="<%=path%>/hAdmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/animate.css" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/style.css?v=4.1.0" rel="stylesheet">
    <style>
    .topline{
    float:left;
    padding: 6px 12px;
    margin-top: 10px;
    font-size: 14px;
    color:#A0A0A0;
    }
    </style>
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
    <div id="wrapper">
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                                    <span class="block m-t-xs" style="font-size:20px;">
                                        <i class="fa fa-area-chart"></i>
                                        <strong class="font-bold">CGU会议纪要</strong>
                                    </span>
                                </span>
                            </a>
                        </div>
                        <div class="logo-element">CGU会议纪要
                        </div>
                    </li>
                    
                    <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
                        <span class="ng-scope">分类</span>
                    </li>
                    <li>
                        <a class="J_menuItem" href="<%=path%>/views/index.jsp">
                            <i class="fa fa-home"></i>
                            <span class="nav-label">主页</span>
                        </a>
                    </li>
                    <c:if test="${admin.role eq 'admin' }">
                    <li>
                        <a class="J_menuItem" href="<%=path%>/ws/user/list">
                            <i class="fa fa-user"></i>
                            <span class="nav-label">用户信息</span>
                        </a>
                    </li>
                  	</c:if>
                    <li>
                        <a href="#">
                            <i class="fa fa-edit"></i>
                            <span class="nav-label">会议纪要</span>
                            <span class="fa arrow"></span>
                        </a>
                         <ul class="nav nav-second-level">
                         <li><a class="J_menuItem" href="<%=path%>/ws/meet/list">会议纪要详情</a>
                            </li>
                            <li><a class="J_menuItem" href="<%=path%>/ws/meet/edit1">编辑会议纪要</a>
                            </li>
                         </ul>
                    </li>
                    <%-- <li>
                    	<a class="J_menuItem" href="<%=path%>/hAdmin/index.html">
                    	<i class="fa fa-folder"></i>
                    	<span class="nav-label">
                    	hAdmin
                    	</span>
                    	</a>
                    
                    </li> --%>
                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-info " href="#"><i class="fa fa-bars"></i> </a>
                        <!-- <form role="search" class="navbar-form-custom" method="post" action="search_results.html">
                             <div class="form-group">
                             
                                <input type="text" placeholder="欢迎使用cgu会议纪要管理系统" class="form-control"  readonly="true">
                            </div> 
                        </form> -->
                        <span class="topline" >欢迎使用cgu会议纪要管理系统</span>
                    </div>
                    <ul class="nav navbar-top-links navbar-right">                      
 						<li class="dropdown">
                            <a class="dropdown-toggle count-info"  href="<%=path%>/ws/admin/logout">
                                <!-- <i class="fa fa-bell"></i> -->
                                <span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>
                                <span class="glyphicon-class">退出登陆</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe id="J_iframe" width="100%" height="100%" src="<%=path%>/views/index.jsp" frameborder="0" data-id="index.jsp" seamless></iframe>
            </div>
        </div>
        <!--右侧部分结束-->
    </div>

    <!-- 全局js -->
    <script src="<%=path%>/hAdmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="<%=path%>/hAdmin/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="<%=path%>/hAdmin/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="<%=path%>/hAdmin/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="<%=path%>/hAdmin/js/plugins/layer/layer.min.js"></script>

    <!-- 自定义js -->
    <script src="<%=path%>/hAdmin/js/hAdmin.js?v=4.1.0"></script>
    <script type="text/javascript" src="<%=path%>/hAdmin/js/index.js"></script>

    <!-- 第三方插件 -->
   <%-- <script src="<%=path%>/hAdmin/js/plugins/pace/pace.min.js"></script> --%>
</body>

</html>
