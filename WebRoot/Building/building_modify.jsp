<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/building.css" />
<div id="building_editDiv">
	<form id="buildingEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">楼栋id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="building_buildingId_edit" name="building.buildingId" value="<%=request.getParameter("buildingId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">楼栋名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="building_buildingName_edit" name="building.buildingName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">楼栋备注:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="building_memo_edit" name="building.memo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="buildingModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Building/js/building_modify.js"></script> 
