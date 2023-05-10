<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/manager.css" />
<div id="manager_editDiv">
	<form id="managerEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_manageUserName_edit" name="manager.manageUserName" value="<%=request.getParameter("manageUserName") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_password_edit" name="manager.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">管理员类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_manageType_edit" name="manager.manageType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_name_edit" name="manager.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_sex_edit" name="manager.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_telephone_edit" name="manager.telephone" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="managerModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Manager/js/manager_modify.js"></script> 
