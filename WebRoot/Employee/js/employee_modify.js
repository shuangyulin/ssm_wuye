$(function () {
	$.ajax({
		url : "Employee/" + $("#employee_employeeNo_edit").val() + "/update",
		type : "get",
		data : {
			//employeeNo : $("#employee_employeeNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (employee, response, status) {
			$.messager.progress("close");
			if (employee) { 
				$("#employee_employeeNo_edit").val(employee.employeeNo);
				$("#employee_employeeNo_edit").validatebox({
					required : true,
					missingMessage : "请输入员工编号",
					editable: false
				});
				$("#employee_name_edit").val(employee.name);
				$("#employee_name_edit").validatebox({
					required : true,
					missingMessage : "请输入姓名",
				});
				$("#employee_sex_edit").val(employee.sex);
				$("#employee_sex_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#employee_positionName_edit").val(employee.positionName);
				$("#employee_positionName_edit").validatebox({
					required : true,
					missingMessage : "请输入职位",
				});
				$("#employee_telephone_edit").val(employee.telephone);
				$("#employee_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#employee_address_edit").val(employee.address);
				$("#employee_address_edit").validatebox({
					required : true,
					missingMessage : "请输入地址",
				});
				$("#employee_employeeDesc_edit").val(employee.employeeDesc);
				$("#employee_employeeDesc_edit").validatebox({
					required : true,
					missingMessage : "请输入员工介绍",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#employeeModifyButton").click(function(){ 
		if ($("#employeeEditForm").form("validate")) {
			$("#employeeEditForm").form({
			    url:"Employee/" +  $("#employee_employeeNo_edit").val() + "/update",
			    onSubmit: function(){
					if($("#employeeEditForm").form("validate"))  {
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
			$("#employeeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
