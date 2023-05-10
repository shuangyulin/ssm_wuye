<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Facility" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Facility> facilityList = (List<Facility>)request.getAttribute("facilityList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String name = (String)request.getAttribute("name"); //设施名称查询关键字
    String startTime = (String)request.getAttribute("startTime"); //开始使用时间查询关键字
    String facilityState = (String)request.getAttribute("facilityState"); //设施状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>设施查询</title>
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
			    	<li role="presentation" class="active"><a href="#facilityListPanel" aria-controls="facilityListPanel" role="tab" data-toggle="tab">设施列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Facility/facility_frontAdd.jsp" style="display:none;">添加设施</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="facilityListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>设施id</td><td>设施名称</td><td>数量</td><td>开始使用时间</td><td>设施状态</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<facilityList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Facility facility = facilityList.get(i); //获取到设施对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=facility.getFacilityId() %></td>
 											<td><%=facility.getName() %></td>
 											<td><%=facility.getCount() %></td>
 											<td><%=facility.getStartTime() %></td>
 											<td><%=facility.getFacilityState() %></td>
 											<td>
 												<a href="<%=basePath  %>Facility/<%=facility.getFacilityId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="facilityEdit('<%=facility.getFacilityId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="facilityDelete('<%=facility.getFacilityId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>设施查询</h1>
		</div>
		<form name="facilityQueryForm" id="facilityQueryForm" action="<%=basePath %>Facility/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="name">设施名称:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入设施名称">
			</div>






			<div class="form-group">
				<label for="startTime">开始使用时间:</label>
				<input type="text" id="startTime" name="startTime" class="form-control"  placeholder="请选择开始使用时间" value="<%=startTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="facilityState">设施状态:</label>
				<input type="text" id="facilityState" name="facilityState" value="<%=facilityState %>" class="form-control" placeholder="请输入设施状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="facilityEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;设施信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="facilityEditForm" id="facilityEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="facility_facilityId_edit" class="col-md-3 text-right">设施id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="facility_facilityId_edit" name="facility.facilityId" class="form-control" placeholder="请输入设施id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="facility_name_edit" class="col-md-3 text-right">设施名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="facility_name_edit" name="facility.name" class="form-control" placeholder="请输入设施名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="facility_count_edit" class="col-md-3 text-right">数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="facility_count_edit" name="facility.count" class="form-control" placeholder="请输入数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="facility_startTime_edit" class="col-md-3 text-right">开始使用时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date facility_startTime_edit col-md-12" data-link-field="facility_startTime_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="facility_startTime_edit" name="facility.startTime" size="16" type="text" value="" placeholder="请选择开始使用时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="facility_facilityState_edit" class="col-md-3 text-right">设施状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="facility_facilityState_edit" name="facility.facilityState" class="form-control" placeholder="请输入设施状态">
			 </div>
		  </div>
		</form> 
	    <style>#facilityEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxFacilityModify();">提交</button>
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
    document.facilityQueryForm.currentPage.value = currentPage;
    document.facilityQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.facilityQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.facilityQueryForm.currentPage.value = pageValue;
    documentfacilityQueryForm.submit();
}

/*弹出修改设施界面并初始化数据*/
function facilityEdit(facilityId) {
	$.ajax({
		url :  basePath + "Facility/" + facilityId + "/update",
		type : "get",
		dataType: "json",
		success : function (facility, response, status) {
			if (facility) {
				$("#facility_facilityId_edit").val(facility.facilityId);
				$("#facility_name_edit").val(facility.name);
				$("#facility_count_edit").val(facility.count);
				$("#facility_startTime_edit").val(facility.startTime);
				$("#facility_facilityState_edit").val(facility.facilityState);
				$('#facilityEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除设施信息*/
function facilityDelete(facilityId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Facility/deletes",
			data : {
				facilityIds : facilityId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#facilityQueryForm").submit();
					//location.href= basePath + "Facility/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交设施信息表单给服务器端修改*/
function ajaxFacilityModify() {
	$.ajax({
		url :  basePath + "Facility/" + $("#facility_facilityId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#facilityEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#facilityQueryForm").submit();
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

    /*开始使用时间组件*/
    $('.facility_startTime_edit').datetimepicker({
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

