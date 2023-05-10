$(function () {
	$.ajax({
		url : "Salary/" + $("#salary_salaryId_edit").val() + "/update",
		type : "get",
		data : {
			//salaryId : $("#salary_salaryId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (salary, response, status) {
			$.messager.progress("close");
			if (salary) { 
				$("#salary_salaryId_edit").val(salary.salaryId);
				$("#salary_salaryId_edit").validatebox({
					required : true,
					missingMessage : "请输入工资id",
					editable: false
				});
				$("#salary_employeeObj_employeeNo_edit").combobox({
					url:"Employee/listAll",
					valueField:"employeeNo",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#salary_employeeObj_employeeNo_edit").combobox("select", salary.employeeObjPri);
						//var data = $("#salary_employeeObj_employeeNo_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#salary_employeeObj_employeeNo_edit").combobox("select", data[0].employeeNo);
						//}
					}
				});
				$("#salary_year_edit").val(salary.year);
				$("#salary_year_edit").validatebox({
					required : true,
					missingMessage : "请输入工资年份",
				});
				$("#salary_month_edit").val(salary.month);
				$("#salary_month_edit").validatebox({
					required : true,
					missingMessage : "请输入工资月份",
				});
				$("#salary_salaryMoney_edit").val(salary.salaryMoney);
				$("#salary_salaryMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入工资金额",
					invalidMessage : "工资金额输入不对",
				});
				$("#salary_fafang_edit").val(salary.fafang);
				$("#salary_fafang_edit").validatebox({
					required : true,
					missingMessage : "请输入是否发放",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#salaryModifyButton").click(function(){ 
		if ($("#salaryEditForm").form("validate")) {
			$("#salaryEditForm").form({
			    url:"Salary/" +  $("#salary_salaryId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#salaryEditForm").form("validate"))  {
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
			$("#salaryEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
