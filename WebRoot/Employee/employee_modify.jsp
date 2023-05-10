<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/employee.css" />
<div id="employee_editDiv">
	<form id="employeeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">员工编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_employeeNo_edit" name="employee.employeeNo" value="<%=request.getParameter("employeeNo") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_name_edit" name="employee.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_sex_edit" name="employee.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_positionName_edit" name="employee.positionName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_telephone_edit" name="employee.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_address_edit" name="employee.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">员工介绍:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_employeeDesc_edit" name="employee.employeeDesc" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="employeeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Employee/js/employee_modify.js"></script> 
