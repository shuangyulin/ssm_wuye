<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>设施添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Facility/frontlist">设施列表</a></li>
			    	<li role="presentation" class="active"><a href="#facilityAdd" aria-controls="facilityAdd" role="tab" data-toggle="tab">添加设施</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="facilityList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="facilityAdd"> 
				      	<form class="form-horizontal" name="facilityAddForm" id="facilityAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="facility_name" class="col-md-2 text-right">设施名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="facility_name" name="facility.name" class="form-control" placeholder="请输入设施名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="facility_count" class="col-md-2 text-right">数量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="facility_count" name="facility.count" class="form-control" placeholder="请输入数量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="facility_startTimeDiv" class="col-md-2 text-right">开始使用时间:</label>
						  	 <div class="col-md-8">
				                <div id="facility_startTimeDiv" class="input-group date facility_startTime col-md-12" data-link-field="facility_startTime" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="facility_startTime" name="facility.startTime" size="16" type="text" value="" placeholder="请选择开始使用时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="facility_facilityState" class="col-md-2 text-right">设施状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="facility_facilityState" name="facility.facilityState" class="form-control" placeholder="请输入设施状态">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxFacilityAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#facilityAddForm .form-group {margin:10px;}  </style>
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
	//提交添加设施信息
	function ajaxFacilityAdd() { 
		//提交之前先验证表单
		$("#facilityAddForm").data('bootstrapValidator').validate();
		if(!$("#facilityAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Facility/add",
			dataType : "json" , 
			data: new FormData($("#facilityAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#facilityAddForm").find("input").val("");
					$("#facilityAddForm").find("textarea").val("");
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
	//验证设施添加表单字段
	$('#facilityAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"facility.name": {
				validators: {
					notEmpty: {
						message: "设施名称不能为空",
					}
				}
			},
			"facility.count": {
				validators: {
					notEmpty: {
						message: "数量不能为空",
					},
					integer: {
						message: "数量不正确"
					}
				}
			},
			"facility.startTime": {
				validators: {
					notEmpty: {
						message: "开始使用时间不能为空",
					}
				}
			},
			"facility.facilityState": {
				validators: {
					notEmpty: {
						message: "设施状态不能为空",
					}
				}
			},
		}
	}); 
	//开始使用时间组件
	$('#facility_startTimeDiv').datetimepicker({
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
		$('#facilityAddForm').data('bootstrapValidator').updateStatus('facility.startTime', 'NOT_VALIDATED',null).validateField('facility.startTime');
	});
})
</script>
</body>
</html>
