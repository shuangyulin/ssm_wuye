<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/feeType.css" />
<div id="feeType_editDiv">
	<form id="feeTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="feeType_typeId_edit" name="feeType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="feeType_typeName_edit" name="feeType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="feeTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/FeeType/js/feeType_modify.js"></script> 
