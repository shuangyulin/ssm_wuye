<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Fee" %>
<%@ page import="com.chengxusheji.po.FeeType" %>
<%@ page import="com.chengxusheji.po.Owner" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Fee> feeList = (List<Fee>)request.getAttribute("feeList");
    //获取所有的feeTypeObj信息
    List<FeeType> feeTypeList = (List<FeeType>)request.getAttribute("feeTypeList");
    //获取所有的ownerObj信息
    List<Owner> ownerList = (List<Owner>)request.getAttribute("ownerList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    FeeType feeTypeObj = (FeeType)request.getAttribute("feeTypeObj");
    Owner ownerObj = (Owner)request.getAttribute("ownerObj");
    String feeDate = (String)request.getAttribute("feeDate"); //收费时间查询关键字
    String feeContent = (String)request.getAttribute("feeContent"); //收费内容查询关键字
    String opUser = (String)request.getAttribute("opUser"); //操作员查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>收费查询</title>
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
			    	<li role="presentation" class="active"><a href="#feeListPanel" aria-controls="feeListPanel" role="tab" data-toggle="tab">收费列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Fee/fee_frontAdd.jsp" style="display:none;">添加收费</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="feeListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>费用id</td><td>费用类别</td><td>住户信息</td><td>收费时间</td><td>收费金额</td><td>收费内容</td><td>操作员</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<feeList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Fee fee = feeList.get(i); //获取到收费对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=fee.getFeeId() %></td>
 											<td><%=fee.getFeeTypeObj().getTypeName() %></td>
 											<td><%=fee.getOwnerObj().getOwnerName() %></td>
 											<td><%=fee.getFeeDate() %></td>
 											<td><%=fee.getFeeMoney() %></td>
 											<td><%=fee.getFeeContent() %></td>
 											<td><%=fee.getOpUser() %></td>
 											<td>
 												<a href="<%=basePath  %>Fee/<%=fee.getFeeId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="feeEdit('<%=fee.getFeeId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="feeDelete('<%=fee.getFeeId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>收费查询</h1>
		</div>
		<form name="feeQueryForm" id="feeQueryForm" action="<%=basePath %>Fee/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="feeTypeObj_typeId">费用类别：</label>
                <select id="feeTypeObj_typeId" name="feeTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(FeeType feeTypeTemp:feeTypeList) {
	 					String selected = "";
 					if(feeTypeObj!=null && feeTypeObj.getTypeId()!=null && feeTypeObj.getTypeId().intValue()==feeTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=feeTypeTemp.getTypeId() %>" <%=selected %>><%=feeTypeTemp.getTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="ownerObj_ownerId">住户信息：</label>
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
				<label for="feeDate">收费时间:</label>
				<input type="text" id="feeDate" name="feeDate" class="form-control"  placeholder="请选择收费时间" value="<%=feeDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="feeContent">收费内容:</label>
				<input type="text" id="feeContent" name="feeContent" value="<%=feeContent %>" class="form-control" placeholder="请输入收费内容">
			</div>






			<div class="form-group">
				<label for="opUser">操作员:</label>
				<input type="text" id="opUser" name="opUser" value="<%=opUser %>" class="form-control" placeholder="请输入操作员">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="feeEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;收费信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date fee_feeDate_edit col-md-12" data-link-field="fee_feeDate_edit"  data-link-format="yyyy-mm-dd">
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
		</form> 
	    <style>#feeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxFeeModify();">提交</button>
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
    document.feeQueryForm.currentPage.value = currentPage;
    document.feeQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.feeQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.feeQueryForm.currentPage.value = pageValue;
    documentfeeQueryForm.submit();
}

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
				$('#feeEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除收费信息*/
function feeDelete(feeId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Fee/deletes",
			data : {
				feeIds : feeId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#feeQueryForm").submit();
					//location.href= basePath + "Fee/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

