<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/manager.css" />
<div id="managerAddDiv">
	<form id="managerAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">用户名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_manageUserName" name="manager.manageUserName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_password" name="manager.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">管理员类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_manageType" name="manager.manageType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_name" name="manager.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_sex" name="manager.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="manager_telephone" name="manager.telephone" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="managerAddButton" class="easyui-linkbutton">添加</a>
			<a id="managerClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Manager/js/manager_add.js"></script> 
