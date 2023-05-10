<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/fee.css" />
<div id="feeAddDiv">
	<form id="feeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">费用类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_feeTypeObj_typeId" name="fee.feeTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">住户信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_ownerObj_ownerId" name="fee.ownerObj.ownerId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收费时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_feeDate" name="fee.feeDate" />

			</span>

		</div>
		<div>
			<span class="label">收费金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_feeMoney" name="fee.feeMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">收费内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_feeContent" name="fee.feeContent" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">操作员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="fee_opUser" name="fee.opUser" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="feeAddButton" class="easyui-linkbutton">添加</a>
			<a id="feeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Fee/js/fee_add.js"></script> 
