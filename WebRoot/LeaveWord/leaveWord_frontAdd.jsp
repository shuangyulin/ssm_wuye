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
<title>留言投诉添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>LeaveWord/frontlist">留言投诉列表</a></li>
			    	<li role="presentation" class="active"><a href="#leaveWordAdd" aria-controls="leaveWordAdd" role="tab" data-toggle="tab">添加留言投诉</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="leaveWordList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="leaveWordAdd"> 
				      	<form class="form-horizontal" name="leaveWordAddForm" id="leaveWordAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="leaveWord_title" class="col-md-2 text-right">标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="leaveWord_title" name="leaveWord.title" class="form-control" placeholder="请输入标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveWord_content" class="col-md-2 text-right">内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="leaveWord_content" name="leaveWord.content" rows="8" class="form-control" placeholder="请输入内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveWord_addTime" class="col-md-2 text-right">发布时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="leaveWord_addTime" name="leaveWord.addTime" class="form-control" placeholder="请输入发布时间">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveWord_ownerObj_ownerId" class="col-md-2 text-right">提交住户:</label>
						  	 <div class="col-md-8">
							    <select id="leaveWord_ownerObj_ownerId" name="leaveWord.ownerObj.ownerId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveWord_replyContent" class="col-md-2 text-right">回复内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="leaveWord_replyContent" name="leaveWord.replyContent" rows="8" class="form-control" placeholder="请输入回复内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveWord_replyTime" class="col-md-2 text-right">回复时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="leaveWord_replyTime" name="leaveWord.replyTime" class="form-control" placeholder="请输入回复时间">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="leaveWord_opUser" class="col-md-2 text-right">回复人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="leaveWord_opUser" name="leaveWord.opUser" class="form-control" placeholder="请输入回复人">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxLeaveWordAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#leaveWordAddForm .form-group {margin:10px;}  </style>
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
	//提交添加留言投诉信息
	function ajaxLeaveWordAdd() { 
		//提交之前先验证表单
		$("#leaveWordAddForm").data('bootstrapValidator').validate();
		if(!$("#leaveWordAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "LeaveWord/add",
			dataType : "json" , 
			data: new FormData($("#leaveWordAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#leaveWordAddForm").find("input").val("");
					$("#leaveWordAddForm").find("textarea").val("");
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
	//验证留言投诉添加表单字段
	$('#leaveWordAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"leaveWord.title": {
				validators: {
					notEmpty: {
						message: "标题不能为空",
					}
				}
			},
			"leaveWord.content": {
				validators: {
					notEmpty: {
						message: "内容不能为空",
					}
				}
			},
			"leaveWord.opUser": {
				validators: {
					notEmpty: {
						message: "回复人不能为空",
					}
				}
			},
		}
	}); 
	//初始化提交住户下拉框值 
	$.ajax({
		url: basePath + "Owner/listAll",
		type: "get",
		success: function(owners,response,status) { 
			$("#leaveWord_ownerObj_ownerId").empty();
			var html="";
    		$(owners).each(function(i,owner){
    			html += "<option value='" + owner.ownerId + "'>" + owner.ownerName + "</option>";
    		});
    		$("#leaveWord_ownerObj_ownerId").html(html);
    	}
	});
})
</script>
</body>
</html>
