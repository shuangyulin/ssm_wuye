var owner_manage_tool = null; 
$(function () { 
	initOwnerManageTool(); //建立Owner管理对象
	owner_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#owner_manage").datagrid({
		url : 'Owner/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "ownerId",
		sortOrder : "desc",
		toolbar : "#owner_manage_tool",
		columns : [[
			{
				field : "ownerId",
				title : "业主id",
				width : 70,
			},
			{
				field : "buildingObj",
				title : "楼栋名称",
				width : 140,
			},
			{
				field : "roomNo",
				title : "房间号",
				width : 140,
			},
			{
				field : "ownerName",
				title : "户主",
				width : 140,
			},
			{
				field : "area",
				title : "房屋面积",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系方式",
				width : 140,
			},
		]],
	});

	$("#ownerEditDiv").dialog({
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
				if ($("#ownerEditForm").form("validate")) {
					//验证表单 
					if(!$("#ownerEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#ownerEditForm").form({
						    url:"Owner/" + $("#owner_ownerId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#ownerEditForm").form("validate"))  {
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
			                        $("#ownerEditDiv").dialog("close");
			                        owner_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#ownerEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#ownerEditDiv").dialog("close");
				$("#ownerEditForm").form("reset"); 
			},
		}],
	});
});

function initOwnerManageTool() {
	owner_manage_tool = {
		init: function() {
			$.ajax({
				url : "Building/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#buildingObj_buildingId_query").combobox({ 
					    valueField:"buildingId",
					    textField:"buildingName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{buildingId:0,buildingName:"不限制"});
					$("#buildingObj_buildingId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#owner_manage").datagrid("reload");
		},
		redo : function () {
			$("#owner_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#owner_manage").datagrid("options").queryParams;
			queryParams["buildingObj.buildingId"] = $("#buildingObj_buildingId_query").combobox("getValue");
			queryParams["roomNo"] = $("#roomNo").val();
			queryParams["ownerName"] = $("#ownerName").val();
			queryParams["telephone"] = $("#telephone").val();
			$("#owner_manage").datagrid("options").queryParams=queryParams; 
			$("#owner_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#ownerQueryForm").form({
			    url:"Owner/OutToExcel",
			});
			//提交表单
			$("#ownerQueryForm").submit();
		},
		remove : function () {
			var rows = $("#owner_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var ownerIds = [];
						for (var i = 0; i < rows.length; i ++) {
							ownerIds.push(rows[i].ownerId);
						}
						$.ajax({
							type : "POST",
							url : "Owner/deletes",
							data : {
								ownerIds : ownerIds.join(","),
							},
							beforeSend : function () {
								$("#owner_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#owner_manage").datagrid("loaded");
									$("#owner_manage").datagrid("load");
									$("#owner_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#owner_manage").datagrid("loaded");
									$("#owner_manage").datagrid("load");
									$("#owner_manage").datagrid("unselectAll");
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
			var rows = $("#owner_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Owner/" + rows[0].ownerId +  "/update",
					type : "get",
					data : {
						//ownerId : rows[0].ownerId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (owner, response, status) {
						$.messager.progress("close");
						if (owner) { 
							$("#ownerEditDiv").dialog("open");
							$("#owner_ownerId_edit").val(owner.ownerId);
							$("#owner_ownerId_edit").validatebox({
								required : true,
								missingMessage : "请输入业主id",
								editable: false
							});
							$("#owner_password_edit").val(owner.password);
							$("#owner_password_edit").validatebox({
								required : true,
								missingMessage : "请输入登录密码",
							});
							$("#owner_buildingObj_buildingId_edit").combobox({
								url:"Building/listAll",
							    valueField:"buildingId",
							    textField:"buildingName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#owner_buildingObj_buildingId_edit").combobox("select", owner.buildingObjPri);
									//var data = $("#owner_buildingObj_buildingId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#owner_buildingObj_buildingId_edit").combobox("select", data[0].buildingId);
						            //}
								}
							});
							$("#owner_roomNo_edit").val(owner.roomNo);
							$("#owner_roomNo_edit").validatebox({
								required : true,
								missingMessage : "请输入房间号",
							});
							$("#owner_ownerName_edit").val(owner.ownerName);
							$("#owner_ownerName_edit").validatebox({
								required : true,
								missingMessage : "请输入户主",
							});
							$("#owner_area_edit").val(owner.area);
							$("#owner_area_edit").validatebox({
								required : true,
								missingMessage : "请输入房屋面积",
							});
							$("#owner_telephone_edit").val(owner.telephone);
							$("#owner_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系方式",
							});
							$("#owner_memo_edit").val(owner.memo);
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
