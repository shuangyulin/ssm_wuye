<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Parking" %>
<%@ page import="com.chengxusheji.po.Owner" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Parking> parkingList = (List<Parking>)request.getAttribute("parkingList");
    //获取所有的ownerObj信息
    List<Owner> ownerList = (List<Owner>)request.getAttribute("ownerList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String parkingName = (String)request.getAttribute("parkingName"); //车位名称查询关键字
    String plateNumber = (String)request.getAttribute("plateNumber"); //车牌号查询关键字
    Owner ownerObj = (Owner)request.getAttribute("ownerObj");
    String opUser = (String)request.getAttribute("opUser"); //操作员查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>停车位查询</title>
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
			    	<li role="presentation" class="active"><a href="#parkingListPanel" aria-controls="parkingListPanel" role="tab" data-toggle="tab">停车位列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Parking/parking_frontAdd.jsp" style="display:none;">添加停车位</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="parkingListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>车位id</td><td>车位名称</td><td>车牌号</td><td>车主</td><td>操作员</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<parkingList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Parking parking = parkingList.get(i); //获取到停车位对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=parking.getParkingId() %></td>
 											<td><%=parking.getParkingName() %></td>
 											<td><%=parking.getPlateNumber() %></td>
 											<td><%=parking.getOwnerObj().getOwnerName() %></td>
 											<td><%=parking.getOpUser() %></td>
 											<td>
 												<a href="<%=basePath  %>Parking/<%=parking.getParkingId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="parkingEdit('<%=parking.getParkingId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="parkingDelete('<%=parking.getParkingId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>停车位查询</h1>
		</div>
		<form name="parkingQueryForm" id="parkingQueryForm" action="<%=basePath %>Parking/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="parkingName">车位名称:</label>
				<input type="text" id="parkingName" name="parkingName" value="<%=parkingName %>" class="form-control" placeholder="请输入车位名称">
			</div>






			<div class="form-group">
				<label for="plateNumber">车牌号:</label>
				<input type="text" id="plateNumber" name="plateNumber" value="<%=plateNumber %>" class="form-control" placeholder="请输入车牌号">
			</div>






            <div class="form-group">
            	<label for="ownerObj_ownerId">车主：</label>
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
				<label for="opUser">操作员:</label>
				<input type="text" id="opUser" name="opUser" value="<%=opUser %>" class="form-control" placeholder="请输入操作员">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="parkingEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;停车位信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="parkingEditForm" id="parkingEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="parking_parkingId_edit" class="col-md-3 text-right">车位id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="parking_parkingId_edit" name="parking.parkingId" class="form-control" placeholder="请输入车位id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="parking_parkingName_edit" class="col-md-3 text-right">车位名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="parking_parkingName_edit" name="parking.parkingName" class="form-control" placeholder="请输入车位名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="parking_plateNumber_edit" class="col-md-3 text-right">车牌号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="parking_plateNumber_edit" name="parking.plateNumber" class="form-control" placeholder="请输入车牌号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="parking_ownerObj_ownerId_edit" class="col-md-3 text-right">车主:</label>
		  	 <div class="col-md-9">
			    <select id="parking_ownerObj_ownerId_edit" name="parking.ownerObj.ownerId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="parking_opUser_edit" class="col-md-3 text-right">操作员:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="parking_opUser_edit" name="parking.opUser" class="form-control" placeholder="请输入操作员">
			 </div>
		  </div>
		</form> 
	    <style>#parkingEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxParkingModify();">提交</button>
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
    document.parkingQueryForm.currentPage.value = currentPage;
    document.parkingQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.parkingQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.parkingQueryForm.currentPage.value = pageValue;
    documentparkingQueryForm.submit();
}

/*弹出修改停车位界面并初始化数据*/
function parkingEdit(parkingId) {
	$.ajax({
		url :  basePath + "Parking/" + parkingId + "/update",
		type : "get",
		dataType: "json",
		success : function (parking, response, status) {
			if (parking) {
				$("#parking_parkingId_edit").val(parking.parkingId);
				$("#parking_parkingName_edit").val(parking.parkingName);
				$("#parking_plateNumber_edit").val(parking.plateNumber);
				$.ajax({
					url: basePath + "Owner/listAll",
					type: "get",
					success: function(owners,response,status) { 
						$("#parking_ownerObj_ownerId_edit").empty();
						var html="";
		        		$(owners).each(function(i,owner){
		        			html += "<option value='" + owner.ownerId + "'>" + owner.ownerName + "</option>";
		        		});
		        		$("#parking_ownerObj_ownerId_edit").html(html);
		        		$("#parking_ownerObj_ownerId_edit").val(parking.ownerObjPri);
					}
				});
				$("#parking_opUser_edit").val(parking.opUser);
				$('#parkingEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除停车位信息*/
function parkingDelete(parkingId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Parking/deletes",
			data : {
				parkingIds : parkingId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#parkingQueryForm").submit();
					//location.href= basePath + "Parking/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交停车位信息表单给服务器端修改*/
function ajaxParkingModify() {
	$.ajax({
		url :  basePath + "Parking/" + $("#parking_parkingId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#parkingEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#parkingQueryForm").submit();
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

