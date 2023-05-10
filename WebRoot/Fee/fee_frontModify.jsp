<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Fee" %>
<%@ page import="com.chengxusheji.po.FeeType" %>
<%@ page import="com.chengxusheji.po.Owner" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的feeTypeObj信息
    List<FeeType> feeTypeList = (List<FeeType>)request.getAttribute("feeTypeList");
    //获取所有的ownerObj信息
    List<Owner> ownerList = (List<Owner>)request.getAttribute("ownerList");
    Fee fee = (Fee)request.getAttribute("fee");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改收费信息</TITLE>
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
  		<li class="active">收费信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="feeEditForm" id="feeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="fee_feeId_edit" class="col-md-3 text-right">费用id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="fee_feeId_edit" name="fee.feeId" class="form-control" placeholder="请输入费用id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="fee_feeTypeObj_typeId_edit" class="col-md-3 text-right">费用类别:</label>
		  	 <div class="col-md-9">
			    <select id="fee_feeTypeObj_typeId_edit" name="fee.feeTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fee_ownerObj_ownerId_edit" class="col-md-3 text-right">住户信息:</label>
		  	 <div class="col-md-9">
			    <select id="fee_ownerObj_ownerId_edit" name="fee.ownerObj.ownerId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fee_feeDate_edit" class="col-md-3 text-right">收费时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date fee_feeDate_edit col-md-12" data-link-field="fee_feeDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="fee_feeDate_edit" name="fee.feeDate" size="16" type="text" value="" placeholder="请选择收费时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fee_feeMoney_edit" class="col-md-3 text-right">收费金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="fee_feeMoney_edit" name="fee.feeMoney" class="form-control" placeholder="请输入收费金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fee_feeContent_edit" class="col-md-3 text-right">收费内容:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="fee_feeContent_edit" name="fee.feeContent" class="form-control" placeholder="请输入收费内容">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="fee_opUser_edit" class="col-md-3 text-right">操作员:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="fee_opUser_edit" name="fee.opUser" class="form-control" placeholder="请输入操作员">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxFeeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#feeEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改收费界面并初始化数据*/
function feeEdit(feeId) {
	$.ajax({
		url :  basePath + "Fee/" + feeId + "/update",
		type : "get",
		dataType: "json",
		success : function (fee, response, status) {
			if (fee) {
				$("#fee_feeId_edit").val(fee.feeId);
				$.ajax({
					url: basePath + "FeeType/listAll",
					type: "get",
					success: function(feeTypes,response,status) { 
						$("#fee_feeTypeObj_typeId_edit").empty();
						var html="";
		        		$(feeTypes).each(function(i,feeType){
		        			html += "<option value='" + feeType.typeId + "'>" + feeType.typeName + "</option>";
		        		});
		        		$("#fee_feeTypeObj_typeId_edit").html(html);
		        		$("#fee_feeTypeObj_typeId_edit").val(fee.feeTypeObjPri);
					}
				});
				$.ajax({
					url: basePath + "Owner/listAll",
					type: "get",
					success: function(owners,response,status) { 
						$("#fee_ownerObj_ownerId_edit").empty();
						var html="";
		        		$(owners).each(function(i,owner){
		        			html += "<option value='" + owner.ownerId + "'>" + owner.ownerName + "</option>";
		        		});
		        		$("#fee_ownerObj_ownerId_edit").html(html);
		        		$("#fee_ownerObj_ownerId_edit").val(fee.ownerObjPri);
					}
				});
				$("#fee_feeDate_edit").val(fee.feeDate);
				$("#fee_feeMoney_edit").val(fee.feeMoney);
				$("#fee_feeContent_edit").val(fee.feeContent);
				$("#fee_opUser_edit").val(fee.opUser);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交收费信息表单给服务器端修改*/
function ajaxFeeModify() {
	$.ajax({
		url :  basePath + "Fee/" + $("#fee_feeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#feeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#feeQueryForm").submit();
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
    /*收费时间组件*/
    $('.fee_feeDate_edit').datetimepicker({
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
    feeEdit("<%=request.getParameter("feeId")%>");
 })
 </script> 
</body>
</html>

