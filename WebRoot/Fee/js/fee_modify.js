$(function () {
	$.ajax({
		url : "Fee/" + $("#fee_feeId_edit").val() + "/update",
		type : "get",
		data : {
			//feeId : $("#fee_feeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (fee, response, status) {
			$.messager.progress("close");
			if (fee) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#feeModifyButton").click(function(){ 
		if ($("#feeEditForm").form("validate")) {
			$("#feeEditForm").form({
			    url:"Fee/" +  $("#fee_feeId_edit").val() + "/update",
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
			$("#feeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
