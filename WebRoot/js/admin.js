
$(function () {
	
	$('#nav').tree({
		//url : 'Nav/Nav_queryNavById.action', 
		lines : true,
		onLoadSuccess : function (node, data) {
			if (data) {
				$(data).each(function (index, value) {
					if (this.state == 'closed') {
						$('#nav').tree('expandAll');
					}
				});
			}
		},
		
		data: 
			[{
		       text: "楼栋管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加楼栋",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "Building/building_add.jsp"
			    	   	},
			    		{
			    	   		text: "楼栋管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "Building/building_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "员工管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加员工",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "Employee/employee_add.jsp"
			    	   	},
			    		{
			    	   		text: "员工管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "Employee/employee_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "业主管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加业主",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "Owner/owner_add.jsp"
			    	   	},
			    		{
			    	   		text: "业主管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "Owner/owner_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "停车位管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加停车位",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "Parking/parking_add.jsp"
			    	   	},
			    		{
			    	   		text: "停车位管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "Parking/parking_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "报修管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加报修",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "Repair/repair_add.jsp"
			    	   	},
			    		{
			    	   		text: "报修管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "Repair/repair_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "费用类别管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加费用类别",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "FeeType/feeType_add.jsp"
			    	   	},
			    		{
			    	   		text: "费用类别管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "FeeType/feeType_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "收费管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加收费",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "Fee/fee_add.jsp"
			    	   	},
			    		{
			    	   		text: "收费管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "Fee/fee_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "设施管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加设施",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "Facility/facility_add.jsp"
			    	   	},
			    		{
			    	   		text: "设施管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "Facility/facility_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "工资管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加工资",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "Salary/salary_add.jsp"
			    	   	},
			    		{
			    	   		text: "工资管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "Salary/salary_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "留言投诉管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加留言投诉",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "LeaveWord/leaveWord_add.jsp"
			    	   	},
			    		{
			    	   		text: "留言投诉管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "LeaveWord/leaveWord_query_result.jsp"
			    	    }
			    	   ]
			},{
		       text: "管理员管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "添加管理员",
			    		    state: "open",
			    		    iconCls: "icon-add-new",
			    		    url: "Manager/manager_add.jsp"
			    	   	},
			    		{
			    	   		text: "管理员管理",
			    	   		state: "open",
			    	   		iconCls: "icon-manager",
			    	   		url: "Manager/manager_query_result.jsp"
			    	    }
			    	   ]
			},{
			       text: "系统管理",
			       state: "closed",
			       iconCls: "icon-system",
			       children:
			    	   [{
			    		    text: "修改密码",
			    		    state: "open",
			    		    iconCls: "icon-edit",
			    		    url: "password_modify.jsp"
			    	   	}
			    	   ]
			}],
		onClick : function (node) {
			if (node.url) {
				if ($('#tabs').tabs('exists', node.text)) {
					$('#tabs').tabs('select', node.text);
				} else {
					$('#tabs').tabs('add', {
						title : node.text,
						iconCls : node.iconCls,
						closable : true,
						href : node.url,
						//content: '<iframe name="mainFrame" scrolling="auto" frameborder="0"  src="' + node.url + '" style="width:100%;height:100%;"></iframe>'
					});
				} 
			}
		}
	});
	
	$('#tabs').tabs({
		fit : true,
		border : false, 
		//width: $("#tabs").parent().width()-100,  
	});


	$(window).resize(function () {
		$('#tabs').tabs({ 
			height: "auto"
		});  
	});
	  
	
	

	//下面是扩展自定义验证
	$.extend($.fn.validatebox.defaults.rules, {
        idcard: {// 验证身份证
            validator: function (value) {
                return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
            },
            message: '身份证号码格式不正确'
        },
        minLength: {
            validator: function (value, param) {
                return value.length >= param[0];
            },
            message: '请输入至少（2）个字符.'
        },
        length: { validator: function (value, param) {
            var len = $.trim(value).length;
            return len >= param[0] && len <= param[1];
        },
            message: "输入内容长度必须介于{0}和{1}之间."
        },
        phone: {// 验证电话号码
            validator: function (value) {
                return /^((\d2,3)|(\d{3}\-))?(0\d2,3|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
            },
            message: '格式不正确,请使用下面格式:020-88888888'
        },
        mobile: {// 验证手机号码
            validator: function (value) {
                return /^(13|15|18)\d{9}$/i.test(value);
            },
            message: '手机号码格式不正确'
        },
        intOrFloat: {// 验证整数或小数
            validator: function (value) {
                return /^\d+(\.\d+)?$/i.test(value);
            },
            message: '请输入数字，并确保格式正确'
        },
        currency: {// 验证货币
            validator: function (value) {
                return /^\d+(\.\d+)?$/i.test(value);
            },
            message: '货币格式不正确'
        },
        qq: {// 验证QQ,从10000开始
            validator: function (value) {
                return /^[1-9]\d{4,9}$/i.test(value);
            },
            message: 'QQ号码格式不正确'
        },
        integer: {// 验证整数 可正负数
            validator: function (value) { 
        		return /^[+]?[0-9]\d*$/.test(value);
            },
            message: '请输入整数'
        },
        number: {  
            validator: function (value, param) {  
                return /^[0-9]+.?[0-9]*$/.test(value);  
            },  
            message: '请输入数字'  
        },
        age: {// 验证年龄
            validator: function (value) {
                return /^(?:[1-9][0-9]?|1[01][0-9]|120)$/i.test(value);
            },
            message: '年龄必须是0到120之间的整数'
        },

        chinese: {// 验证中文
            validator: function (value) {
                return /^[\Α-\￥]+$/i.test(value);
            },
            message: '请输入中文'
        },
        english: {// 验证英语
            validator: function (value) {
                return /^[A-Za-z]+$/i.test(value);
            },
            message: '请输入英文'
        },
        unnormal: {// 验证是否包含空格和非法字符
            validator: function (value) {
                return /.+/i.test(value);
            },
            message: '输入值不能为空和包含其他非法字符'
        },
        username: {// 验证用户名
            validator: function (value) {
                return /^[a-zA-Z][a-zA-Z0-9_]{5,15}$/i.test(value);
            },
            message: '用户名不合法（字母开头，允许6-16字节，允许字母数字下划线）'
        },
        faxno: {// 验证传真
            validator: function (value) {
                //            return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/i.test(value);
                return /^((\d2,3)|(\d{3}\-))?(0\d2,3|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
            },
            message: '传真号码不正确'
        },
        zip: {// 验证邮政编码
            validator: function (value) {
                return /^[1-9]\d{5}$/i.test(value);
            },
            message: '邮政编码格式不正确'
        },
        ip: {// 验证IP地址
            validator: function (value) {
                return /d+.d+.d+.d+/i.test(value);
            },
            message: 'IP地址格式不正确'
        },
        name: {// 验证姓名，可以是中文或英文
            validator: function (value) {
                return /^[\Α-\￥]+$/i.test(value) | /^\w+[\w\s]+\w+$/i.test(value);
            },
            message: '请输入姓名'
        },
        date: {// 验证姓名，可以是中文或英文
            validator: function (value) {
                //格式yyyy-MM-dd或yyyy-M-d
                return /^(?:(?!0000)[0-9]{4}([-]?)(?:(?:0?[1-9]|1[0-2])\1(?:0?[1-9]|1[0-9]|2[0-8])|(?:0?[13-9]|1[0-2])\1(?:29|30)|(?:0?[13578]|1[02])\1(?:31))|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)([-]?)0?2\2(?:29))$/i.test(value);
            },
            message: '清输入合适的日期格式'
        },
        msn: {
            validator: function (value) {
                return /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(value);
            },
            message: '请输入有效的msn账号(例：abc@hotnail(msn/live).com)'
        },
        same: {
            validator: function (value, param) {
                if ($("#" + param[0]).val() != "" && value != "") {
                    return $("#" + param[0]).val() == value;
                } else {
                    return true;
                }
            },
            message: '两次输入的密码不一致！'
        }
    });
});
