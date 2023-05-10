<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/owner.css" /> 

<div id="owner_manage"></div>
<div id="owner_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="owner_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="owner_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="owner_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="owner_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="owner_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="ownerQueryForm" method="post">
			楼栋名称：<input class="textbox" type="text" id="buildingObj_buildingId_query" name="buildingObj.buildingId" style="width: auto"/>
			房间号：<input type="text" class="textbox" id="roomNo" name="roomNo" style="width:110px" />
			户主：<input type="text" class="textbox" id="ownerName" name="ownerName" style="width:110px" />
			联系方式：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="owner_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="ownerEditDiv">
	<form id="ownerEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">业主id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="owner_ownerId_edit" name="owner.ownerId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Owner/js/owner_manage.js"></script> 
