$(function () {
	$.ajax({
		url : "Building/" + $("#building_buildingId_edit").val() + "/update",
		type : "get",
		data : {
			//buildingId : $("#building_buildingId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (building, response, status) {
			$.messager.progress("close");
			if (building) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#buildingModifyButton").click(function(){ 
		if ($("#buildingEditForm").form("validate")) {
			$("#buildingEditForm").form({
			    url:"Building/" +  $("#building_buildingId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#buildingEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
