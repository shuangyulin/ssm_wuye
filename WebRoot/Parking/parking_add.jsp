<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/parking.css" />
<div id="parkingAddDiv">
	<form id="parkingAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">车位名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="parking_parkingName" name="parking.parkingName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">车牌号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="parking_plateNumber" name="parking.plateNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">车主:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="parking_ownerObj_ownerId" name="parking.ownerObj.ownerId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">操作员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="parking_opUser" name="parking.opUser" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="parkingAddButton" class="easyui-linkbutton">添加</a>
			<a id="parkingClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Parking/js/parking_add.js"></script> 
