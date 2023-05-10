$(function () {
	$("#manager_manageUserName").validatebox({
		required : true, 
		missingMessage : '请输入用户名',
	});

	$("#manager_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#manager_manageType").validatebox({
		required : true, 
		missingMessage : '请输入管理员类别',
	});

	$("#manager_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#manager_sex").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#manager_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	//单击添加按钮
	$("#managerAddButton").click(function () {
		//验证表单 
		if(!$("#managerAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#managerAddForm").form({
			    url:"Manager/add",
			    onSubmit: function(){
					if($("#managerAddForm").form("validate"))  { 
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
                        $("#managerAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#managerAddForm").submit();
		}
	});

	//单击清空按钮
	$("#managerClearButton").click(function () { 
		$("#managerAddForm").form("clear"); 
	});
});
