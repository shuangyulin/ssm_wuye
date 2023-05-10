$(function () {
	$("#owner_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#owner_buildingObj_buildingId").combobox({
	    url:'Building/listAll',
	    valueField: "buildingId",
	    textField: "buildingName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#owner_buildingObj_buildingId").combobox("getData"); 
            if (data.length > 0) {
                $("#owner_buildingObj_buildingId").combobox("select", data[0].buildingId);
            }
        }
	});
	$("#owner_roomNo").validatebox({
		required : true, 
		missingMessage : '请输入房间号',
	});

	$("#owner_ownerName").validatebox({
		required : true, 
		missingMessage : '请输入户主',
	});

	$("#owner_area").validatebox({
		required : true, 
		missingMessage : '请输入房屋面积',
	});

	$("#owner_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系方式',
	});

	//单击添加按钮
	$("#ownerAddButton").click(function () {
		//验证表单 
		if(!$("#ownerAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#ownerAddForm").form({
			    url:"Owner/add",
			    onSubmit: function(){
					if($("#ownerAddForm").form("validate"))  { 
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
                        $("#ownerAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#ownerAddForm").submit();
		}
	});

	//单击清空按钮
	$("#ownerClearButton").click(function () { 
		$("#ownerAddForm").form("clear"); 
	});
});
