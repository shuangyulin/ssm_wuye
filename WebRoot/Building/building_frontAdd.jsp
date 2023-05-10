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
<title>楼栋添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Building/frontlist">楼栋列表</a></li>
			    	<li role="presentation" class="active"><a href="#buildingAdd" aria-controls="buildingAdd" role="tab" data-toggle="tab">添加楼栋</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="buildingList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="buildingAdd"> 
				      	<form class="form-horizontal" name="buildingAddForm" id="buildingAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="building_buildingName" class="col-md-2 text-right">楼栋名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="building_buildingName" name="building.buildingName" class="form-control" placeholder="请输入楼栋名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="building_memo" class="col-md-2 text-right">楼栋备注:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="building_memo" name="building.memo" class="form-control" placeholder="请输入楼栋备注">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxBuildingAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#buildingAddForm .form-group {margin:10px;}  </style>
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
	//提交添加楼栋信息
	function ajaxBuildingAdd() { 
		//提交之前先验证表单
		$("#buildingAddForm").data('bootstrapValidator').validate();
		if(!$("#buildingAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Building/add",
			dataType : "json" , 
			data: new FormData($("#buildingAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#buildingAddForm").find("input").val("");
					$("#buildingAddForm").find("textarea").val("");
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
	//验证楼栋添加表单字段
	$('#buildingAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"building.buildingName": {
				validators: {
					notEmpty: {
						message: "楼栋名称不能为空",
					}
				}
			},
			"building.memo": {
				validators: {
					notEmpty: {
						message: "楼栋备注不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
