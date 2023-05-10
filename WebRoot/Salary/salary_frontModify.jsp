<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Salary" %>
<%@ page import="com.chengxusheji.po.Employee" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的employeeObj信息
    List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
    Salary salary = (Salary)request.getAttribute("salary");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改工资信息</TITLE>
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
  		<li class="active">工资信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="salaryEditForm" id="salaryEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="salary_salaryId_edit" class="col-md-3 text-right">工资id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="salary_salaryId_edit" name="salary.salaryId" class="form-control" placeholder="请输入工资id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="salary_employeeObj_employeeNo_edit" class="col-md-3 text-right">员工:</label>
		  	 <div class="col-md-9">
			    <select id="salary_employeeObj_employeeNo_edit" name="salary.employeeObj.employeeNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="salary_year_edit" class="col-md-3 text-right">工资年份:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="salary_year_edit" name="salary.year" class="form-control" placeholder="请输入工资年份">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="salary_month_edit" class="col-md-3 text-right">工资月份:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="salary_month_edit" name="salary.month" class="form-control" placeholder="请输入工资月份">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="salary_salaryMoney_edit" class="col-md-3 text-right">工资金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="salary_salaryMoney_edit" name="salary.salaryMoney" class="form-control" placeholder="请输入工资金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="salary_fafang_edit" class="col-md-3 text-right">是否发放:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="salary_fafang_edit" name="salary.fafang" class="form-control" placeholder="请输入是否发放">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxSalaryModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#salaryEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改工资界面并初始化数据*/
function salaryEdit(salaryId) {
	$.ajax({
		url :  basePath + "Salary/" + salaryId + "/update",
		type : "get",
		dataType: "json",
		success : function (salary, response, status) {
			if (salary) {
				$("#salary_salaryId_edit").val(salary.salaryId);
				$.ajax({
					url: basePath + "Employee/listAll",
					type: "get",
					success: function(employees,response,status) { 
						$("#salary_employeeObj_employeeNo_edit").empty();
						var html="";
		        		$(employees).each(function(i,employee){
		        			html += "<option value='" + employee.employeeNo + "'>" + employee.name + "</option>";
		        		});
		        		$("#salary_employeeObj_employeeNo_edit").html(html);
		        		$("#salary_employeeObj_employeeNo_edit").val(salary.employeeObjPri);
					}
				});
				$("#salary_year_edit").val(salary.year);
				$("#salary_month_edit").val(salary.month);
				$("#salary_salaryMoney_edit").val(salary.salaryMoney);
				$("#salary_fafang_edit").val(salary.fafang);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交工资信息表单给服务器端修改*/
function ajaxSalaryModify() {
	$.ajax({
		url :  basePath + "Salary/" + $("#salary_salaryId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#salaryEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#salaryQueryForm").submit();
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
    salaryEdit("<%=request.getParameter("salaryId")%>");
 })
 </script> 
</body>
</html>

