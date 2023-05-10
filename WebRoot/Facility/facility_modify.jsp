<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/facility.css" />
<div id="facility_editDiv">
	<form id="facilityEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">设施id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_facilityId_edit" name="facility.facilityId" value="<%=request.getParameter("facilityId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">设施名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_name_edit" name="facility.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_count_edit" name="facility.count" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">开始使用时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_startTime_edit" name="facility.startTime" />

			</span>

		</div>
		<div>
			<span class="label">设施状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="facility_facilityState_edit" name="facility.facilityState" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="facilityModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Facility/js/facility_modify.js"></script> 
