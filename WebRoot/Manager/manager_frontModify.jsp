<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Manager" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Manager manager = (Manager)request.getAttribute("manager");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改管理员信息</TITLE>
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
  		<li class="active">管理员信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="managerEditForm" id="managerEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="manager_manageUserName_edit" class="col-md-3 text-right">用户名:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="manager_manageUserName_edit" name="manager.manageUserName" class="form-control" placeholder="请输入用户名" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="manager_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="manager_password_edit" name="manager.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="manager_manageType_edit" class="col-md-3 text-right">管理员类别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="manager_manageType_edit" name="manager.manageType" class="form-control" placeholder="请输入管理员类别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="manager_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="manager_name_edit" name="manager.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="manager_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="manager_sex_edit" name="manager.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="manager_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="manager_telephone_edit" name="manager.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxManagerModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#managerEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改管理员界面并初始化数据*/
function managerEdit(manageUserName) {
	$.ajax({
		url :  basePath + "Manager/" + manageUserName + "/update",
		type : "get",
		dataType: "json",
		success : function (manager, response, status) {
			if (manager) {
				$("#manager_manageUserName_edit").val(manager.manageUserName);
				$("#manager_password_edit").val(manager.password);
				$("#manager_manageType_edit").val(manager.manageType);
				$("#manager_name_edit").val(manager.name);
				$("#manager_sex_edit").val(manager.sex);
				$("#manager_telephone_edit").val(manager.telephone);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交管理员信息表单给服务器端修改*/
function ajaxManagerModify() {
	$.ajax({
		url :  basePath + "Manager/" + $("#manager_manageUserName_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#managerEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#managerQueryForm").submit();
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
    managerEdit("<%=request.getParameter("manageUserName")%>");
 })
 </script> 
</body>
</html>

