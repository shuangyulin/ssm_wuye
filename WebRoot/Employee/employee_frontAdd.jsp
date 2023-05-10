<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>员工添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Employee/frontlist">员工列表</a></li>
			    	<li role="presentation" class="active"><a href="#employeeAdd" aria-controls="employeeAdd" role="tab" data-toggle="tab">添加员工</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="employeeList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="employeeAdd"> 
				      	<form class="form-horizontal" name="employeeAddForm" id="employeeAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
							 <label for="employee_employeeNo" class="col-md-2 text-right">员工编号:</label>
							 <div class="col-md-8"> 
							 	<input type="text" id="employee_employeeNo" name="employee.employeeNo" class="form-control" placeholder="请输入员工编号">
							 </div>
						  </div> 
						  <div class="form-group">
						  	 <label for="employee_name" class="col-md-2 text-right">姓名:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="employee_name" name="employee.name" class="form-control" placeholder="请输入姓名">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="employee_sex" class="col-md-2 text-right">性别:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="employee_sex" name="employee.sex" class="form-control" placeholder="请输入性别">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="employee_positionName" class="col-md-2 text-right">职位:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="employee_positionName" name="employee.positionName" class="form-control" placeholder="请输入职位">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="employee_telephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="employee_telephone" name="employee.telephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="employee_address" class="col-md-2 text-right">地址:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="employee_address" name="employee.address" class="form-control" placeholder="请输入地址">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="employee_employeeDesc" class="col-md-2 text-right">员工介绍:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="employee_employeeDesc" name="employee.employeeDesc" class="form-control" placeholder="请输入员工介绍">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxEmployeeAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#employeeAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加员工信息
	function ajaxEmployeeAdd() { 
		//提交之前先验证表单
		$("#employeeAddForm").data('bootstrapValidator').validate();
		if(!$("#employeeAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Employee/add",
			dataType : "json" , 
			data: new FormData($("#employeeAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#employeeAddForm").find("input").val("");
					$("#employeeAddForm").find("textarea").val("");
				} else {
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
	//验证员工添加表单字段
	$('#employeeAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"employee.employeeNo": {
				validators: {
					notEmpty: {
						message: "员工编号不能为空",
					}
				}
			},
			"employee.name": {
				validators: {
					notEmpty: {
						message: "姓名不能为空",
					}
				}
			},
			"employee.sex": {
				validators: {
					notEmpty: {
						message: "性别不能为空",
					}
				}
			},
			"employee.positionName": {
				validators: {
					notEmpty: {
						message: "职位不能为空",
					}
				}
			},
			"employee.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"employee.address": {
				validators: {
					notEmpty: {
						message: "地址不能为空",
					}
				}
			},
			"employee.employeeDesc": {
				validators: {
					notEmpty: {
						message: "员工介绍不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
