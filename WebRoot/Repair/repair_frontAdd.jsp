<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>报修添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Repair/frontlist">报修列表</a></li>
			    	<li role="presentation" class="active"><a href="#repairAdd" aria-controls="repairAdd" role="tab" data-toggle="tab">添加报修</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="repairList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="repairAdd"> 
				      	<form class="form-horizontal" name="repairAddForm" id="repairAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="repair_ownerObj_ownerId" class="col-md-2 text-right">报修用户:</label>
						  	 <div class="col-md-8">
							    <select id="repair_ownerObj_ownerId" name="repair.ownerObj.ownerId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="repair_repairDateDiv" class="col-md-2 text-right">报修日期:</label>
						  	 <div class="col-md-8">
				                <div id="repair_repairDateDiv" class="input-group date repair_repairDate col-md-12" data-link-field="repair_repairDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="repair_repairDate" name="repair.repairDate" size="16" type="text" value="" placeholder="请选择报修日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="repair_questionDesc" class="col-md-2 text-right">问题描述:</label>
						  	 <div class="col-md-8">
							    <textarea id="repair_questionDesc" name="repair.questionDesc" rows="8" class="form-control" placeholder="请输入问题描述"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="repair_repairState" class="col-md-2 text-right">报修状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="repair_repairState" name="repair.repairState" class="form-control" placeholder="请输入报修状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="repair_handleResult" class="col-md-2 text-right">处理结果:</label>
						  	 <div class="col-md-8">
							    <textarea id="repair_handleResult" name="repair.handleResult" rows="8" class="form-control" placeholder="请输入处理结果"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxRepairAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#repairAddForm .form-group {margin:10px;}  </style>
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
	//提交添加报修信息
	function ajaxRepairAdd() { 
		//提交之前先验证表单
		$("#repairAddForm").data('bootstrapValidator').validate();
		if(!$("#repairAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Repair/add",
			dataType : "json" , 
			data: new FormData($("#repairAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#repairAddForm").find("input").val("");
					$("#repairAddForm").find("textarea").val("");
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
	//验证报修添加表单字段
	$('#repairAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"repair.repairDate": {
				validators: {
					notEmpty: {
						message: "报修日期不能为空",
					}
				}
			},
			"repair.questionDesc": {
				validators: {
					notEmpty: {
						message: "问题描述不能为空",
					}
				}
			},
			"repair.repairState": {
				validators: {
					notEmpty: {
						message: "报修状态不能为空",
					}
				}
			},
		}
	}); 
	//初始化报修用户下拉框值 
	$.ajax({
		url: basePath + "Owner/listAll",
		type: "get",
		success: function(owners,response,status) { 
			$("#repair_ownerObj_ownerId").empty();
			var html="";
    		$(owners).each(function(i,owner){
    			html += "<option value='" + owner.ownerId + "'>" + owner.ownerName + "</option>";
    		});
    		$("#repair_ownerObj_ownerId").html(html);
    	}
	});
	//报修日期组件
	$('#repair_repairDateDiv').datetimepicker({
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
		$('#repairAddForm').data('bootstrapValidator').updateStatus('repair.repairDate', 'NOT_VALIDATED',null).validateField('repair.repairDate');
	});
})
</script>
</body>
</html>
