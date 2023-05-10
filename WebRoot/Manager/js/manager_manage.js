var manager_manage_tool = null; 
$(function () { 
	initManagerManageTool(); //建立Manager管理对象
	manager_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#manager_manage").datagrid({
		url : 'Manager/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "manageUserName",
		sortOrder : "desc",
		toolbar : "#manager_manage_tool",
		columns : [[
			{
				field : "manageUserName",
				title : "用户名",
				width : 140,
			},
			{
				field : "manageType",
				title : "管理员类别",
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
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
		]],
	});

	$("#managerEditDiv").dialog({
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
				if ($("#managerEditForm").form("validate")) {
					//验证表单 
					if(!$("#managerEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#managerEditForm").form({
						    url:"Manager/" + $("#manager_manageUserName_edit").val() + "/update",
						    onSubmit: function(){
								if($("#managerEditForm").form("validate"))  {
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
			                        $("#managerEditDiv").dialog("close");
			                        manager_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#managerEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#managerEditDiv").dialog("close");
				$("#managerEditForm").form("reset"); 
			},
		}],
	});
});

function initManagerManageTool() {
	manager_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#manager_manage").datagrid("reload");
		},
		redo : function () {
			$("#manager_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#manager_manage").datagrid("options").queryParams;
			queryParams["manageUserName"] = $("#manageUserName").val();
			queryParams["manageType"] = $("#manageType").val();
			queryParams["name"] = $("#name").val();
			queryParams["telephone"] = $("#telephone").val();
			$("#manager_manage").datagrid("options").queryParams=queryParams; 
			$("#manager_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#managerQueryForm").form({
			    url:"Manager/OutToExcel",
			});
			//提交表单
			$("#managerQueryForm").submit();
		},
		remove : function () {
			var rows = $("#manager_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var manageUserNames = [];
						for (var i = 0; i < rows.length; i ++) {
							manageUserNames.push(rows[i].manageUserName);
						}
						$.ajax({
							type : "POST",
							url : "Manager/deletes",
							data : {
								manageUserNames : manageUserNames.join(","),
							},
							beforeSend : function () {
								$("#manager_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#manager_manage").datagrid("loaded");
									$("#manager_manage").datagrid("load");
									$("#manager_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#manager_manage").datagrid("loaded");
									$("#manager_manage").datagrid("load");
									$("#manager_manage").datagrid("unselectAll");
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
			var rows = $("#manager_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Manager/" + rows[0].manageUserName +  "/update",
					type : "get",
					data : {
						//manageUserName : rows[0].manageUserName,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (manager, response, status) {
						$.messager.progress("close");
						if (manager) { 
							$("#managerEditDiv").dialog("open");
							$("#manager_manageUserName_edit").val(manager.manageUserName);
							$("#manager_manageUserName_edit").validatebox({
								required : true,
								missingMessage : "请输入用户名",
								editable: false
							});
							$("#manager_password_edit").val(manager.password);
							$("#manager_password_edit").validatebox({
								required : true,
								missingMessage : "请输入登录密码",
							});
							$("#manager_manageType_edit").val(manager.manageType);
							$("#manager_manageType_edit").validatebox({
								required : true,
								missingMessage : "请输入管理员类别",
							});
							$("#manager_name_edit").val(manager.name);
							$("#manager_name_edit").validatebox({
								required : true,
								missingMessage : "请输入姓名",
							});
							$("#manager_sex_edit").val(manager.sex);
							$("#manager_sex_edit").validatebox({
								required : true,
								missingMessage : "请输入性别",
							});
							$("#manager_telephone_edit").val(manager.telephone);
							$("#manager_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
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
