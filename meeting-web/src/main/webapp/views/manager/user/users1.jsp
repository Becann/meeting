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


    <title> -用户信息 </title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="<%=path%>/hAdmin/favicon.ico"> <link href="<%=path%>/hAdmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <!-- Data Tables -->
    <link href="<%=path%>/hAdmin/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">

    <link href="<%=path%>/hAdmin/css/animate.css" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>用户信息</h5>
                        <div class="ibox-tools">
                        <input type="button" id="click_modal" data-toggle="modal" data-target="#myModal"  
                        class="btn btn-primary btn-xs" value="添加用户">
                         <!--  <a  onclick="" class="btn btn-primary btn-xs">添加用户</a>      -->                     
                        </div>
                    </div>
                    <div class="ibox-content">

                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <thead>
                                <tr>
                                    <th>操作</th >
                                    <th>用户名</th>
                                    <th>用户角色</th>
                                    <th>注册时间</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${userlist}" var="user">																							
                                <tr class="gradeA">
                                <td class="right">
                                     <a  onclick="deleteUser(${user.id})" class="btn btn-white btn-sm">                                         
                                            <i class="fa fa-trash" aria-hidden="true"></i> 删除</a>
                                     </td>          
                                      <td>${user.name}</td>
                                    <td>${user.role}</td>
                                    <td>${user.ctime}</td>
                                </tr>
                               </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                   <th>操作</th>
                                    <th>用户名</th>
                                    <th>用户角色</th>
                                    <th>注册时间</th>
                                    
                                </tr>
                            </tfoot>
                        </table>

                    </div>
                </div>
            </div>
        </div> 
    </div>

 			
			<div class="modal inmodal fade" id="myModal" tabindex="-1" role="dialog"  aria-hidden="false">
                                <div class="modal-dialog modal-sm">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="modal-title">添加用户</h4>
                                        </div>
                                                                           
                                        <div class="modal-body">
                                                             	 
                            <form class="form-horizontal m-t" id="userForm" action="<%=path%>/ws/user/adduser" method="post">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户名：</label>
                                <div class="col-sm-8">
                                    <input  id="name" name="name" class="form-control" type="text" aria-required="true" aria-invalid="true" class="error" required="">
                                    <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 尽可能使用已存在的钉钉用户名创建</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-8">
                                    <input id="password" name="password" class="form-control" type="password" required="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">确认密码：</label>
                                <div class="col-sm-8">
                                    <input id="confirm_password" name="confirm_password" class="form-control" type="password" required="">
                                    <font color="red"><input type="hidden" id="confirm_message" value=""></font>
                                </div>
                            </div>                   
                           <div class="form-group">
                                <label class="col-sm-3 control-label">角色</label>

                                <div class="col-sm-8">
                                    <select class="form-control m-b" name="role" id="role">
                                        <option value="admin">Administartor</option>
                                      	  <option value="user">Ordinary user</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                                      	 
                                      	 
                                      	 
                                        </div>
                                        <div class="modal-footer">
                                        	<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addUser()">提交</button>
                                            <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
                                        </div>
                                        
                                </div>
                        </div>
            </div>






    <!-- 全局js -->
    <script src="<%=path%>/hAdmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="<%=path%>/hAdmin/js/bootstrap.min.js?v=3.3.6"></script>


	<!-- layer -->
    <script src="<%=path%>/layer/layer.js"></script>
    <script src="<%=path%>/hAdmin/js/plugins/jeditable/jquery.jeditable.js"></script>

    <!-- Data Tables -->
    <script src="<%=path%>/hAdmin/js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="<%=path%>/hAdmin/js/plugins/dataTables/dataTables.bootstrap.js"></script>

    <!-- 自定义js -->
    <script src="<%=path%>/hAdmin/js/content.js?v=1.0.0"></script>


    <!-- Page-Level Scripts -->
    <script>
        $(document).ready(function () {
            $('.dataTables-example').dataTable();

        });
        function deleteUser(uid){
       		$.get('<%=path %>/ws/user/delete?id='+uid,function(data,status){
				if(data.statusCode==200){
					location.reload();
				}else{
					layer.alert(data.message,{
						icon: 2,
						skin: 'layer-ext-moon'
					});
				};
				
       		});
       	}
        function addUser(){
        	var name=$("#name").val();
        	var role=$("#role").val();
        	var npass=$("#password").val();
        	var opass=$("#confirm_password").val();
        	if(npass!=opass){
        		layer.alert("两次密码输入不一致",{
        			icon:0,//0感叹号，1对号，2叉号，3问号，4锁，5哭脸，6笑脸
        			skin: 'layer-ext-moon'
        		});
        		return;
        	}
        	$.post('<%=path%>/ws/user/adduser',{
        		name:name,
        		password:npass,
        		role:role
        	},function(data,status){
        		if(data.code=='200'){
        			layer.alert(data.message,{
            			icon:6,
            			skin: 'layer-ext-moon'
          		});
        		}else{
        			layer.alert(data.message,{
            			icon:5,
            			skin: 'layer-ext-moon'
          		});
        		}
        	});
        	//$("#userForm").submit();
        }
    </script>

    
    

</body>

</html>



