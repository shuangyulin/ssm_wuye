<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/parking.css" />
<div id="parking_editDiv">
	<form id="parkingEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">车位id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="parking_parkingId_edit" name="parking.parkingId" value="<%=request.getParameter("parkingId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">车位名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="parking_parkingName_edit" name="parking.parkingName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">车牌号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="parking_plateNumber_edit" name="parking.plateNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">车主:</span>
			<span class="inputControl">
				<input class="textbox"  id="parking_ownerObj_ownerId_edit" name="parking.ownerObj.ownerId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">操作员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="parking_opUser_edit" name="parking.opUser" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="parkingModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Parking/js/parking_modify.js"></script> 
