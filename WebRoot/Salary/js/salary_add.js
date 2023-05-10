$(function () {
	$("#salary_employeeObj_employeeNo").combobox({
	    url:'Employee/listAll',
	    valueField: "employeeNo",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#salary_employeeObj_employeeNo").combobox("getData"); 
            if (data.length > 0) {
                $("#salary_employeeObj_employeeNo").combobox("select", data[0].employeeNo);
            }
        }
	});
	$("#salary_year").validatebox({
		required : true, 
		missingMessage : '请输入工资年份',
	});

	$("#salary_month").validatebox({
		required : true, 
		missingMessage : '请输入工资月份',
	});

	$("#salary_salaryMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入工资金额',
		invalidMessage : '工资金额输入不对',
	});

	$("#salary_fafang").validatebox({
		required : true, 
		missingMessage : '请输入是否发放',
	});

	//单击添加按钮
	$("#salaryAddButton").click(function () {
		//验证表单 
		if(!$("#salaryAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#salaryAddForm").form({
			    url:"Salary/add",
			    onSubmit: function(){
					if($("#salaryAddForm").form("validate"))  { 
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
                        $("#salaryAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#salaryAddForm").submit();
		}
	});

	//单击清空按钮
	$("#salaryClearButton").click(function () { 
		$("#salaryAddForm").form("clear"); 
	});
});
