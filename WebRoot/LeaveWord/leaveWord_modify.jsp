<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/leaveWord.css" />
<div id="leaveWord_editDiv">
	<form id="leaveWordEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="leaveWord_leaveWordId_edit" name="leaveWord.leaveWordId" value="<%=request.getParameter("leaveWordId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="leaveWordModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/LeaveWord/js/leaveWord_modify.js"></script> 
