$(function () {
	$("#employee_employeeNo").validatebox({
		required : true, 
		missingMessage : '请输入员工编号',
	});

	$("#employee_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#employee_sex").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#employee_positionName").validatebox({
		required : true, 
		missingMessage : '请输入职位',
	});

	$("#employee_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#employee_address").validatebox({
		required : true, 
		missingMessage : '请输入地址',
	});

	$("#employee_employeeDesc").validatebox({
		required : true, 
		missingMessage : '请输入员工介绍',
	});

	//单击添加按钮
	$("#employeeAddButton").click(function () {
		//验证表单 
		if(!$("#employeeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#employeeAddForm").form({
			    url:"Employee/add",
			    onSubmit: function(){
					if($("#employeeAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#employeeAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#employeeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#employeeClearButton").click(function () { 
		$("#employeeAddForm").form("clear"); 
	});
});
