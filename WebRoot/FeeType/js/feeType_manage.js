var feeType_manage_tool = null; 
$(function () { 
	initFeeTypeManageTool(); //建立FeeType管理对象
	feeType_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#feeType_manage").datagrid({
		url : 'FeeType/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "typeId",
		sortOrder : "desc",
		toolbar : "#feeType_manage_tool",
		columns : [[
			{
				field : "typeId",
				title : "类别id",
				width : 70,
			},
			{
				field : "typeName",
				title : "类别名称",
				width : 140,
			},
		]],
	});

	$("#feeTypeEditDiv").dialog({
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
				if ($("#feeTypeEditForm").form("validate")) {
					//验证表单 
					if(!$("#feeTypeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#feeTypeEditForm").form({
						    url:"FeeType/" + $("#feeType_typeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#feeTypeEditForm").form("validate"))  {
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
			                        $("#feeTypeEditDiv").dialog("close");
			                        feeType_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#feeTypeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#feeTypeEditDiv").dialog("close");
				$("#feeTypeEditForm").form("reset"); 
			},
		}],
	});
});

function initFeeTypeManageTool() {
	feeType_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#feeType_manage").datagrid("reload");
		},
		redo : function () {
			$("#feeType_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#feeType_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#feeTypeQueryForm").form({
			    url:"FeeType/OutToExcel",
			});
			//提交表单
			$("#feeTypeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#feeType_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var typeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							typeIds.push(rows[i].typeId);
						}
						$.ajax({
							type : "POST",
							url : "FeeType/deletes",
							data : {
								typeIds : typeIds.join(","),
							},
							beforeSend : function () {
								$("#feeType_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#feeType_manage").datagrid("loaded");
									$("#feeType_manage").datagrid("load");
									$("#feeType_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#feeType_manage").datagrid("loaded");
									$("#feeType_manage").datagrid("load");
									$("#feeType_manage").datagrid("unselectAll");
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
			var rows = $("#feeType_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "FeeType/" + rows[0].typeId +  "/update",
					type : "get",
					data : {
						//typeId : rows[0].typeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (feeType, response, status) {
						$.messager.progress("close");
						if (feeType) { 
							$("#feeTypeEditDiv").dialog("open");
							$("#feeType_typeId_edit").val(feeType.typeId);
							$("#feeType_typeId_edit").validatebox({
								required : true,
								missingMessage : "请输入类别id",
								editable: false
							});
							$("#feeType_typeName_edit").val(feeType.typeName);
							$("#feeType_typeName_edit").validatebox({
								required : true,
								missingMessage : "请输入类别名称",
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
