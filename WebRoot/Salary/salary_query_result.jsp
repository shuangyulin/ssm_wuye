<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/salary.css" /> 

<div id="salary_manage"></div>
<div id="salary_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="salary_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="salary_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="salary_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="salary_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="salary_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="salaryQueryForm" method="post">
			员工：<input class="textbox" type="text" id="employeeObj_employeeNo_query" name="employeeObj.employeeNo" style="width: auto"/>
			工资年份：<input type="text" class="textbox" id="year" name="year" style="width:110px" />
			工资月份：<input type="text" class="textbox" id="month" name="month" style="width:110px" />
			是否发放：<input type="text" class="textbox" id="fafang" name="fafang" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="salary_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="salaryEditDiv">
	<form id="salaryEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">工资id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_salaryId_edit" name="salary.salaryId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">员工:</span>
			<span class="inputControl">
				<input class="textbox"  id="salary_employeeObj_employeeNo_edit" name="salary.employeeObj.employeeNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">工资年份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_year_edit" name="salary.year" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工资月份:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_month_edit" name="salary.month" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工资金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_salaryMoney_edit" name="salary.salaryMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">是否发放:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="salary_fafang_edit" name="salary.fafang" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Salary/js/salary_manage.js"></script> 
