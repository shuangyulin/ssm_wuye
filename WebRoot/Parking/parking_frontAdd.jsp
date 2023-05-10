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
<title>停车位添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Parking/frontlist">停车位列表</a></li>
			    	<li role="presentation" class="active"><a href="#parkingAdd" aria-controls="parkingAdd" role="tab" data-toggle="tab">添加停车位</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="parkingList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="parkingAdd"> 
				      	<form class="form-horizontal" name="parkingAddForm" id="parkingAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="parking_parkingName" class="col-md-2 text-right">车位名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="parking_parkingName" name="parking.parkingName" class="form-control" placeholder="请输入车位名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="parking_plateNumber" class="col-md-2 text-right">车牌号:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="parking_plateNumber" name="parking.plateNumber" class="form-control" placeholder="请输入车牌号">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="parking_ownerObj_ownerId" class="col-md-2 text-right">车主:</label>
						  	 <div class="col-md-8">
							    <select id="parking_ownerObj_ownerId" name="parking.ownerObj.ownerId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="parking_opUser" class="col-md-2 text-right">操作员:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="parking_opUser" name="parking.opUser" class="form-control" placeholder="请输入操作员">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxParkingAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#parkingAddForm .form-group {margin:10px;}  </style>
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
	//提交添加停车位信息
	function ajaxParkingAdd() { 
		//提交之前先验证表单
		$("#parkingAddForm").data('bootstrapValidator').validate();
		if(!$("#parkingAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Parking/add",
			dataType : "json" , 
			data: new FormData($("#parkingAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#parkingAddForm").find("input").val("");
					$("#parkingAddForm").find("textarea").val("");
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
	//验证停车位添加表单字段
	$('#parkingAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"parking.parkingName": {
				validators: {
					notEmpty: {
						message: "车位名称不能为空",
					}
				}
			},
			"parking.plateNumber": {
				validators: {
					notEmpty: {
						message: "车牌号不能为空",
					}
				}
			},
			"parking.opUser": {
				validators: {
					notEmpty: {
						message: "操作员不能为空",
					}
				}
			},
		}
	}); 
	//初始化车主下拉框值 
	$.ajax({
		url: basePath + "Owner/listAll",
		type: "get",
		success: function(owners,response,status) { 
			$("#parking_ownerObj_ownerId").empty();
			var html="";
    		$(owners).each(function(i,owner){
    			html += "<option value='" + owner.ownerId + "'>" + owner.ownerName + "</option>";
    		});
    		$("#parking_ownerObj_ownerId").html(html);
    	}
	});
})
</script>
</body>
</html>
