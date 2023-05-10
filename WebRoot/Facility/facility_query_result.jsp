<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/facility.css" /> 

<div id="facility_manage"></div>
<div id="facility_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="facility_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="facility_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="facility_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="facility_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="facility_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="facilityQueryForm" method="post">
			设施名称：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			开始使用时间：<input type="text" id="startTime" name="startTime" class="easyui-datebox" editable="false" style="width:100px">
			设施状态：<input type="text" class="textbox" id="facilityState" name="facilityState" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="facility_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="facilityEditDiv">
	<form id="facilityEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">设施id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_facilityId_edit" name="facility.facilityId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">设施名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_name_edit" name="facility.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_count_edit" name="facility.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">开始使用时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_startTime_edit" name="facility.startTime" />

			</span>

		</div>
		<div>
			<span class="label">设施状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_facilityState_edit" name="facility.facilityState" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Facility/js/facility_manage.js"></script> 
