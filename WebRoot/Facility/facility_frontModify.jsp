<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Facility" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Facility facility = (Facility)request.getAttribute("facility");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改设施信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">设施信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="facilityEditForm" id="facilityEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="facility_facilityId_edit" class="col-md-3 text-right">设施id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="facility_facilityId_edit" name="facility.facilityId" class="form-control" placeholder="请输入设施id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="facility_name_edit" class="col-md-3 text-right">设施名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="facility_name_edit" name="facility.name" class="form-control" placeholder="请输入设施名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="facility_count_edit" class="col-md-3 text-right">数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="facility_count_edit" name="facility.count" class="form-control" placeholder="请输入数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="facility_startTime_edit" class="col-md-3 text-right">开始使用时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date facility_startTime_edit col-md-12" data-link-field="facility_startTime_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="facility_startTime_edit" name="facility.startTime" size="16" type="text" value="" placeholder="请选择开始使用时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="facility_facilityState_edit" class="col-md-3 text-right">设施状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="facility_facilityState_edit" name="facility.facilityState" class="form-control" placeholder="请输入设施状态">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxFacilityModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#facilityEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改设施界面并初始化数据*/
function facilityEdit(facilityId) {
	$.ajax({
		url :  basePath + "Facility/" + facilityId + "/update",
		type : "get",
		dataType: "json",
		success : function (facility, response, status) {
			if (facility) {
				$("#facility_facilityId_edit").val(facility.facilityId);
				$("#facility_name_edit").val(facility.name);
				$("#facility_count_edit").val(facility.count);
				$("#facility_startTime_edit").val(facility.startTime);
				$("#facility_facilityState_edit").val(facility.facilityState);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交设施信息表单给服务器端修改*/
function ajaxFacilityModify() {
	$.ajax({
		url :  basePath + "Facility/" + $("#facility_facilityId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#facilityEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#facilityQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*开始使用时间组件*/
    $('.facility_startTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    facilityEdit("<%=request.getParameter("facilityId")%>");
 })
 </script> 
</body>
</html>

