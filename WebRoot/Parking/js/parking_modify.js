$(function () {
	$.ajax({
		url : "Parking/" + $("#parking_parkingId_edit").val() + "/update",
		type : "get",
		data : {
			//parkingId : $("#parking_parkingId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (parking, response, status) {
			$.messager.progress("close");
			if (parking) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#parkingModifyButton").click(function(){ 
		if ($("#parkingEditForm").form("validate")) {
			$("#parkingEditForm").form({
			    url:"Parking/" +  $("#parking_parkingId_edit").val() + "/update",
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
			$("#parkingEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
