<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fee.css" />
<div id="fee_editDiv">
	<form id="feeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">费用id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_feeId_edit" name="fee.feeId" value="<%=request.getParameter("feeId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="feeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Fee/js/fee_modify.js"></script> 
