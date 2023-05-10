<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Building" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Building building = (Building)request.getAttribute("building");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改楼栋信息</TITLE>
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
  		<li class="active">楼栋信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="buildingEditForm" id="buildingEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="building_buildingId_edit" class="col-md-3 text-right">楼栋id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="building_buildingId_edit" name="building.buildingId" class="form-control" placeholder="请输入楼栋id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="building_buildingName_edit" class="col-md-3 text-right">楼栋名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="building_buildingName_edit" name="building.buildingName" class="form-control" placeholder="请输入楼栋名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="building_memo_edit" class="col-md-3 text-right">楼栋备注:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="building_memo_edit" name="building.memo" class="form-control" placeholder="请输入楼栋备注">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBuildingModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#buildingEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改楼栋界面并初始化数据*/
function buildingEdit(buildingId) {
	$.ajax({
		url :  basePath + "Building/" + buildingId + "/update",
		type : "get",
		dataType: "json",
		success : function (building, response, status) {
			if (building) {
				$("#building_buildingId_edit").val(building.buildingId);
				$("#building_buildingName_edit").val(building.buildingName);
				$("#building_memo_edit").val(building.memo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交楼栋信息表单给服务器端修改*/
function ajaxBuildingModify() {
	$.ajax({
		url :  basePath + "Building/" + $("#building_buildingId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#buildingEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "Building/frontlist";
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
    buildingEdit("<%=request.getParameter("buildingId")%>");
 })
 </script> 
</body>
</html>

