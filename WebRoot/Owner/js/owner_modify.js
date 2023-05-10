$(function () {
	$.ajax({
		url : "Owner/" + $("#owner_ownerId_edit").val() + "/update",
		type : "get",
		data : {
			//ownerId : $("#owner_ownerId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (owner, response, status) {
			$.messager.progress("close");
			if (owner) { 
				$("#owner_ownerId_edit").val(owner.ownerId);
				$("#owner_ownerId_edit").validatebox({
					required : true,
					missingMessage : "请输入业主id",
					editable: false
				});
				$("#owner_password_edit").val(owner.password);
				$("#owner_password_edit").validatebox({
					required : true,
					missingMessage : "请输入登录密码",
				});
				$("#owner_buildingObj_buildingId_edit").combobox({
					url:"Building/listAll",
					valueField:"buildingId",
					textField:"buildingName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#owner_buildingObj_buildingId_edit").combobox("select", owner.buildingObjPri);
						//var data = $("#owner_buildingObj_buildingId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#owner_buildingObj_buildingId_edit").combobox("select", data[0].buildingId);
						//}
					}
				});
				$("#owner_roomNo_edit").val(owner.roomNo);
				$("#owner_roomNo_edit").validatebox({
					required : true,
					missingMessage : "请输入房间号",
				});
				$("#owner_ownerName_edit").val(owner.ownerName);
				$("#owner_ownerName_edit").validatebox({
					required : true,
					missingMessage : "请输入户主",
				});
				$("#owner_area_edit").val(owner.area);
				$("#owner_area_edit").validatebox({
					required : true,
					missingMessage : "请输入房屋面积",
				});
				$("#owner_telephone_edit").val(owner.telephone);
				$("#owner_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系方式",
				});
				$("#owner_memo_edit").val(owner.memo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#ownerModifyButton").click(function(){ 
		if ($("#ownerEditForm").form("validate")) {
			$("#ownerEditForm").form({
			    url:"Owner/" +  $("#owner_ownerId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#ownerEditForm").form("validate"))  {
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
			$("#ownerEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
