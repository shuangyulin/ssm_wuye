<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/building.css" /> 

<div id="building_manage"></div>
<div id="building_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="building_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="building_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="building_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="building_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="building_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="buildingQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="buildingEditDiv">
	<form id="buildingEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">楼栋id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="building_buildingId_edit" name="building.buildingId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Building/js/building_manage.js"></script> 
