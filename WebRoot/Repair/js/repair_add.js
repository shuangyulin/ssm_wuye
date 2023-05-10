$(function () {
	$("#repair_ownerObj_ownerId").combobox({
	    url:'Owner/listAll',
	    valueField: "ownerId",
	    textField: "ownerName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#repair_ownerObj_ownerId").combobox("getData"); 
            if (data.length > 0) {
                $("#repair_ownerObj_ownerId").combobox("select", data[0].ownerId);
            }
        }
	});
	$("#repair_repairDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#repair_questionDesc").validatebox({
		required : true, 
		missingMessage : '请输入问题描述',
	});

	$("#repair_repairState").validatebox({
		required : true, 
		missingMessage : '请输入报修状态',
	});

	//单击添加按钮
	$("#repairAddButton").click(function () {
		//验证表单 
		if(!$("#repairAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#repairAddForm").form({
			    url:"Repair/add",
			    onSubmit: function(){
					if($("#repairAddForm").form("validate"))  { 
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
                        $("#repairAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#repairAddForm").submit();
		}
	});

	//单击清空按钮
	$("#repairClearButton").click(function () { 
		$("#repairAddForm").form("clear"); 
	});
});
