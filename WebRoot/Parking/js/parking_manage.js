var parking_manage_tool = null; 
$(function () { 
	initParkingManageTool(); //建立Parking管理对象
	parking_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#parking_manage").datagrid({
		url : 'Parking/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "parkingId",
		sortOrder : "desc",
		toolbar : "#parking_manage_tool",
		columns : [[
			{
				field : "parkingId",
				title : "车位id",
				width : 70,
			},
			{
				field : "parkingName",
				title : "车位名称",
				width : 140,
			},
			{
				field : "plateNumber",
				title : "车牌号",
				width : 140,
			},
			{
				field : "ownerObj",
				title : "车主",
				width : 140,
			},
			{
				field : "opUser",
				title : "操作员",
				width : 140,
			},
		]],
	});

	$("#parkingEditDiv").dialog({
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
				if ($("#parkingEditForm").form("validate")) {
					//验证表单 
					if(!$("#parkingEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#parkingEditForm").form({
						    url:"Parking/" + $("#parking_parkingId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#parkingEditForm").form("validate"))  {
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
			                        $("#parkingEditDiv").dialog("close");
			                        parking_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#parkingEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#parkingEditDiv").dialog("close");
				$("#parkingEditForm").form("reset"); 
			},
		}],
	});
});

function initParkingManageTool() {
	parking_manage_tool = {
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
			$("#parking_manage").datagrid("reload");
		},
		redo : function () {
			$("#parking_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#parking_manage").datagrid("options").queryParams;
			queryParams["parkingName"] = $("#parkingName").val();
			queryParams["plateNumber"] = $("#plateNumber").val();
			queryParams["ownerObj.ownerId"] = $("#ownerObj_ownerId_query").combobox("getValue");
			queryParams["opUser"] = $("#opUser").val();
			$("#parking_manage").datagrid("options").queryParams=queryParams; 
			$("#parking_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#parkingQueryForm").form({
			    url:"Parking/OutToExcel",
			});
			//提交表单
			$("#parkingQueryForm").submit();
		},
		remove : function () {
			var rows = $("#parking_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var parkingIds = [];
						for (var i = 0; i < rows.length; i ++) {
							parkingIds.push(rows[i].parkingId);
						}
						$.ajax({
							type : "POST",
							url : "Parking/deletes",
							data : {
								parkingIds : parkingIds.join(","),
							},
							beforeSend : function () {
								$("#parking_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#parking_manage").datagrid("loaded");
									$("#parking_manage").datagrid("load");
									$("#parking_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#parking_manage").datagrid("loaded");
									$("#parking_manage").datagrid("load");
									$("#parking_manage").datagrid("unselectAll");
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
			var rows = $("#parking_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Parking/" + rows[0].parkingId +  "/update",
					type : "get",
					data : {
						//parkingId : rows[0].parkingId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (parking, response, status) {
						$.messager.progress("close");
						if (parking) { 
							$("#parkingEditDiv").dialog("open");
							$("#parking_parkingId_edit").val(parking.parkingId);
							$("#parking_parkingId_edit").validatebox({
								required : true,
								missingMessage : "请输入车位id",
								editable: false
							});
							$("#parking_parkingName_edit").val(parking.parkingName);
							$("#parking_parkingName_edit").validatebox({
								required : true,
								missingMessage : "请输入车位名称",
							});
							$("#parking_plateNumber_edit").val(parking.plateNumber);
							$("#parking_plateNumber_edit").validatebox({
								required : true,
								missingMessage : "请输入车牌号",
							});
							$("#parking_ownerObj_ownerId_edit").combobox({
								url:"Owner/listAll",
							    valueField:"ownerId",
							    textField:"ownerName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#parking_ownerObj_ownerId_edit").combobox("select", parking.ownerObjPri);
									//var data = $("#parking_ownerObj_ownerId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#parking_ownerObj_ownerId_edit").combobox("select", data[0].ownerId);
						            //}
								}
							});
							$("#parking_opUser_edit").val(parking.opUser);
							$("#parking_opUser_edit").validatebox({
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
