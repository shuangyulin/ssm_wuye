<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Building" %>
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
<title>业主添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Owner/frontlist">业主列表</a></li>
			    	<li role="presentation" class="active"><a href="#ownerAdd" aria-controls="ownerAdd" role="tab" data-toggle="tab">添加业主</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="ownerList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="ownerAdd"> 
				      	<form class="form-horizontal" name="ownerAddForm" id="ownerAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="owner_password" class="col-md-2 text-right">登录密码:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="owner_password" name="owner.password" class="form-control" placeholder="请输入登录密码">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="owner_buildingObj_buildingId" class="col-md-2 text-right">楼栋名称:</label>
						  	 <div class="col-md-8">
							    <select id="owner_buildingObj_buildingId" name="owner.buildingObj.buildingId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="owner_roomNo" class="col-md-2 text-right">房间号:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="owner_roomNo" name="owner.roomNo" class="form-control" placeholder="请输入房间号">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="owner_ownerName" class="col-md-2 text-right">户主:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="owner_ownerName" name="owner.ownerName" class="form-control" placeholder="请输入户主">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="owner_area" class="col-md-2 text-right">房屋面积:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="owner_area" name="owner.area" class="form-control" placeholder="请输入房屋面积">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="owner_telephone" class="col-md-2 text-right">联系方式:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="owner_telephone" name="owner.telephone" class="form-control" placeholder="请输入联系方式">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="owner_memo" class="col-md-2 text-right">备注信息:</label>
						  	 <div class="col-md-8">
							    <textarea id="owner_memo" name="owner.memo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxOwnerAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#ownerAddForm .form-group {margin:10px;}  </style>
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
	//提交添加业主信息
	function ajaxOwnerAdd() { 
		//提交之前先验证表单
		$("#ownerAddForm").data('bootstrapValidator').validate();
		if(!$("#ownerAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Owner/add",
			dataType : "json" , 
			data: new FormData($("#ownerAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#ownerAddForm").find("input").val("");
					$("#ownerAddForm").find("textarea").val("");
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
	//验证业主添加表单字段
	$('#ownerAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"owner.password": {
				validators: {
					notEmpty: {
						message: "登录密码不能为空",
					}
				}
			},
			"owner.roomNo": {
				validators: {
					notEmpty: {
						message: "房间号不能为空",
					}
				}
			},
			"owner.ownerName": {
				validators: {
					notEmpty: {
						message: "户主不能为空",
					}
				}
			},
			"owner.area": {
				validators: {
					notEmpty: {
						message: "房屋面积不能为空",
					}
				}
			},
			"owner.telephone": {
				validators: {
					notEmpty: {
						message: "联系方式不能为空",
					}
				}
			},
		}
	}); 
	//初始化楼栋名称下拉框值 
	$.ajax({
		url: basePath + "Building/listAll",
		type: "get",
		success: function(buildings,response,status) { 
			$("#owner_buildingObj_buildingId").empty();
			var html="";
    		$(buildings).each(function(i,building){
    			html += "<option value='" + building.buildingId + "'>" + building.buildingName + "</option>";
    		});
    		$("#owner_buildingObj_buildingId").html(html);
    	}
	});
})
</script>
</body>
</html>
