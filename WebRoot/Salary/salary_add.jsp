<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/salary.css" />
<div id="salaryAddDiv">
	<form id="salaryAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">员工:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_employeeObj_employeeNo" name="salary.employeeObj.employeeNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">工资年份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_year" name="salary.year" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工资月份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_month" name="salary.month" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工资金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_salaryMoney" name="salary.salaryMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">是否发放:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_fafang" name="salary.fafang" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="salaryAddButton" class="easyui-linkbutton">添加</a>
			<a id="salaryClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Salary/js/salary_add.js"></script> 
