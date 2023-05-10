var salary_manage_tool = null; 
$(function () { 
	initSalaryManageTool(); //建立Salary管理对象
	salary_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#salary_manage").datagrid({
		url : 'Salary/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "salaryId",
		sortOrder : "desc",
		toolbar : "#salary_manage_tool",
		columns : [[
			{
				field : "salaryId",
				title : "工资id",
				width : 70,
			},
			{
				field : "employeeObj",
				title : "员工",
				width : 140,
			},
			{
				field : "year",
				title : "工资年份",
				width : 140,
			},
			{
				field : "month",
				title : "工资月份",
				width : 140,
			},
			{
				field : "salaryMoney",
				title : "工资金额",
				width : 70,
			},
			{
				field : "fafang",
				title : "是否发放",
				width : 140,
			},
		]],
	});

	$("#salaryEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#salaryEditForm").form("validate")) {
					//验证表单 
					if(!$("#salaryEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#salaryEditForm").form({
						    url:"Salary/" + $("#salary_salaryId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#salaryEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#salaryEditDiv").dialog("close");
			                        salary_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#salaryEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#salaryEditDiv").dialog("close");
				$("#salaryEditForm").form("reset"); 
			},
		}],
	});
});

function initSalaryManageTool() {
	salary_manage_tool = {
		init: function() {
			$.ajax({
				url : "Employee/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#employeeObj_employeeNo_query").combobox({ 
					    valueField:"employeeNo",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{employeeNo:"",name:"不限制"});
					$("#employeeObj_employeeNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#salary_manage").datagrid("reload");
		},
		redo : function () {
			$("#salary_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#salary_manage").datagrid("options").queryParams;
			queryParams["employeeObj.employeeNo"] = $("#employeeObj_employeeNo_query").combobox("getValue");
			queryParams["year"] = $("#year").val();
			queryParams["month"] = $("#month").val();
			queryParams["fafang"] = $("#fafang").val();
			$("#salary_manage").datagrid("options").queryParams=queryParams; 
			$("#salary_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#salaryQueryForm").form({
			    url:"Salary/OutToExcel",
			});
			//提交表单
			$("#salaryQueryForm").submit();
		},
		remove : function () {
			var rows = $("#salary_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var salaryIds = [];
						for (var i = 0; i < rows.length; i ++) {
							salaryIds.push(rows[i].salaryId);
						}
						$.ajax({
							type : "POST",
							url : "Salary/deletes",
							data : {
								salaryIds : salaryIds.join(","),
							},
							beforeSend : function () {
								$("#salary_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#salary_manage").datagrid("loaded");
									$("#salary_manage").datagrid("load");
									$("#salary_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#salary_manage").datagrid("loaded");
									$("#salary_manage").datagrid("load");
									$("#salary_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#salary_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Salary/" + rows[0].salaryId +  "/update",
					type : "get",
					data : {
						//salaryId : rows[0].salaryId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (salary, response, status) {
						$.messager.progress("close");
						if (salary) { 
							$("#salaryEditDiv").dialog("open");
							$("#salary_salaryId_edit").val(salary.salaryId);
							$("#salary_salaryId_edit").validatebox({
								required : true,
								missingMessage : "请输入工资id",
								editable: false
							});
							$("#salary_employeeObj_employeeNo_edit").combobox({
								url:"Employee/listAll",
							    valueField:"employeeNo",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#salary_employeeObj_employeeNo_edit").combobox("select", salary.employeeObjPri);
									//var data = $("#salary_employeeObj_employeeNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#salary_employeeObj_employeeNo_edit").combobox("select", data[0].employeeNo);
						            //}
								}
							});
							$("#salary_year_edit").val(salary.year);
							$("#salary_year_edit").validatebox({
								required : true,
								missingMessage : "请输入工资年份",
							});
							$("#salary_month_edit").val(salary.month);
							$("#salary_month_edit").validatebox({
								required : true,
								missingMessage : "请输入工资月份",
							});
							$("#salary_salaryMoney_edit").val(salary.salaryMoney);
							$("#salary_salaryMoney_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入工资金额",
								invalidMessage : "工资金额输入不对",
							});
							$("#salary_fafang_edit").val(salary.fafang);
							$("#salary_fafang_edit").validatebox({
								required : true,
								missingMessage : "请输入是否发放",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
