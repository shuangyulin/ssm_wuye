<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.FeeType" %>
<%@ page import="com.chengxusheji.po.Owner" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>收费添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Fee/frontlist">收费列表</a></li>
			    	<li role="presentation" class="active"><a href="#feeAdd" aria-controls="feeAdd" role="tab" data-toggle="tab">添加收费</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="feeList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="feeAdd"> 
				      	<form class="form-horizontal" name="feeAddForm" id="feeAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="fee_feeTypeObj_typeId" class="col-md-2 text-right">费用类别:</label>
						  	 <div class="col-md-8">
							    <select id="fee_feeTypeObj_typeId" name="fee.feeTypeObj.typeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fee_ownerObj_ownerId" class="col-md-2 text-right">住户信息:</label>
						  	 <div class="col-md-8">
							    <select id="fee_ownerObj_ownerId" name="fee.ownerObj.ownerId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fee_feeDateDiv" class="col-md-2 text-right">收费时间:</label>
						  	 <div class="col-md-8">
				                <div id="fee_feeDateDiv" class="input-group date fee_feeDate col-md-12" data-link-field="fee_feeDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="fee_feeDate" name="fee.feeDate" size="16" type="text" value="" placeholder="请选择收费时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fee_feeMoney" class="col-md-2 text-right">收费金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="fee_feeMoney" name="fee.feeMoney" class="form-control" placeholder="请输入收费金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fee_feeContent" class="col-md-2 text-right">收费内容:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="fee_feeContent" name="fee.feeContent" class="form-control" placeholder="请输入收费内容">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="fee_opUser" class="col-md-2 text-right">操作员:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="fee_opUser" name="fee.opUser" class="form-control" placeholder="请输入操作员">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxFeeAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#feeAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加收费信息
	function ajaxFeeAdd() { 
		//提交之前先验证表单
		$("#feeAddForm").data('bootstrapValidator').validate();
		if(!$("#feeAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Fee/add",
			dataType : "json" , 
			data: new FormData($("#feeAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#feeAddForm").find("input").val("");
					$("#feeAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证收费添加表单字段
	$('#feeAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"fee.feeDate": {
				validators: {
					notEmpty: {
						message: "收费时间不能为空",
					}
				}
			},
			"fee.feeMoney": {
				validators: {
					notEmpty: {
						message: "收费金额不能为空",
					},
					numeric: {
						message: "收费金额不正确"
					}
				}
			},
			"fee.feeContent": {
				validators: {
					notEmpty: {
						message: "收费内容不能为空",
					}
				}
			},
			"fee.opUser": {
				validators: {
					notEmpty: {
						message: "操作员不能为空",
					}
				}
			},
		}
	}); 
	//初始化费用类别下拉框值 
	$.ajax({
		url: basePath + "FeeType/listAll",
		type: "get",
		success: function(feeTypes,response,status) { 
			$("#fee_feeTypeObj_typeId").empty();
			var html="";
    		$(feeTypes).each(function(i,feeType){
    			html += "<option value='" + feeType.typeId + "'>" + feeType.typeName + "</option>";
    		});
    		$("#fee_feeTypeObj_typeId").html(html);
    	}
	});
	//初始化住户信息下拉框值 
	$.ajax({
		url: basePath + "Owner/listAll",
		type: "get",
		success: function(owners,response,status) { 
			$("#fee_ownerObj_ownerId").empty();
			var html="";
    		$(owners).each(function(i,owner){
    			html += "<option value='" + owner.ownerId + "'>" + owner.ownerName + "</option>";
    		});
    		$("#fee_ownerObj_ownerId").html(html);
    	}
	});
	//收费时间组件
	$('#fee_feeDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#feeAddForm').data('bootstrapValidator').updateStatus('fee.feeDate', 'NOT_VALIDATED',null).validateField('fee.feeDate');
	});
})
</script>
</body>
</html>
