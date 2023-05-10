<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Repair" %>
<%@ page import="com.chengxusheji.po.Owner" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的ownerObj信息
    List<Owner> ownerList = (List<Owner>)request.getAttribute("ownerList");
    Repair repair = (Repair)request.getAttribute("repair");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改报修信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">报修信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="repairEditForm" id="repairEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="repair_repairId_edit" class="col-md-3 text-right">报修id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="repair_repairId_edit" name="repair.repairId" class="form-control" placeholder="请输入报修id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="repair_ownerObj_ownerId_edit" class="col-md-3 text-right">报修用户:</label>
		  	 <div class="col-md-9">
			    <select id="repair_ownerObj_ownerId_edit" name="repair.ownerObj.ownerId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="repair_repairDate_edit" class="col-md-3 text-right">报修日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date repair_repairDate_edit col-md-12" data-link-field="repair_repairDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="repair_repairDate_edit" name="repair.repairDate" size="16" type="text" value="" placeholder="请选择报修日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="repair_questionDesc_edit" class="col-md-3 text-right">问题描述:</label>
		  	 <div class="col-md-9">
			    <textarea id="repair_questionDesc_edit" name="repair.questionDesc" rows="8" class="form-control" placeholder="请输入问题描述"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="repair_repairState_edit" class="col-md-3 text-right">报修状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="repair_repairState_edit" name="repair.repairState" class="form-control" placeholder="请输入报修状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="repair_handleResult_edit" class="col-md-3 text-right">处理结果:</label>
		  	 <div class="col-md-9">
			    <textarea id="repair_handleResult_edit" name="repair.handleResult" rows="8" class="form-control" placeholder="请输入处理结果"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxRepairModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#repairEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改报修界面并初始化数据*/
function repairEdit(repairId) {
	$.ajax({
		url :  basePath + "Repair/" + repairId + "/update",
		type : "get",
		dataType: "json",
		success : function (repair, response, status) {
			if (repair) {
				$("#repair_repairId_edit").val(repair.repairId);
				$.ajax({
					url: basePath + "Owner/listAll",
					type: "get",
					success: function(owners,response,status) { 
						$("#repair_ownerObj_ownerId_edit").empty();
						var html="";
		        		$(owners).each(function(i,owner){
		        			html += "<option value='" + owner.ownerId + "'>" + owner.ownerName + "</option>";
		        		});
		        		$("#repair_ownerObj_ownerId_edit").html(html);
		        		$("#repair_ownerObj_ownerId_edit").val(repair.ownerObjPri);
					}
				});
				$("#repair_repairDate_edit").val(repair.repairDate);
				$("#repair_questionDesc_edit").val(repair.questionDesc);
				$("#repair_repairState_edit").val(repair.repairState);
				$("#repair_handleResult_edit").val(repair.handleResult);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交报修信息表单给服务器端修改*/
function ajaxRepairModify() {
	$.ajax({
		url :  basePath + "Repair/" + $("#repair_repairId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#repairEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#repairQueryForm").submit();
            }else{
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
    /*报修日期组件*/
    $('.repair_repairDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    repairEdit("<%=request.getParameter("repairId")%>");
 })
 </script> 
</body>
</html>

