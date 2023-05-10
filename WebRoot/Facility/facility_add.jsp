<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/facility.css" />
<div id="facilityAddDiv">
	<form id="facilityAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">设施名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_name" name="facility.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_count" name="facility.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">开始使用时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_startTime" name="facility.startTime" />

			</span>

		</div>
		<div>
			<span class="label">设施状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_facilityState" name="facility.facilityState" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="facilityAddButton" class="easyui-linkbutton">添加</a>
			<a id="facilityClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Facility/js/facility_add.js"></script> 
