<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.LeaveWord" %>
<%@ page import="com.chengxusheji.po.Owner" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的ownerObj信息
    List<Owner> ownerList = (List<Owner>)request.getAttribute("ownerList");
    LeaveWord leaveWord = (LeaveWord)request.getAttribute("leaveWord");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改留言投诉信息</TITLE>
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
  		<li class="active">留言投诉信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="leaveWordEditForm" id="leaveWordEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="leaveWord_leaveWordId_edit" class="col-md-3 text-right">记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="leaveWord_leaveWordId_edit" name="leaveWord.leaveWordId" class="form-control" placeholder="请输入记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="leaveWord_title_edit" class="col-md-3 text-right">标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="leaveWord_title_edit" name="leaveWord.title" class="form-control" placeholder="请输入标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_content_edit" class="col-md-3 text-right">内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="leaveWord_content_edit" name="leaveWord.content" rows="8" class="form-control" placeholder="请输入内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="leaveWord_addTime_edit" name="leaveWord.addTime" class="form-control" placeholder="请输入发布时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_ownerObj_ownerId_edit" class="col-md-3 text-right">提交住户:</label>
		  	 <div class="col-md-9">
			    <select id="leaveWord_ownerObj_ownerId_edit" name="leaveWord.ownerObj.ownerId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_replyContent_edit" class="col-md-3 text-right">回复内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="leaveWord_replyContent_edit" name="leaveWord.replyContent" rows="8" class="form-control" placeholder="请输入回复内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_replyTime_edit" class="col-md-3 text-right">回复时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="leaveWord_replyTime_edit" name="leaveWord.replyTime" class="form-control" placeholder="请输入回复时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="leaveWord_opUser_edit" class="col-md-3 text-right">回复人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="leaveWord_opUser_edit" name="leaveWord.opUser" class="form-control" placeholder="请输入回复人">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxLeaveWordModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#leaveWordEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改留言投诉界面并初始化数据*/
function leaveWordEdit(leaveWordId) {
	$.ajax({
		url :  basePath + "LeaveWord/" + leaveWordId + "/update",
		type : "get",
		dataType: "json",
		success : function (leaveWord, response, status) {
			if (leaveWord) {
				$("#leaveWord_leaveWordId_edit").val(leaveWord.leaveWordId);
				$("#leaveWord_title_edit").val(leaveWord.title);
				$("#leaveWord_content_edit").val(leaveWord.content);
				$("#leaveWord_addTime_edit").val(leaveWord.addTime);
				$.ajax({
					url: basePath + "Owner/listAll",
					type: "get",
					success: function(owners,response,status) { 
						$("#leaveWord_ownerObj_ownerId_edit").empty();
						var html="";
		        		$(owners).each(function(i,owner){
		        			html += "<option value='" + owner.ownerId + "'>" + owner.ownerName + "</option>";
		        		});
		        		$("#leaveWord_ownerObj_ownerId_edit").html(html);
		        		$("#leaveWord_ownerObj_ownerId_edit").val(leaveWord.ownerObjPri);
					}
				});
				$("#leaveWord_replyContent_edit").val(leaveWord.replyContent);
				$("#leaveWord_replyTime_edit").val(leaveWord.replyTime);
				$("#leaveWord_opUser_edit").val(leaveWord.opUser);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交留言投诉信息表单给服务器端修改*/
function ajaxLeaveWordModify() {
	$.ajax({
		url :  basePath + "LeaveWord/" + $("#leaveWord_leaveWordId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#leaveWordEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#leaveWordQueryForm").submit();
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
    leaveWordEdit("<%=request.getParameter("leaveWordId")%>");
 })
 </script> 
</body>
</html>

