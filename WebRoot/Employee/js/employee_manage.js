var employee_manage_tool = null; 
$(function () { 
	initEmployeeManageTool(); //建立Employee管理对象
	employee_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#employee_manage").datagrid({
		url : 'Employee/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "employeeNo",
		sortOrder : "desc",
		toolbar : "#employee_manage_tool",
		columns : [[
			{
				field : "employeeNo",
				title : "员工编号",
				width : 140,
			},
			{
				field : "name",
				title : "姓名",
				width : 140,
			},
			{
				field : "sex",
				title : "性别",
				width : 140,
			},
			{
				field : "positionName",
				title : "职位",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
		]],
	});

	$("#employeeEditDiv").dialog({
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
				if ($("#employeeEditForm").form("validate")) {
					//验证表单 
					if(!$("#employeeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#employeeEditForm").form({
						    url:"Employee/" + $("#employee_employeeNo_edit").val() + "/update",
						    onSubmit: function(){
								if($("#employeeEditForm").form("validate"))  {
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
			                        $("#employeeEditDiv").dialog("close");
			                        employee_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#employeeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#employeeEditDiv").dialog("close");
				$("#employeeEditForm").form("reset"); 
			},
		}],
	});
});

function initEmployeeManageTool() {
	employee_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#employee_manage").datagrid("reload");
		},
		redo : function () {
			$("#employee_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#employee_manage").datagrid("options").queryParams;
			queryParams["employeeNo"] = $("#employeeNo").val();
			queryParams["name"] = $("#name").val();
			queryParams["positionName"] = $("#positionName").val();
			queryParams["telephone"] = $("#telephone").val();
			$("#employee_manage").datagrid("options").queryParams=queryParams; 
			$("#employee_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#employeeQueryForm").form({
			    url:"Employee/OutToExcel",
			});
			//提交表单
			$("#employeeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#employee_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var employeeNos = [];
						for (var i = 0; i < rows.length; i ++) {
							employeeNos.push(rows[i].employeeNo);
						}
						$.ajax({
							type : "POST",
							url : "Employee/deletes",
							data : {
								employeeNos : employeeNos.join(","),
							},
							beforeSend : function () {
								$("#employee_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#employee_manage").datagrid("loaded");
									$("#employee_manage").datagrid("load");
									$("#employee_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#employee_manage").datagrid("loaded");
									$("#employee_manage").datagrid("load");
									$("#employee_manage").datagrid("unselectAll");
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
			var rows = $("#employee_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Employee/" + rows[0].employeeNo +  "/update",
					type : "get",
					data : {
						//employeeNo : rows[0].employeeNo,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (employee, response, status) {
						$.messager.progress("close");
						if (employee) { 
							$("#employeeEditDiv").dialog("open");
							$("#employee_employeeNo_edit").val(employee.employeeNo);
							$("#employee_employeeNo_edit").validatebox({
								required : true,
								missingMessage : "请输入员工编号",
								editable: false
							});
							$("#employee_name_edit").val(employee.name);
							$("#employee_name_edit").validatebox({
								required : true,
								missingMessage : "请输入姓名",
							});
							$("#employee_sex_edit").val(employee.sex);
							$("#employee_sex_edit").validatebox({
								required : true,
								missingMessage : "请输入性别",
							});
							$("#employee_positionName_edit").val(employee.positionName);
							$("#employee_positionName_edit").validatebox({
								required : true,
								missingMessage : "请输入职位",
							});
							$("#employee_telephone_edit").val(employee.telephone);
							$("#employee_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							$("#employee_address_edit").val(employee.address);
							$("#employee_address_edit").validatebox({
								required : true,
								missingMessage : "请输入地址",
							});
							$("#employee_employeeDesc_edit").val(employee.employeeDesc);
							$("#employee_employeeDesc_edit").validatebox({
								required : true,
								missingMessage : "请输入员工介绍",
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
