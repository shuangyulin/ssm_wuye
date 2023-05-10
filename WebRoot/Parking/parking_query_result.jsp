<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/parking.css" /> 

<div id="parking_manage"></div>
<div id="parking_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="parking_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="parking_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="parking_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="parking_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="parking_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="parkingQueryForm" method="post">
			车位名称：<input type="text" class="textbox" id="parkingName" name="parkingName" style="width:110px" />
			车牌号：<input type="text" class="textbox" id="plateNumber" name="plateNumber" style="width:110px" />
			车主：<input class="textbox" type="text" id="ownerObj_ownerId_query" name="ownerObj.ownerId" style="width: auto"/>
			操作员：<input type="text" class="textbox" id="opUser" name="opUser" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="parking_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="parkingEditDiv">
	<form id="parkingEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">车位id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="parking_parkingId_edit" name="parking.parkingId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Parking/js/parking_manage.js"></script> 
