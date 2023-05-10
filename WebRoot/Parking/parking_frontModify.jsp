<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Parking" %>
<%@ page import="com.chengxusheji.po.Owner" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的ownerObj信息
    List<Owner> ownerList = (List<Owner>)request.getAttribute("ownerList");
    Parking parking = (Parking)request.getAttribute("parking");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改停车位信息</TITLE>
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
  		<li class="active">停车位信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="parkingEditForm" id="parkingEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="parking_parkingId_edit" class="col-md-3 text-right">车位id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="parking_parkingId_edit" name="parking.parkingId" class="form-control" placeholder="请输入车位id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="parking_parkingName_edit" class="col-md-3 text-right">车位名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="parking_parkingName_edit" name="parking.parkingName" class="form-control" placeholder="请输入车位名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="parking_plateNumber_edit" class="col-md-3 text-right">车牌号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="parking_plateNumber_edit" name="parking.plateNumber" class="form-control" placeholder="请输入车牌号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="parking_ownerObj_ownerId_edit" class="col-md-3 text-right">车主:</label>
		  	 <div class="col-md-9">
			    <select id="parking_ownerObj_ownerId_edit" name="parking.ownerObj.ownerId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="parking_opUser_edit" class="col-md-3 text-right">操作员:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="parking_opUser_edit" name="parking.opUser" class="form-control" placeholder="请输入操作员">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxParkingModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#parkingEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改停车位界面并初始化数据*/
function parkingEdit(parkingId) {
	$.ajax({
		url :  basePath + "Parking/" + parkingId + "/update",
		type : "get",
		dataType: "json",
		success : function (parking, response, status) {
			if (parking) {
				$("#parking_parkingId_edit").val(parking.parkingId);
				$("#parking_parkingName_edit").val(parking.parkingName);
				$("#parking_plateNumber_edit").val(parking.plateNumber);
				$.ajax({
					url: basePath + "Owner/listAll",
					type: "get",
					success: function(owners,response,status) { 
						$("#parking_ownerObj_ownerId_edit").empty();
						var html="";
		        		$(owners).each(function(i,owner){
		        			html += "<option value='" + owner.ownerId + "'>" + owner.ownerName + "</option>";
		        		});
		        		$("#parking_ownerObj_ownerId_edit").html(html);
		        		$("#parking_ownerObj_ownerId_edit").val(parking.ownerObjPri);
					}
				});
				$("#parking_opUser_edit").val(parking.opUser);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交停车位信息表单给服务器端修改*/
function ajaxParkingModify() {
	$.ajax({
		url :  basePath + "Parking/" + $("#parking_parkingId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#parkingEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#parkingQueryForm").submit();
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
    parkingEdit("<%=request.getParameter("parkingId")%>");
 })
 </script> 
</body>
</html>

