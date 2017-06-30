<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 注册</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="<%=path%>/hAdmin/favicon.ico"> <link href="<%=path%>/hAdmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/animate.css" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/style.css?v=4.1.0" rel="stylesheet">
    <script>if(window.top !== window.self){ window.top.location = window.location;}</script>

</head>

<body class="gray-bg" onload="open_win()">

    <div class="middle-box text-center loginscreen   animated fadeInDown">
        <div>
            <div>

                <h1 class="logo-name">M</h1>

            </div>
            <h3>欢迎注册 CGU会议管理系统</h3>
            <p>创建一个CGU MMinutes新账户<br><font color="red">请使用钉钉用户名创建</font></p>
            <p><font color="red">${message}</font></p>
            <form class="m-t" role="form" id="cpwd_form" method="post" action="<%=path%>/ws/user/register">
            <input type="hidden"   name="role" value="user">
                <div class="form-group">
                    <input type="text" class="form-control" id="name" name="name" placeholder="请输入用户名" required="">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" name="newpassword" placeholder="请输入密码" required="">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" name="oldpassword" placeholder="请再次输入密码" required="">
                </div>
                 <div class="form-group form-inline">
                    <input type="text" id="dynamic_code" class="form-control" placeholder="请输入动态口令" required="" name="adminkey">
                    <input type="button"  id="ddbtn" class="btn btn-primary btn-sm" onclick="set_time(this)" value="获取动态口令">
                </div>
                <div class="form-group text-left">
                    <div class="checkbox i-checks">
                        <!-- <label class="no-padding"> -->
                            <input type="checkbox"><i></i> 我同意注册协议<!-- </label> -->
                    </div>
                </div>
                <button type="button" id="register_button" disabled="disabled" class="btn btn-primary block full-width m-b">注 册</button>

                <p class="text-muted text-center"><small>已经有账户了？</small><a href="<%=path %>/views/login.jsp">点此登录</a>
                </p>

            </form>
        </div>
    </div>

    <!-- 全局js -->
    <script src="<%=path%>/hAdmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="<%=path%>/hAdmin/js/bootstrap.min.js?v=3.3.6"></script>
    <!-- layer -->
    <script src="<%=path%>/layer/layer.js"></script>
    <!-- iCheck -->
    <script src="<%=path%>/hAdmin/js/plugins/iCheck/icheck.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });       
            $("ins.iCheck-helper").mousedown(function(){
            if($("div.icheckbox_square-green").is(".checked")){
                    $("#register_button").attr('disabled',true);
            }else{             
               $("#register_button").attr('disabled',false);
            } 
            });
           
        });
        /* 倒计时获取动态口令 */
    	var countdown=60; 
    	function set_time(obj) {   
        if (countdown == 0) {   
            obj.removeAttribute("disabled");
            obj.value="获取动态口令";   
            countdown = 60;   
            return;  
        } else {   
            obj.setAttribute("disabled", true);
            obj.value="重新发送(" + countdown + ")";   
            countdown--;   
        }   
        setTimeout(function() {   
            set_time(obj) }  
            ,1000)   
        }
    	//页面加载时触发
    	function open_win(){
    		
    	}
    	$(function(){ 		
    		
    		var service_code='';
    		$("#ddbtn").click(function(){
    			if($("#name").val()==""){
    				layer.alert('请先填写用户名',{
    					icon: 0,//0感叹号，1对号，2叉号，3问号，4锁，5哭脸，6笑脸
    					skin: 'layer-ext-moon'
    				});
    				return;
    			}
    			$.post("<%=path%>/ws/admin/ddpush",
    				{
    					name:$("#name").val()
    				},function(data,status){
    					//alert(data);
    				if(data.message!='success'){
    					layer.alert(data.message,{
    						icon: 2,//0感叹号，1对号，2叉号，3问号，4锁，5哭脸，6笑脸
    						skin: 'layer-ext-moon'
    					});
    				}else{
    					service_code=data.code;
    				}		
    			})
    		});	
    		$("#register_button").click(function(){
    			var live_code=$("#dynamic_code").val();
    			if($("input[name='oldpassword']").val()!=
    				$("input[name='newpassword']").val()){
    				layer.alert('两次密码填写不一致',{
    					icon: 0,//0感叹号，1对号，2叉号，3问号，4锁，5哭脸，6笑脸
    					skin: 'layer-ext-moon'
    				});
    				return;
    			}
    			if(service_code!=live_code||service_code==""||live_code==""){
    				console.log(' service_code: '+service_code);
    				console.log(' live_code: '+live_code);
    				layer.alert('动态码不正确，请重新填写',{
    					icon: 0,//0感叹号，1对号，2叉号，3问号，4锁，5哭脸，6笑脸
    					skin: 'layer-ext-moon'
    				});
    				return;
    			}
    			
    			$("#cpwd_form").submit();
    		});	
    	});
    	
    </script>

    
    

</body>

</html>