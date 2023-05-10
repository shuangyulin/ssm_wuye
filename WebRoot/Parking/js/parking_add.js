$(function () {
	$("#parking_parkingName").validatebox({
		required : true, 
		missingMessage : '请输入车位名称',
	});

	$("#parking_plateNumber").validatebox({
		required : true, 
		missingMessage : '请输入车牌号',
	});

	$("#parking_ownerObj_ownerId").combobox({
	    url:'Owner/listAll',
	    valueField: "ownerId",
	    textField: "ownerName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#parking_ownerObj_ownerId").combobox("getData"); 
            if (data.length > 0) {
                $("#parking_ownerObj_ownerId").combobox("select", data[0].ownerId);
            }
        }
	});
	$("#parking_opUser").validatebox({
		required : true, 
		missingMessage : '请输入操作员',
	});

	//单击添加按钮
	$("#parkingAddButton").click(function () {
		//验证表单 
		if(!$("#parkingAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#parkingAddForm").form({
			    url:"Parking/add",
			    onSubmit: function(){
					if($("#parkingAddForm").form("validate"))  { 
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
                        $("#parkingAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#parkingAddForm").submit();
		}
	});

	//单击清空按钮
	$("#parkingClearButton").click(function () { 
		$("#parkingAddForm").form("clear"); 
	});
});
