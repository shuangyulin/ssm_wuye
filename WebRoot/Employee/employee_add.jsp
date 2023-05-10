<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/employee.css" />
<div id="employeeAddDiv">
	<form id="employeeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">员工编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_employeeNo" name="employee.employeeNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_name" name="employee.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_sex" name="employee.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_positionName" name="employee.positionName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_telephone" name="employee.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_address" name="employee.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">员工介绍:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_employeeDesc" name="employee.employeeDesc" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="employeeAddButton" class="easyui-linkbutton">添加</a>
			<a id="employeeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Employee/js/employee_add.js"></script> 
