$(function () {
	$.ajax({
		url : "Repair/" + $("#repair_repairId_edit").val() + "/update",
		type : "get",
		data : {
			//repairId : $("#repair_repairId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (repair, response, status) {
			$.messager.progress("close");
			if (repair) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#repairModifyButton").click(function(){ 
		if ($("#repairEditForm").form("validate")) {
			$("#repairEditForm").form({
			    url:"Repair/" +  $("#repair_repairId_edit").val() + "/update",
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
			$("#repairEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
