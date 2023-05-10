<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Repair" %>
<%@ page import="com.chengxusheji.po.Owner" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Repair> repairList = (List<Repair>)request.getAttribute("repairList");
    //获取所有的ownerObj信息
    List<Owner> ownerList = (List<Owner>)request.getAttribute("ownerList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Owner ownerObj = (Owner)request.getAttribute("ownerObj");
    String repairDate = (String)request.getAttribute("repairDate"); //报修日期查询关键字
    String questionDesc = (String)request.getAttribute("questionDesc"); //问题描述查询关键字
    String repairState = (String)request.getAttribute("repairState"); //报修状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>报修查询</title>
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
			    	<li role="presentation" class="active"><a href="#repairListPanel" aria-controls="repairListPanel" role="tab" data-toggle="tab">报修列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Repair/repair_frontAdd.jsp" style="display:none;">添加报修</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="repairListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>报修id</td><td>报修用户</td><td>报修日期</td><td>问题描述</td><td>报修状态</td><td>处理结果</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<repairList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Repair repair = repairList.get(i); //获取到报修对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=repair.getRepairId() %></td>
 											<td><%=repair.getOwnerObj().getOwnerName() %></td>
 											<td><%=repair.getRepairDate() %></td>
 											<td><%=repair.getQuestionDesc() %></td>
 											<td><%=repair.getRepairState() %></td>
 											<td><%=repair.getHandleResult() %></td>
 											<td>
 												<a href="<%=basePath  %>Repair/<%=repair.getRepairId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="repairEdit('<%=repair.getRepairId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="repairDelete('<%=repair.getRepairId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>报修查询</h1>
		</div>
		<form name="repairQueryForm" id="repairQueryForm" action="<%=basePath %>Repair/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="ownerObj_ownerId">报修用户：</label>
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
				<label for="repairDate">报修日期:</label>
				<input type="text" id="repairDate" name="repairDate" class="form-control"  placeholder="请选择报修日期" value="<%=repairDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="questionDesc">问题描述:</label>
				<input type="text" id="questionDesc" name="questionDesc" value="<%=questionDesc %>" class="form-control" placeholder="请输入问题描述">
			</div>






			<div class="form-group">
				<label for="repairState">报修状态:</label>
				<input type="text" id="repairState" name="repairState" value="<%=repairState %>" class="form-control" placeholder="请输入报修状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="repairEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;报修信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date repair_repairDate_edit col-md-12" data-link-field="repair_repairDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#repairEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxRepairModify();">提交</button>
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
    document.repairQueryForm.currentPage.value = currentPage;
    document.repairQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.repairQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.repairQueryForm.currentPage.value = pageValue;
    documentrepairQueryForm.submit();
}

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
				$('#repairEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除报修信息*/
function repairDelete(repairId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Repair/deletes",
			data : {
				repairIds : repairId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#repairQueryForm").submit();
					//location.href= basePath + "Repair/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

