$(function () {
	$.ajax({
		url : "FeeType/" + $("#feeType_typeId_edit").val() + "/update",
		type : "get",
		data : {
			//typeId : $("#feeType_typeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (feeType, response, status) {
			$.messager.progress("close");
			if (feeType) { 
				$("#feeType_typeId_edit").val(feeType.typeId);
				$("#feeType_typeId_edit").validatebox({
					required : true,
					missingMessage : "请输入类别id",
					editable: false
				});
				$("#feeType_typeName_edit").val(feeType.typeName);
				$("#feeType_typeName_edit").validatebox({
					required : true,
					missingMessage : "请输入类别名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#feeTypeModifyButton").click(function(){ 
		if ($("#feeTypeEditForm").form("validate")) {
			$("#feeTypeEditForm").form({
			    url:"FeeType/" +  $("#feeType_typeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#feeTypeEditForm").form("validate"))  {
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
			$("#feeTypeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
