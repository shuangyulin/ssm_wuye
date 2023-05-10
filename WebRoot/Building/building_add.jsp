<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/building.css" />
<div id="buildingAddDiv">
	<form id="buildingAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">楼栋名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="building_buildingName" name="building.buildingName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">楼栋备注:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="building_memo" name="building.memo" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="buildingAddButton" class="easyui-linkbutton">添加</a>
			<a id="buildingClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Building/js/building_add.js"></script> 
