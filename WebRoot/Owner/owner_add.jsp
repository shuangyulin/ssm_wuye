<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/owner.css" />
<div id="ownerAddDiv">
	<form id="ownerAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_password" name="owner.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">楼栋名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_buildingObj_buildingId" name="owner.buildingObj.buildingId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_roomNo" name="owner.roomNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">户主:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_ownerName" name="owner.ownerName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房屋面积:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_area" name="owner.area" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系方式:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_telephone" name="owner.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">备注信息:</span>
			<span class="inputControl">
				<textarea id="owner_memo" name="owner.memo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="ownerAddButton" class="easyui-linkbutton">添加</a>
			<a id="ownerClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Owner/js/owner_add.js"></script> 
