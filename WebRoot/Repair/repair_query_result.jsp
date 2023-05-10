<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/repair.css" /> 

<div id="repair_manage"></div>
<div id="repair_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="repair_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="repair_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="repair_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="repair_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="repair_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="repairQueryForm" method="post">
			报修用户：<input class="textbox" type="text" id="ownerObj_ownerId_query" name="ownerObj.ownerId" style="width: auto"/>
			报修日期：<input type="text" id="repairDate" name="repairDate" class="easyui-datebox" editable="false" style="width:100px">
			问题描述：<input type="text" class="textbox" id="questionDesc" name="questionDesc" style="width:110px" />
			报修状态：<input type="text" class="textbox" id="repairState" name="repairState" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="repair_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="repairEditDiv">
	<form id="repairEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">报修id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="repair_repairId_edit" name="repair.repairId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">报修用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="repair_ownerObj_ownerId_edit" name="repair.ownerObj.ownerId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">报修日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="repair_repairDate_edit" name="repair.repairDate" />

			</span>

		</div>
		<div>
			<span class="label">问题描述:</span>
			<span class="inputControl">
				<textarea id="repair_questionDesc_edit" name="repair.questionDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">报修状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="repair_repairState_edit" name="repair.repairState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">处理结果:</span>
			<span class="inputControl">
				<textarea id="repair_handleResult_edit" name="repair.handleResult" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Repair/js/repair_manage.js"></script> 
