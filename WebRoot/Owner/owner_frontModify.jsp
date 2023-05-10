<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Owner" %>
<%@ page import="com.chengxusheji.po.Building" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的buildingObj信息
    List<Building> buildingList = (List<Building>)request.getAttribute("buildingList");
    Owner owner = (Owner)request.getAttribute("owner");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改业主信息</TITLE>
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
  		<li class="active">业主信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="ownerEditForm" id="ownerEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="owner_ownerId_edit" class="col-md-3 text-right">业主id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="owner_ownerId_edit" name="owner.ownerId" class="form-control" placeholder="请输入业主id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="owner_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_password_edit" name="owner.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_buildingObj_buildingId_edit" class="col-md-3 text-right">楼栋名称:</label>
		  	 <div class="col-md-9">
			    <select id="owner_buildingObj_buildingId_edit" name="owner.buildingObj.buildingId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_roomNo_edit" class="col-md-3 text-right">房间号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_roomNo_edit" name="owner.roomNo" class="form-control" placeholder="请输入房间号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_ownerName_edit" class="col-md-3 text-right">户主:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_ownerName_edit" name="owner.ownerName" class="form-control" placeholder="请输入户主">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_area_edit" class="col-md-3 text-right">房屋面积:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_area_edit" name="owner.area" class="form-control" placeholder="请输入房屋面积">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_telephone_edit" class="col-md-3 text-right">联系方式:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_telephone_edit" name="owner.telephone" class="form-control" placeholder="请输入联系方式">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_memo_edit" class="col-md-3 text-right">备注信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="owner_memo_edit" name="owner.memo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxOwnerModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#ownerEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改业主界面并初始化数据*/
function ownerEdit(ownerId) {
	$.ajax({
		url :  basePath + "Owner/" + ownerId + "/update",
		type : "get",
		dataType: "json",
		success : function (owner, response, status) {
			if (owner) {
				$("#owner_ownerId_edit").val(owner.ownerId);
				$("#owner_password_edit").val(owner.password);
				$.ajax({
					url: basePath + "Building/listAll",
					type: "get",
					success: function(buildings,response,status) { 
						$("#owner_buildingObj_buildingId_edit").empty();
						var html="";
		        		$(buildings).each(function(i,building){
		        			html += "<option value='" + building.buildingId + "'>" + building.buildingName + "</option>";
		        		});
		        		$("#owner_buildingObj_buildingId_edit").html(html);
		        		$("#owner_buildingObj_buildingId_edit").val(owner.buildingObjPri);
					}
				});
				$("#owner_roomNo_edit").val(owner.roomNo);
				$("#owner_ownerName_edit").val(owner.ownerName);
				$("#owner_area_edit").val(owner.area);
				$("#owner_telephone_edit").val(owner.telephone);
				$("#owner_memo_edit").val(owner.memo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交业主信息表单给服务器端修改*/
function ajaxOwnerModify() {
	$.ajax({
		url :  basePath + "Owner/" + $("#owner_ownerId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#ownerEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#ownerQueryForm").submit();
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
    ownerEdit("<%=request.getParameter("ownerId")%>");
 })
 </script> 
</body>
</html>

