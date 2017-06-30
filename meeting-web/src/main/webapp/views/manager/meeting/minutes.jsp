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


    <title> - 项目</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="<%=path%>/hAdmin/favicon.ico"> 
    <link href="<%=path%>/hAdmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="<%=path%>/hAdmin/css/animate.css" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/style.css?v=4.1.0" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="<%=path%>/paging/src/paging.css">
	<%-- <link rel="stylesheet" href="<%=path%>/jmobile/jquery.mobile-1.4.5.min.css" /> --%>
</head>

<body class="gray-bg">

    <div class="wrapper wrapper-content animated fadeInUp">
        <div class="row">
            <div class="col-sm-12">

                <div class="ibox">
                    <div class="ibox-title">
                        <h5>会议列表</h5>
                        <div class="ibox-tools">
                            <a href="<%=path%>/views/editor.jsp" class="btn btn-primary btn-xs">创建会议纪要</a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="row m-b-sm m-t-sm">
                            <!-- <div class="col-md-1">
                                <button type="button" id="loading-example-btn" class="btn btn-white btn-sm"><i class="fa fa-refresh"></i> 刷新</button>
                            </div> -->
                            <div class="col-md-11">
                                
                                
                            <form role="form" class="form-inline form-horizontal m-t" action="<%=path%>/ws/meet/list">
                            <c:if test="${admin.role eq 'user' }">
									<input type="hidden" name="author" value="${admin.name}" />
							</c:if>
							<c:if test="${admin.role eq 'admin' }">
                                    <input type="text" placeholder="纪要作者" class="input-sm form-control" width="20%" name="author"> 
                            </c:if>
                           
							<input type="text" placeholder="纪要主题" class="input-sm form-control" name="title">
						    <input type="text" placeholder="纪要内容关键字" class="input-sm form-control" name="key">
						    <input class="form-control layer-date" placeholder="开始日期" name="before"
						    onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
						    <input class="form-control layer-date" placeholder="结束日期" name="after"
						    onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
                            <!-- <input placeholder="开始日期" class="form-control layer-date" id="start" name="before">     
                            <input placeholder="结束日期" class="form-control layer-date" id="end" name="after"> -->
                            <button class="btn btn-primary" type="submit">搜索</button>
                        	</form>
                            </div>
                        </div>

                        <div class="project-list">

                            <table  id="table_list" class="table table-hover">
                                <tbody >
                                <c:forEach items="${meetings.list}" var="meet">
                                <tr >
                                 <td class="project-status">
                                            <a href="<%=path %>/ws/meet/preview?id=${meet.id}" id="showdetails" class="btn btn-white btn-sm">
                                            <i class="fa fa-folder"></i> 查看 </a>
                                             <a  onclick="deleteMeet(${meet.id})" class="btn btn-white btn-sm">                                         
                                            <i class="fa fa-trash" aria-hidden="true"></i> 删除</a> 
                                        </td>
                                       
                                        <td class="project-title">
                                            <h5>${meet.title}</h5>
                                            <br/>
                                            <small>创建于 ${meet.ctime}</small>
                                        </td>
                                         <td class="project-title">
                                            	<h5>作者</h5>
                                            <br/>
                                            <small> ${meet.author}</small>
                                        </td>
                                        <%-- <td class="project-people">                                   
                                             <a href="<%=path %>/ws/meet/preview?id=${meet.id}"><img alt="image" class="img-circle" src="<%=path%>/hAdmin/img/font-246.jpg"></a> 
                                        </td> --%>
                                        <td class="project-status">
                                            <span class="label label-primary">${meet.id}</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                    </tbody>
                                </table>
        <div id="pageTool"></div> 
		<!-- <div id="pageToolbar"></div> -->
						</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

    <!-- 全局js -->
    <script src="<%=path%>/hAdmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="<%=path%>/hAdmin/js/bootstrap.min.js?v=3.3.6"></script>  
    <!-- 自定义js -->
    <script src="<%=path%>/hAdmin/js/content.js?v=1.0.0"></script>
	<!-- layer -->
    <script src="<%=path%>/layer/layer.js"></script>
	<script type="text/javascript" src="<%=path%>/paging/src/query.js"></script>
	<script type="text/javascript" src="<%=path%>/paging/src/paging.js"></script>
	
	<!-- jequery mobile -->
    <%-- <script type="text/javascript" src="<%=path%>/jmobile/jquery.mobile-1.4.5.min.js"></script> --%>
    
    
 	<script src="<%=path%>/hAdmin/js/plugins/layer/laydate/laydate.js"></script>
    <script>
        $(document).ready(function(){
          /*   $('#loading-example-btn').click(function () {
                btn = $(this);
                simpleLoad(btn, true)
                simpleLoad(btn, false)
            }); */
            
            /*  $("tr").on("tap",function(){
            	console.log($(this).children("td.project-people").children("a"));
            	 $(this).children("td.project-people").children("a").click();
            	});  */
           
        });
        function simpleLoad(btn, state) {
            if (state) {
                btn.children().addClass('fa-spin');
                btn.contents().last().replaceWith(" Loading");
            } else {
                setTimeout(function () {
                    btn.children().removeClass('fa-spin');
                    btn.contents().last().replaceWith(" Refresh");
                }, 2000);
            }
        }
       	function deleteMeet(mid){
       		$.get('<%=path %>/ws/meet/delete?id='+mid,function(data,status){
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
    </script>
	<script>
	$(function(){
		var totalcounts=${meetings.totalnum};
        var pagesize =${meetings.pagenum};
        var currentpage=${meetings.userpage};
         $('#pageTool').Paging({pagesize:5,count:totalcounts,current:currentpage,callback:function(page,size,count){
			console.log(arguments);
			 window.location.href="<%=path%>/ws/meet/list?pageNum=" + page + "&numPerPage=" + size;
			}}); 
         
		$('#pageToolbar').Paging({pagesize:pagesize,count:totalcounts,current:currentpage,toolbar:true,
					callback:function(page,size,count){
						 window.location.href="<%=path%>/ws/meet/list?pageNum=" + page + "&numPerPage=" + size;
				}
		});
	});
		
		</script>
    
    </body>
</html>


