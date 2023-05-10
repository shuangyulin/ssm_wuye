$(function () {
	$.ajax({
		url : "Facility/" + $("#facility_facilityId_edit").val() + "/update",
		type : "get",
		data : {
			//facilityId : $("#facility_facilityId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (facility, response, status) {
			$.messager.progress("close");
			if (facility) { 
				$("#facility_facilityId_edit").val(facility.facilityId);
				$("#facility_facilityId_edit").validatebox({
					required : true,
					missingMessage : "请输入设施id",
					editable: false
				});
				$("#facility_name_edit").val(facility.name);
				$("#facility_name_edit").validatebox({
					required : true,
					missingMessage : "请输入设施名称",
				});
				$("#facility_count_edit").val(facility.count);
				$("#facility_count_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入数量",
					invalidMessage : "数量输入不对",
				});
				$("#facility_startTime_edit").datebox({
					value: facility.startTime,
					required: true,
					showSeconds: true,
				});
				$("#facility_facilityState_edit").val(facility.facilityState);
				$("#facility_facilityState_edit").validatebox({
					required : true,
					missingMessage : "请输入设施状态",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#facilityModifyButton").click(function(){ 
		if ($("#facilityEditForm").form("validate")) {
			$("#facilityEditForm").form({
			    url:"Facility/" +  $("#facility_facilityId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#facilityEditForm").form("validate"))  {
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
			$("#facilityEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
