<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/salary.css" />
<div id="salary_editDiv">
	<form id="salaryEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">工资id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_salaryId_edit" name="salary.salaryId" value="<%=request.getParameter("salaryId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">员工:</span>
			<span class="inputControl">
				<input class="textbox"  id="salary_employeeObj_employeeNo_edit" name="salary.employeeObj.employeeNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">工资年份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_year_edit" name="salary.year" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工资月份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_month_edit" name="salary.month" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工资金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_salaryMoney_edit" name="salary.salaryMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">是否发放:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_fafang_edit" name="salary.fafang" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="salaryModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Salary/js/salary_modify.js"></script> 
