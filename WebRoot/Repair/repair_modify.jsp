<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/repair.css" />
<div id="repair_editDiv">
	<form id="repairEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">报修id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="repair_repairId_edit" name="repair.repairId" value="<%=request.getParameter("repairId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="repairModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Repair/js/repair_modify.js"></script> 
