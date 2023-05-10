<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fee.css" /> 

<div id="fee_manage"></div>
<div id="fee_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="fee_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="fee_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="fee_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="fee_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="fee_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="feeQueryForm" method="post">
			费用类别：<input class="textbox" type="text" id="feeTypeObj_typeId_query" name="feeTypeObj.typeId" style="width: auto"/>
			住户信息：<input class="textbox" type="text" id="ownerObj_ownerId_query" name="ownerObj.ownerId" style="width: auto"/>
			收费时间：<input type="text" id="feeDate" name="feeDate" class="easyui-datebox" editable="false" style="width:100px">
			收费内容：<input type="text" class="textbox" id="feeContent" name="feeContent" style="width:110px" />
			操作员：<input type="text" class="textbox" id="opUser" name="opUser" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="fee_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="feeEditDiv">
	<form id="feeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">费用id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_feeId_edit" name="fee.feeId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">费用类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="fee_feeTypeObj_typeId_edit" name="fee.feeTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">住户信息:</span>
			<span class="inputControl">
				<input class="textbox"  id="fee_ownerObj_ownerId_edit" name="fee.ownerObj.ownerId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收费时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_feeDate_edit" name="fee.feeDate" />

			</span>

		</div>
		<div>
			<span class="label">收费金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_feeMoney_edit" name="fee.feeMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">收费内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_feeContent_edit" name="fee.feeContent" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">操作员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_opUser_edit" name="fee.opUser" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Fee/js/fee_manage.js"></script> 
