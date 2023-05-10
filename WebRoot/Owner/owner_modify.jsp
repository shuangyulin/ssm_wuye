<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/owner.css" />
<div id="owner_editDiv">
	<form id="ownerEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">业主id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_ownerId_edit" name="owner.ownerId" value="<%=request.getParameter("ownerId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_password_edit" name="owner.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">楼栋名称:</span>
			<span class="inputControl">
				<input class="textbox"  id="owner_buildingObj_buildingId_edit" name="owner.buildingObj.buildingId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房间号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_roomNo_edit" name="owner.roomNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">户主:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_ownerName_edit" name="owner.ownerName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">房屋面积:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_area_edit" name="owner.area" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系方式:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_telephone_edit" name="owner.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">备注信息:</span>
			<span class="inputControl">
				<textarea id="owner_memo_edit" name="owner.memo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="ownerModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Owner/js/owner_modify.js"></script> 
