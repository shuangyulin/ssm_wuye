$(function () {
	$("#fee_feeTypeObj_typeId").combobox({
	    url:'FeeType/listAll',
	    valueField: "typeId",
	    textField: "typeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#fee_feeTypeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#fee_feeTypeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#fee_ownerObj_ownerId").combobox({
	    url:'Owner/listAll',
	    valueField: "ownerId",
	    textField: "ownerName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#fee_ownerObj_ownerId").combobox("getData"); 
            if (data.length > 0) {
                $("#fee_ownerObj_ownerId").combobox("select", data[0].ownerId);
            }
        }
	});
	$("#fee_feeDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#fee_feeMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入收费金额',
		invalidMessage : '收费金额输入不对',
	});

	$("#fee_feeContent").validatebox({
		required : true, 
		missingMessage : '请输入收费内容',
	});

	$("#fee_opUser").validatebox({
		required : true, 
		missingMessage : '请输入操作员',
	});

	//单击添加按钮
	$("#feeAddButton").click(function () {
		//验证表单 
		if(!$("#feeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#feeAddForm").form({
			    url:"Fee/add",
			    onSubmit: function(){
					if($("#feeAddForm").form("validate"))  { 
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
                        $("#feeAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#feeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#feeClearButton").click(function () { 
		$("#feeAddForm").form("clear"); 
	});
});
