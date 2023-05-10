<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/leaveWord.css" /> 

<div id="leaveWord_manage"></div>
<div id="leaveWord_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="leaveWord_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="leaveWord_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="leaveWord_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="leaveWord_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="leaveWord_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="leaveWordQueryForm" method="post">
			标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			发布时间：<input type="text" class="textbox" id="addTime" name="addTime" style="width:110px" />
			提交住户：<input class="textbox" type="text" id="ownerObj_ownerId_query" name="ownerObj.ownerId" style="width: auto"/>
			回复人：<input type="text" class="textbox" id="opUser" name="opUser" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="leaveWord_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="leaveWordEditDiv">
	<form id="leaveWordEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_leaveWordId_edit" name="leaveWord.leaveWordId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_title_edit" name="leaveWord.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">内容:</span>
			<span class="inputControl">
				<textarea id="leaveWord_content_edit" name="leaveWord.content" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_addTime_edit" name="leaveWord.addTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">提交住户:</span>
			<span class="inputControl">
				<input class="textbox"  id="leaveWord_ownerObj_ownerId_edit" name="leaveWord.ownerObj.ownerId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">回复内容:</span>
			<span class="inputControl">
				<textarea id="leaveWord_replyContent_edit" name="leaveWord.replyContent" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">回复时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_replyTime_edit" name="leaveWord.replyTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">回复人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_opUser_edit" name="leaveWord.opUser" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="LeaveWord/js/leaveWord_manage.js"></script> 
