<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.LeaveWord" %>
<%@ page import="com.chengxusheji.po.Owner" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<LeaveWord> leaveWordList = (List<LeaveWord>)request.getAttribute("leaveWordList");
    //获取所有的ownerObj信息
    List<Owner> ownerList = (List<Owner>)request.getAttribute("ownerList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String title = (String)request.getAttribute("title"); //标题查询关键字
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
    Owner ownerObj = (Owner)request.getAttribute("ownerObj");
    String opUser = (String)request.getAttribute("opUser"); //回复人查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>留言投诉查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#leaveWordListPanel" aria-controls="leaveWordListPanel" role="tab" data-toggle="tab">留言投诉列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>LeaveWord/leaveWord_frontAdd.jsp" style="display:none;">添加留言投诉</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="leaveWordListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录id</td><td>标题</td><td>内容</td><td>发布时间</td><td>提交住户</td><td>回复内容</td><td>回复时间</td><td>回复人</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<leaveWordList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		LeaveWord leaveWord = leaveWordList.get(i); //获取到留言投诉对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=leaveWord.getLeaveWordId() %></td>
 											<td><%=leaveWord.getTitle() %></td>
 											<td><%=leaveWord.getContent() %></td>
 											<td><%=leaveWord.getAddTime() %></td>
 											<td><%=leaveWord.getOwnerObj().getOwnerName() %></td>
 											<td><%=leaveWord.getReplyContent() %></td>
 											<td><%=leaveWord.getReplyTime() %></td>
 											<td><%=leaveWord.getOpUser() %></td>
 											<td>
 												<a href="<%=basePath  %>LeaveWord/<%=leaveWord.getLeaveWordId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="leaveWordEdit('<%=leaveWord.getLeaveWordId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="leaveWordDelete('<%=leaveWord.getLeaveWordId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>留言投诉查询</h1>
		</div>
		<form name="leaveWordQueryForm" id="leaveWordQueryForm" action="<%=basePath %>LeaveWord/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="title">标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入标题">
			</div>






			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" value="<%=addTime %>" class="form-control" placeholder="请输入发布时间">
			</div>






            <div class="form-group">
            	<label for="ownerObj_ownerId">提交住户：</label>
                <select id="ownerObj_ownerId" name="ownerObj.ownerId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Owner ownerTemp:ownerList) {
	 					String selected = "";
 					if(ownerObj!=null && ownerObj.getOwnerId()!=null && ownerObj.getOwnerId().intValue()==ownerTemp.getOwnerId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=ownerTemp.getOwnerId() %>" <%=selected %>><%=ownerTemp.getOwnerName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="opUser">回复人:</label>
				<input type="text" id="opUser" name="opUser" value="<%=opUser %>" class="form-control" placeholder="请输入回复人">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="leaveWordEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;留言投诉信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#leaveWordEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxLeaveWordModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.leaveWordQueryForm.currentPage.value = currentPage;
    document.leaveWordQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.leaveWordQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.leaveWordQueryForm.currentPage.value = pageValue;
    documentleaveWordQueryForm.submit();
}

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
				$('#leaveWordEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除留言投诉信息*/
function leaveWordDelete(leaveWordId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "LeaveWord/deletes",
			data : {
				leaveWordIds : leaveWordId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#leaveWordQueryForm").submit();
					//location.href= basePath + "LeaveWord/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

