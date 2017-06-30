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


    <title> - 会议纪要</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="<%=path%>/hAdmin/favicon.ico"> 
    <link href="<%=path%>/hAdmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">

    <link href="<%=path%>/hAdmin/css/animate.css" rel="stylesheet">
    <link href="<%=path%>/hAdmin/css/style.css?v=4.1.0" rel="stylesheet">
    
    <!-- jqgrid-->
    <link href="<%=path%>/hAdmin/css/plugins/jqgrid/ui.jqgrid.css?0820" rel="stylesheet">

</head>

<body class="gray-bg">

    <div class="wrapper wrapper-content animated fadeInUp">
        <div class="row"> 
           <div class="col-sm-12">

                <div class="ibox">
                    <div class="ibox-title">
                        <h5>所有会议纪要</h5>
                        <div class="ibox-tools">
                            <a href="<%=path%>/views/editor.jsp" class="btn btn-primary btn-xs">创建会议纪要</a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="row m-b-sm m-t-sm">
                    
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
						<div class="jqGrid_wrapper">
                            <table id="table_list_2"></table>
                            <div id="pager_list_2"></div>
                        </div>
        <%--                 <div class="project-list">

                            <table class="table table-hover">
                                <tbody>
                                <c:forEach items="${meetings}" var="meet">                            
                                <tr>
                                        <td class="project-status">
                                            <span class="label label-primary">${meet.id}</span>
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
                                        <!-- <td class="project-completion">
                                                <small>作者</small>
                                                <div class="progress progress-mini">
                                                    <div style="width: 100%;" class="progress-bar"></div>
                                                </div>
                                        </td> -->
                                        <td class="project-people">
                                            <a href="projects.html"><img alt="image" class="img-circle" src="<%=path%>/hAdmin/img/a3.jpg"></a>
                                        </td>
                                        <td class="project-actions">
                                            <a href="<%=path %>/ws/meet/preview?id=${meet.id}" class="btn btn-white btn-sm">
                                            <i class="fa fa-folder"></i> 查看 </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                    </tbody>
                                </table>
                            </div> --%>
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

 	<script src="<%=path%>/hAdmin/js/plugins/layer/laydate/laydate.js"></script>
 	
 	 <!-- jqGrid -->
    <script src="<%=path%>/hAdmin/js/plugins/jqgrid/i18n/grid.locale-cn.js?0820"></script>
    <script src="<%=path%>/hAdmin/js/plugins/jqgrid/jquery.jqGrid.min.js?0820"></script>
    <script>
        $(document).ready(function(){

            $('#loading-example-btn').click(function () {
                btn = $(this);
                simpleLoad(btn, true)

                // Ajax example
//                $.ajax().always(function () {
//                    simpleLoad($(this), false)
//                });

                simpleLoad(btn, false)
            });
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
    </script>


     <script>   
        $(document).ready(function () {

            $.jgrid.defaults.styleUI = 'Bootstrap';
            // Examle data for jqGrid        
            var mydata = ${meetingJsonStr};   
            console.log(mydata);
           // Configuration for jqGrid Example 2
            $("#table_list_2").jqGrid({
                data: mydata,
                datatype: "local",
                height: 350,
                autowidth: true,
                shrinkToFit: true,
                rowNum: 10,
                rowList: [10, 20, 30],
                colNames: ['序号', '主题', '作者', '创建时间'],
                colModel: [
                    {
                        name: 'id',
                        index: 'id',
                        width: 60,
                        sorttype: "int",
                        search: true,
                        sortable: true
                    },
                    {
                        name: 'title',
                        index: 'title',
                        width: 150,
                        search: true,
                        sortable: true
                        
                    },
                    {
                        name: 'author',
                        index: 'author',
                        width: 150,
                        search: true,
                        sortable: true
                    },
                    {
                        name: 'ctime',
                        index: 'ctime',
                        width: 150,
                        sorttype: "date",
                        formatter: "date",
                        	search: true,
                        	sortable: true
                    }
                ],
                pager: "#pager_list_2",
                viewrecords: true,
                multiselect: true,
                multikey: "ctrlKey",
                editurl : "<%=path %>/ws/meet/delete",
                caption: "会议纪要列表",
                add: false,
                addtext: 'Add',
                edittext: 'Edit',
                hidegrid: false
            });

            // Add selection
            $("#table_list_2").setSelection(4, true);


            // Setup buttons
            /* $("#table_list_2").jqGrid('navGrid', '#pager_list_2', {
                add: true,
                del: true,
                search: true,
                edit: false
            }, {
                height: 200,
                reloadAfterSubmit: true
            }); */
            
            jQuery("#table_list_2")  

            .navGrid('#pager_list_2',{edit:false,add:false,del:false,search:true})  

            .navButtonAdd('#pager_list_2',{  

               caption:"Add",   

               buttonicon:"ui-icon-add",   

               onClickButton: function(){   

                 alert("Adding Row");  

               },   

               position:"last"  

            }).navButtonAdd('#pager_list_2',{  

               caption:"Del",   

               buttonicon:"ui-icon-del",   

               onClickButton: function(){   

                  alert("Deleting Row");  

               },   

               position:"last"  

            });

            // Add responsive to jqGrid
            $(window).bind('resize', function () {
                var width = $('.jqGrid_wrapper').width();
                $('#table_list_2').setGridWidth(width);
            });
        })   
    </script>
    </body>
</html>


