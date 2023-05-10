var leaveWord_manage_tool = null; 
$(function () { 
	initLeaveWordManageTool(); //建立LeaveWord管理对象
	leaveWord_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#leaveWord_manage").datagrid({
		url : 'LeaveWord/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "leaveWordId",
		sortOrder : "desc",
		toolbar : "#leaveWord_manage_tool",
		columns : [[
			{
				field : "leaveWordId",
				title : "记录id",
				width : 70,
			},
			{
				field : "title",
				title : "标题",
				width : 140,
			},
			{
				field : "content",
				title : "内容",
				width : 140,
			},
			{
				field : "addTime",
				title : "发布时间",
				width : 140,
			},
			{
				field : "ownerObj",
				title : "提交住户",
				width : 140,
			},
			{
				field : "replyContent",
				title : "回复内容",
				width : 140,
			},
			{
				field : "replyTime",
				title : "回复时间",
				width : 140,
			},
			{
				field : "opUser",
				title : "回复人",
				width : 140,
			},
		]],
	});

	$("#leaveWordEditDiv").dialog({
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
				if ($("#leaveWordEditForm").form("validate")) {
					//验证表单 
					if(!$("#leaveWordEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#leaveWordEditForm").form({
						    url:"LeaveWord/" + $("#leaveWord_leaveWordId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#leaveWordEditForm").form("validate"))  {
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
			                        $("#leaveWordEditDiv").dialog("close");
			                        leaveWord_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#leaveWordEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#leaveWordEditDiv").dialog("close");
				$("#leaveWordEditForm").form("reset"); 
			},
		}],
	});
});

function initLeaveWordManageTool() {
	leaveWord_manage_tool = {
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
			$("#leaveWord_manage").datagrid("reload");
		},
		redo : function () {
			$("#leaveWord_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#leaveWord_manage").datagrid("options").queryParams;
			queryParams["title"] = $("#title").val();
			queryParams["addTime"] = $("#addTime").val();
			queryParams["ownerObj.ownerId"] = $("#ownerObj_ownerId_query").combobox("getValue");
			queryParams["opUser"] = $("#opUser").val();
			$("#leaveWord_manage").datagrid("options").queryParams=queryParams; 
			$("#leaveWord_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#leaveWordQueryForm").form({
			    url:"LeaveWord/OutToExcel",
			});
			//提交表单
			$("#leaveWordQueryForm").submit();
		},
		remove : function () {
			var rows = $("#leaveWord_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var leaveWordIds = [];
						for (var i = 0; i < rows.length; i ++) {
							leaveWordIds.push(rows[i].leaveWordId);
						}
						$.ajax({
							type : "POST",
							url : "LeaveWord/deletes",
							data : {
								leaveWordIds : leaveWordIds.join(","),
							},
							beforeSend : function () {
								$("#leaveWord_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#leaveWord_manage").datagrid("loaded");
									$("#leaveWord_manage").datagrid("load");
									$("#leaveWord_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#leaveWord_manage").datagrid("loaded");
									$("#leaveWord_manage").datagrid("load");
									$("#leaveWord_manage").datagrid("unselectAll");
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
			var rows = $("#leaveWord_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "LeaveWord/" + rows[0].leaveWordId +  "/update",
					type : "get",
					data : {
						//leaveWordId : rows[0].leaveWordId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (leaveWord, response, status) {
						$.messager.progress("close");
						if (leaveWord) { 
							$("#leaveWordEditDiv").dialog("open");
							$("#leaveWord_leaveWordId_edit").val(leaveWord.leaveWordId);
							$("#leaveWord_leaveWordId_edit").validatebox({
								required : true,
								missingMessage : "请输入记录id",
								editable: false
							});
							$("#leaveWord_title_edit").val(leaveWord.title);
							$("#leaveWord_title_edit").validatebox({
								required : true,
								missingMessage : "请输入标题",
							});
							$("#leaveWord_content_edit").val(leaveWord.content);
							$("#leaveWord_content_edit").validatebox({
								required : true,
								missingMessage : "请输入内容",
							});
							$("#leaveWord_addTime_edit").val(leaveWord.addTime);
							$("#leaveWord_ownerObj_ownerId_edit").combobox({
								url:"Owner/listAll",
							    valueField:"ownerId",
							    textField:"ownerName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#leaveWord_ownerObj_ownerId_edit").combobox("select", leaveWord.ownerObjPri);
									//var data = $("#leaveWord_ownerObj_ownerId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#leaveWord_ownerObj_ownerId_edit").combobox("select", data[0].ownerId);
						            //}
								}
							});
							$("#leaveWord_replyContent_edit").val(leaveWord.replyContent);
							$("#leaveWord_replyTime_edit").val(leaveWord.replyTime);
							$("#leaveWord_opUser_edit").val(leaveWord.opUser);
							$("#leaveWord_opUser_edit").validatebox({
								required : true,
								missingMessage : "请输入回复人",
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
