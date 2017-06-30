<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 修改密码</title>
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
            <h3>修改密码</h3>
            <p>通过钉钉动态码修改密码</p>
            <form class="m-t" role="form"  id="cpwd_form" method="post" action="<%=path%>/ws/admin/change">
                <div class="form-group">
                    <input type="text" id="adminname" class="form-control" placeholder="请输入用户名" required="" name="adminname">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="请输入新密码" required="" name="oldpassword">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="请再次输入密码" required="" name="newpassword">
                </div>
                <div class="form-group form-inline">
                    <input type="text" id="dynamic_code" class="form-control" placeholder="请输入动态口令" required="" name="adminkey">
                    <input type="button"  id="ddbtn" class="btn btn-primary btn-sm" onclick="set_time(this)" value="获取动态口令">
                </div>
                <button type="button" id="cpwd_button" class="btn btn-primary block full-width m-b">提交</button>  
            </form>
            <input type="hidden" id="click_modal" data-toggle="modal" data-target="#myModal">
        </div>
        
    </div>



                            <div class="modal inmodal fade" id="myModal" tabindex="-1" role="dialog"  aria-hidden="false">
                                <div class="modal-dialog modal-sm">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="modal-title">结果窗口</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p>密码修改成功，<a href="<%=path%>/views/login.jsp">返回登录界面</a></p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                                        </div>
                                    </div>
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
        });
    </script>
<script type="text/javascript">   

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
	/* 获取服务器信息 */
	function open_win() {
		var msg="${ajaxDone.message}";
		if(msg=="success"){
			$("#click_modal").click();
		}
	}
	/* 钉钉获取动态码提交 */
	$(function(){
		var service_code='';
		$("#ddbtn").click(function(){
			if($("#adminname").val()==""){
				layer.alert('请先填写用户名',{
					icon: 0,//0感叹号，1对号，2叉号，3问号，4锁，5哭脸，6笑脸
					skin: 'layer-ext-moon'
				});
				return;
			}
			$.post("<%=path%>/ws/admin/ddpush",
				{
					name:$("#adminname").val()
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
		$("#cpwd_button").click(function(){
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


