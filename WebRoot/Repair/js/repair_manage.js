var repair_manage_tool = null; 
$(function () { 
	initRepairManageTool(); //建立Repair管理对象
	repair_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#repair_manage").datagrid({
		url : 'Repair/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "repairId",
		sortOrder : "desc",
		toolbar : "#repair_manage_tool",
		columns : [[
			{
				field : "repairId",
				title : "报修id",
				width : 70,
			},
			{
				field : "ownerObj",
				title : "报修用户",
				width : 140,
			},
			{
				field : "repairDate",
				title : "报修日期",
				width : 140,
			},
			{
				field : "questionDesc",
				title : "问题描述",
				width : 140,
			},
			{
				field : "repairState",
				title : "报修状态",
				width : 140,
			},
			{
				field : "handleResult",
				title : "处理结果",
				width : 140,
			},
		]],
	});

	$("#repairEditDiv").dialog({
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
				if ($("#repairEditForm").form("validate")) {
					//验证表单 
					if(!$("#repairEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#repairEditForm").form({
						    url:"Repair/" + $("#repair_repairId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#repairEditForm").form("validate"))  {
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
			                        $("#repairEditDiv").dialog("close");
			                        repair_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#repairEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#repairEditDiv").dialog("close");
				$("#repairEditForm").form("reset"); 
			},
		}],
	});
});

function initRepairManageTool() {
	repair_manage_tool = {
		init: function() {
			$.ajax({
				url : "Owner/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#ownerObj_ownerId_query").combobox({ 
					    valueField:"ownerId",
					    textField:"ownerName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{ownerId:0,ownerName:"不限制"});
					$("#ownerObj_ownerId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#repair_manage").datagrid("reload");
		},
		redo : function () {
			$("#repair_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#repair_manage").datagrid("options").queryParams;
			queryParams["ownerObj.ownerId"] = $("#ownerObj_ownerId_query").combobox("getValue");
			queryParams["repairDate"] = $("#repairDate").datebox("getValue"); 
			queryParams["questionDesc"] = $("#questionDesc").val();
			queryParams["repairState"] = $("#repairState").val();
			$("#repair_manage").datagrid("options").queryParams=queryParams; 
			$("#repair_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#repairQueryForm").form({
			    url:"Repair/OutToExcel",
			});
			//提交表单
			$("#repairQueryForm").submit();
		},
		remove : function () {
			var rows = $("#repair_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var repairIds = [];
						for (var i = 0; i < rows.length; i ++) {
							repairIds.push(rows[i].repairId);
						}
						$.ajax({
							type : "POST",
							url : "Repair/deletes",
							data : {
								repairIds : repairIds.join(","),
							},
							beforeSend : function () {
								$("#repair_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#repair_manage").datagrid("loaded");
									$("#repair_manage").datagrid("load");
									$("#repair_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#repair_manage").datagrid("loaded");
									$("#repair_manage").datagrid("load");
									$("#repair_manage").datagrid("unselectAll");
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
			var rows = $("#repair_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Repair/" + rows[0].repairId +  "/update",
					type : "get",
					data : {
						//repairId : rows[0].repairId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (repair, response, status) {
						$.messager.progress("close");
						if (repair) { 
							$("#repairEditDiv").dialog("open");
							$("#repair_repairId_edit").val(repair.repairId);
							$("#repair_repairId_edit").validatebox({
								required : true,
								missingMessage : "请输入报修id",
								editable: false
							});
							$("#repair_ownerObj_ownerId_edit").combobox({
								url:"Owner/listAll",
							    valueField:"ownerId",
							    textField:"ownerName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#repair_ownerObj_ownerId_edit").combobox("select", repair.ownerObjPri);
									//var data = $("#repair_ownerObj_ownerId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#repair_ownerObj_ownerId_edit").combobox("select", data[0].ownerId);
						            //}
								}
							});
							$("#repair_repairDate_edit").datebox({
								value: repair.repairDate,
							    required: true,
							    showSeconds: true,
							});
							$("#repair_questionDesc_edit").val(repair.questionDesc);
							$("#repair_questionDesc_edit").validatebox({
								required : true,
								missingMessage : "请输入问题描述",
							});
							$("#repair_repairState_edit").val(repair.repairState);
							$("#repair_repairState_edit").validatebox({
								required : true,
								missingMessage : "请输入报修状态",
							});
							$("#repair_handleResult_edit").val(repair.handleResult);
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
