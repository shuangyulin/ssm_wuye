var building_manage_tool = null; 
$(function () { 
	initBuildingManageTool(); //建立Building管理对象
	building_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#building_manage").datagrid({
		url : 'Building/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "buildingId",
		sortOrder : "desc",
		toolbar : "#building_manage_tool",
		columns : [[
			{
				field : "buildingId",
				title : "楼栋id",
				width : 70,
			},
			{
				field : "buildingName",
				title : "楼栋名称",
				width : 140,
			},
			{
				field : "memo",
				title : "楼栋备注",
				width : 140,
			},
		]],
	});

	$("#buildingEditDiv").dialog({
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
				if ($("#buildingEditForm").form("validate")) {
					//验证表单 
					if(!$("#buildingEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#buildingEditForm").form({
						    url:"Building/" + $("#building_buildingId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#buildingEditForm").form("validate"))  {
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
			                        $("#buildingEditDiv").dialog("close");
			                        building_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#buildingEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#buildingEditDiv").dialog("close");
				$("#buildingEditForm").form("reset"); 
			},
		}],
	});
});

function initBuildingManageTool() {
	building_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#building_manage").datagrid("reload");
		},
		redo : function () {
			$("#building_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#building_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#buildingQueryForm").form({
			    url:"Building/OutToExcel",
			});
			//提交表单
			$("#buildingQueryForm").submit();
		},
		remove : function () {
			var rows = $("#building_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var buildingIds = [];
						for (var i = 0; i < rows.length; i ++) {
							buildingIds.push(rows[i].buildingId);
						}
						$.ajax({
							type : "POST",
							url : "Building/deletes",
							data : {
								buildingIds : buildingIds.join(","),
							},
							beforeSend : function () {
								$("#building_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#building_manage").datagrid("loaded");
									$("#building_manage").datagrid("load");
									$("#building_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#building_manage").datagrid("loaded");
									$("#building_manage").datagrid("load");
									$("#building_manage").datagrid("unselectAll");
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
			var rows = $("#building_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Building/" + rows[0].buildingId +  "/update",
					type : "get",
					data : {
						//buildingId : rows[0].buildingId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (building, response, status) {
						$.messager.progress("close");
						if (building) { 
							$("#buildingEditDiv").dialog("open");
							$("#building_buildingId_edit").val(building.buildingId);
							$("#building_buildingId_edit").validatebox({
								required : true,
								missingMessage : "请输入楼栋id",
								editable: false
							});
							$("#building_buildingName_edit").val(building.buildingName);
							$("#building_buildingName_edit").validatebox({
								required : true,
								missingMessage : "请输入楼栋名称",
							});
							$("#building_memo_edit").val(building.memo);
							$("#building_memo_edit").validatebox({
								required : true,
								missingMessage : "请输入楼栋备注",
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
