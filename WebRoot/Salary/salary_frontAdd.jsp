<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Employee" %>
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
<title>工资添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Salary/frontlist">工资列表</a></li>
			    	<li role="presentation" class="active"><a href="#salaryAdd" aria-controls="salaryAdd" role="tab" data-toggle="tab">添加工资</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="salaryList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="salaryAdd"> 
				      	<form class="form-horizontal" name="salaryAddForm" id="salaryAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="salary_employeeObj_employeeNo" class="col-md-2 text-right">员工:</label>
						  	 <div class="col-md-8">
							    <select id="salary_employeeObj_employeeNo" name="salary.employeeObj.employeeNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="salary_year" class="col-md-2 text-right">工资年份:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="salary_year" name="salary.year" class="form-control" placeholder="请输入工资年份">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="salary_month" class="col-md-2 text-right">工资月份:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="salary_month" name="salary.month" class="form-control" placeholder="请输入工资月份">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="salary_salaryMoney" class="col-md-2 text-right">工资金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="salary_salaryMoney" name="salary.salaryMoney" class="form-control" placeholder="请输入工资金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="salary_fafang" class="col-md-2 text-right">是否发放:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="salary_fafang" name="salary.fafang" class="form-control" placeholder="请输入是否发放">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxSalaryAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#salaryAddForm .form-group {margin:10px;}  </style>
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
	//提交添加工资信息
	function ajaxSalaryAdd() { 
		//提交之前先验证表单
		$("#salaryAddForm").data('bootstrapValidator').validate();
		if(!$("#salaryAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Salary/add",
			dataType : "json" , 
			data: new FormData($("#salaryAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#salaryAddForm").find("input").val("");
					$("#salaryAddForm").find("textarea").val("");
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
	//验证工资添加表单字段
	$('#salaryAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"salary.year": {
				validators: {
					notEmpty: {
						message: "工资年份不能为空",
					}
				}
			},
			"salary.month": {
				validators: {
					notEmpty: {
						message: "工资月份不能为空",
					}
				}
			},
			"salary.salaryMoney": {
				validators: {
					notEmpty: {
						message: "工资金额不能为空",
					},
					numeric: {
						message: "工资金额不正确"
					}
				}
			},
			"salary.fafang": {
				validators: {
					notEmpty: {
						message: "是否发放不能为空",
					}
				}
			},
		}
	}); 
	//初始化员工下拉框值 
	$.ajax({
		url: basePath + "Employee/listAll",
		type: "get",
		success: function(employees,response,status) { 
			$("#salary_employeeObj_employeeNo").empty();
			var html="";
    		$(employees).each(function(i,employee){
    			html += "<option value='" + employee.employeeNo + "'>" + employee.name + "</option>";
    		});
    		$("#salary_employeeObj_employeeNo").html(html);
    	}
	});
})
</script>
</body>
</html>
