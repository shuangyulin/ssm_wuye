<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/repair.css" />
<div id="repairAddDiv">
	<form id="repairAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">报修用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="repair_ownerObj_ownerId" name="repair.ownerObj.ownerId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">报修日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="repair_repairDate" name="repair.repairDate" />

			</span>

		</div>
		<div>
			<span class="label">问题描述:</span>
			<span class="inputControl">
				<textarea id="repair_questionDesc" name="repair.questionDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">报修状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="repair_repairState" name="repair.repairState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">处理结果:</span>
			<span class="inputControl">
				<textarea id="repair_handleResult" name="repair.handleResult" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="repairAddButton" class="easyui-linkbutton">添加</a>
			<a id="repairClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Repair/js/repair_add.js"></script> 
