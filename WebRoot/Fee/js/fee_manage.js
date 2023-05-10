var fee_manage_tool = null; 
$(function () { 
	initFeeManageTool(); //建立Fee管理对象
	fee_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#fee_manage").datagrid({
		url : 'Fee/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "feeId",
		sortOrder : "desc",
		toolbar : "#fee_manage_tool",
		columns : [[
			{
				field : "feeId",
				title : "费用id",
				width : 70,
			},
			{
				field : "feeTypeObj",
				title : "费用类别",
				width : 140,
			},
			{
				field : "ownerObj",
				title : "住户信息",
				width : 140,
			},
			{
				field : "feeDate",
				title : "收费时间",
				width : 140,
			},
			{
				field : "feeMoney",
				title : "收费金额",
				width : 70,
			},
			{
				field : "feeContent",
				title : "收费内容",
				width : 140,
			},
			{
				field : "opUser",
				title : "操作员",
				width : 140,
			},
		]],
	});

	$("#feeEditDiv").dialog({
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
				if ($("#feeEditForm").form("validate")) {
					//验证表单 
					if(!$("#feeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#feeEditForm").form({
						    url:"Fee/" + $("#fee_feeId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#feeEditForm").form("validate"))  {
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
			                        $("#feeEditDiv").dialog("close");
			                        fee_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#feeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#feeEditDiv").dialog("close");
				$("#feeEditForm").form("reset"); 
			},
		}],
	});
});

function initFeeManageTool() {
	fee_manage_tool = {
		init: function() {
			$.ajax({
				url : "FeeType/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#feeTypeObj_typeId_query").combobox({ 
					    valueField:"typeId",
					    textField:"typeName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{typeId:0,typeName:"不限制"});
					$("#feeTypeObj_typeId_query").combobox("loadData",data); 
				}
			});
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
			$("#fee_manage").datagrid("reload");
		},
		redo : function () {
			$("#fee_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#fee_manage").datagrid("options").queryParams;
			queryParams["feeTypeObj.typeId"] = $("#feeTypeObj_typeId_query").combobox("getValue");
			queryParams["ownerObj.ownerId"] = $("#ownerObj_ownerId_query").combobox("getValue");
			queryParams["feeDate"] = $("#feeDate").datebox("getValue"); 
			queryParams["feeContent"] = $("#feeContent").val();
			queryParams["opUser"] = $("#opUser").val();
			$("#fee_manage").datagrid("options").queryParams=queryParams; 
			$("#fee_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#feeQueryForm").form({
			    url:"Fee/OutToExcel",
			});
			//提交表单
			$("#feeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#fee_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var feeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							feeIds.push(rows[i].feeId);
						}
						$.ajax({
							type : "POST",
							url : "Fee/deletes",
							data : {
								feeIds : feeIds.join(","),
							},
							beforeSend : function () {
								$("#fee_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#fee_manage").datagrid("loaded");
									$("#fee_manage").datagrid("load");
									$("#fee_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#fee_manage").datagrid("loaded");
									$("#fee_manage").datagrid("load");
									$("#fee_manage").datagrid("unselectAll");
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
			var rows = $("#fee_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Fee/" + rows[0].feeId +  "/update",
					type : "get",
					data : {
						//feeId : rows[0].feeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (fee, response, status) {
						$.messager.progress("close");
						if (fee) { 
							$("#feeEditDiv").dialog("open");
							$("#fee_feeId_edit").val(fee.feeId);
							$("#fee_feeId_edit").validatebox({
								required : true,
								missingMessage : "请输入费用id",
								editable: false
							});
							$("#fee_feeTypeObj_typeId_edit").combobox({
								url:"FeeType/listAll",
							    valueField:"typeId",
							    textField:"typeName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#fee_feeTypeObj_typeId_edit").combobox("select", fee.feeTypeObjPri);
									//var data = $("#fee_feeTypeObj_typeId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#fee_feeTypeObj_typeId_edit").combobox("select", data[0].typeId);
						            //}
								}
							});
							$("#fee_ownerObj_ownerId_edit").combobox({
								url:"Owner/listAll",
							    valueField:"ownerId",
							    textField:"ownerName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#fee_ownerObj_ownerId_edit").combobox("select", fee.ownerObjPri);
									//var data = $("#fee_ownerObj_ownerId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#fee_ownerObj_ownerId_edit").combobox("select", data[0].ownerId);
						            //}
								}
							});
							$("#fee_feeDate_edit").datebox({
								value: fee.feeDate,
							    required: true,
							    showSeconds: true,
							});
							$("#fee_feeMoney_edit").val(fee.feeMoney);
							$("#fee_feeMoney_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入收费金额",
								invalidMessage : "收费金额输入不对",
							});
							$("#fee_feeContent_edit").val(fee.feeContent);
							$("#fee_feeContent_edit").validatebox({
								required : true,
								missingMessage : "请输入收费内容",
							});
							$("#fee_opUser_edit").val(fee.opUser);
							$("#fee_opUser_edit").validatebox({
								required : true,
								missingMessage : "请输入操作员",
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
