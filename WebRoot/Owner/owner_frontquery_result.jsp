<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Owner" %>
<%@ page import="com.chengxusheji.po.Building" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Owner> ownerList = (List<Owner>)request.getAttribute("ownerList");
    //获取所有的buildingObj信息
    List<Building> buildingList = (List<Building>)request.getAttribute("buildingList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Building buildingObj = (Building)request.getAttribute("buildingObj");
    String roomNo = (String)request.getAttribute("roomNo"); //房间号查询关键字
    String ownerName = (String)request.getAttribute("ownerName"); //户主查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系方式查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>业主查询</title>
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
			    	<li role="presentation" class="active"><a href="#ownerListPanel" aria-controls="ownerListPanel" role="tab" data-toggle="tab">业主列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Owner/owner_frontAdd.jsp" style="display:none;">添加业主</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="ownerListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>业主id</td><td>楼栋名称</td><td>房间号</td><td>户主</td><td>房屋面积</td><td>联系方式</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<ownerList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Owner owner = ownerList.get(i); //获取到业主对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=owner.getOwnerId() %></td>
 											<td><%=owner.getBuildingObj().getBuildingName() %></td>
 											<td><%=owner.getRoomNo() %></td>
 											<td><%=owner.getOwnerName() %></td>
 											<td><%=owner.getArea() %></td>
 											<td><%=owner.getTelephone() %></td>
 											<td>
 												<a href="<%=basePath  %>Owner/<%=owner.getOwnerId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="ownerEdit('<%=owner.getOwnerId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="ownerDelete('<%=owner.getOwnerId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>业主查询</h1>
		</div>
		<form name="ownerQueryForm" id="ownerQueryForm" action="<%=basePath %>Owner/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="buildingObj_buildingId">楼栋名称：</label>
                <select id="buildingObj_buildingId" name="buildingObj.buildingId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Building buildingTemp:buildingList) {
	 					String selected = "";
 					if(buildingObj!=null && buildingObj.getBuildingId()!=null && buildingObj.getBuildingId().intValue()==buildingTemp.getBuildingId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=buildingTemp.getBuildingId() %>" <%=selected %>><%=buildingTemp.getBuildingName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="roomNo">房间号:</label>
				<input type="text" id="roomNo" name="roomNo" value="<%=roomNo %>" class="form-control" placeholder="请输入房间号">
			</div>






			<div class="form-group">
				<label for="ownerName">户主:</label>
				<input type="text" id="ownerName" name="ownerName" value="<%=ownerName %>" class="form-control" placeholder="请输入户主">
			</div>






			<div class="form-group">
				<label for="telephone">联系方式:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入联系方式">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="ownerEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;业主信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="ownerEditForm" id="ownerEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="owner_ownerId_edit" class="col-md-3 text-right">业主id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="owner_ownerId_edit" name="owner.ownerId" class="form-control" placeholder="请输入业主id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="owner_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_password_edit" name="owner.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_buildingObj_buildingId_edit" class="col-md-3 text-right">楼栋名称:</label>
		  	 <div class="col-md-9">
			    <select id="owner_buildingObj_buildingId_edit" name="owner.buildingObj.buildingId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_roomNo_edit" class="col-md-3 text-right">房间号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_roomNo_edit" name="owner.roomNo" class="form-control" placeholder="请输入房间号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_ownerName_edit" class="col-md-3 text-right">户主:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_ownerName_edit" name="owner.ownerName" class="form-control" placeholder="请输入户主">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_area_edit" class="col-md-3 text-right">房屋面积:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_area_edit" name="owner.area" class="form-control" placeholder="请输入房屋面积">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_telephone_edit" class="col-md-3 text-right">联系方式:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="owner_telephone_edit" name="owner.telephone" class="form-control" placeholder="请输入联系方式">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="owner_memo_edit" class="col-md-3 text-right">备注信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="owner_memo_edit" name="owner.memo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#ownerEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxOwnerModify();">提交</button>
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
    document.ownerQueryForm.currentPage.value = currentPage;
    document.ownerQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.ownerQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.ownerQueryForm.currentPage.value = pageValue;
    documentownerQueryForm.submit();
}

/*弹出修改业主界面并初始化数据*/
function ownerEdit(ownerId) {
	$.ajax({
		url :  basePath + "Owner/" + ownerId + "/update",
		type : "get",
		dataType: "json",
		success : function (owner, response, status) {
			if (owner) {
				$("#owner_ownerId_edit").val(owner.ownerId);
				$("#owner_password_edit").val(owner.password);
				$.ajax({
					url: basePath + "Building/listAll",
					type: "get",
					success: function(buildings,response,status) { 
						$("#owner_buildingObj_buildingId_edit").empty();
						var html="";
		        		$(buildings).each(function(i,building){
		        			html += "<option value='" + building.buildingId + "'>" + building.buildingName + "</option>";
		        		});
		        		$("#owner_buildingObj_buildingId_edit").html(html);
		        		$("#owner_buildingObj_buildingId_edit").val(owner.buildingObjPri);
					}
				});
				$("#owner_roomNo_edit").val(owner.roomNo);
				$("#owner_ownerName_edit").val(owner.ownerName);
				$("#owner_area_edit").val(owner.area);
				$("#owner_telephone_edit").val(owner.telephone);
				$("#owner_memo_edit").val(owner.memo);
				$('#ownerEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除业主信息*/
function ownerDelete(ownerId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Owner/deletes",
			data : {
				ownerIds : ownerId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#ownerQueryForm").submit();
					//location.href= basePath + "Owner/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交业主信息表单给服务器端修改*/
function ajaxOwnerModify() {
	$.ajax({
		url :  basePath + "Owner/" + $("#owner_ownerId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#ownerEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#ownerQueryForm").submit();
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

