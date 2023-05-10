<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/feeType.css" />
<div id="feeTypeAddDiv">
	<form id="feeTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="feeType_typeName" name="feeType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="feeTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="feeTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/FeeType/js/feeType_add.js"></script> 
