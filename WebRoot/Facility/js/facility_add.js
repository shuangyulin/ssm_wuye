$(function () {
	$("#facility_name").validatebox({
		required : true, 
		missingMessage : '请输入设施名称',
	});

	$("#facility_count").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入数量',
		invalidMessage : '数量输入不对',
	});

	$("#facility_startTime").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#facility_facilityState").validatebox({
		required : true, 
		missingMessage : '请输入设施状态',
	});

	//单击添加按钮
	$("#facilityAddButton").click(function () {
		//验证表单 
		if(!$("#facilityAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#facilityAddForm").form({
			    url:"Facility/add",
			    onSubmit: function(){
					if($("#facilityAddForm").form("validate"))  { 
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
                        $("#facilityAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#facilityAddForm").submit();
		}
	});

	//单击清空按钮
	$("#facilityClearButton").click(function () { 
		$("#facilityAddForm").form("clear"); 
	});
});
