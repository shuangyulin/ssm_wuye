<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Salary" %>
<%@ page import="com.chengxusheji.po.Employee" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Salary> salaryList = (List<Salary>)request.getAttribute("salaryList");
    //获取所有的employeeObj信息
    List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Employee employeeObj = (Employee)request.getAttribute("employeeObj");
    String year = (String)request.getAttribute("year"); //工资年份查询关键字
    String month = (String)request.getAttribute("month"); //工资月份查询关键字
    String fafang = (String)request.getAttribute("fafang"); //是否发放查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>工资查询</title>
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
			    	<li role="presentation" class="active"><a href="#salaryListPanel" aria-controls="salaryListPanel" role="tab" data-toggle="tab">工资列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Salary/salary_frontAdd.jsp" style="display:none;">添加工资</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="salaryListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>工资id</td><td>员工</td><td>工资年份</td><td>工资月份</td><td>工资金额</td><td>是否发放</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<salaryList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Salary salary = salaryList.get(i); //获取到工资对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=salary.getSalaryId() %></td>
 											<td><%=salary.getEmployeeObj().getName() %></td>
 											<td><%=salary.getYear() %></td>
 											<td><%=salary.getMonth() %></td>
 											<td><%=salary.getSalaryMoney() %></td>
 											<td><%=salary.getFafang() %></td>
 											<td>
 												<a href="<%=basePath  %>Salary/<%=salary.getSalaryId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="salaryEdit('<%=salary.getSalaryId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="salaryDelete('<%=salary.getSalaryId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>工资查询</h1>
		</div>
		<form name="salaryQueryForm" id="salaryQueryForm" action="<%=basePath %>Salary/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="employeeObj_employeeNo">员工：</label>
                <select id="employeeObj_employeeNo" name="employeeObj.employeeNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Employee employeeTemp:employeeList) {
	 					String selected = "";
 					if(employeeObj!=null && employeeObj.getEmployeeNo()!=null && employeeObj.getEmployeeNo().equals(employeeTemp.getEmployeeNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=employeeTemp.getEmployeeNo() %>" <%=selected %>><%=employeeTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="year">工资年份:</label>
				<input type="text" id="year" name="year" value="<%=year %>" class="form-control" placeholder="请输入工资年份">
			</div>






			<div class="form-group">
				<label for="month">工资月份:</label>
				<input type="text" id="month" name="month" value="<%=month %>" class="form-control" placeholder="请输入工资月份">
			</div>






			<div class="form-group">
				<label for="fafang">是否发放:</label>
				<input type="text" id="fafang" name="fafang" value="<%=fafang %>" class="form-control" placeholder="请输入是否发放">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="salaryEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;工资信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="salaryEditForm" id="salaryEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="salary_salaryId_edit" class="col-md-3 text-right">工资id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="salary_salaryId_edit" name="salary.salaryId" class="form-control" placeholder="请输入工资id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="salary_employeeObj_employeeNo_edit" class="col-md-3 text-right">员工:</label>
		  	 <div class="col-md-9">
			    <select id="salary_employeeObj_employeeNo_edit" name="salary.employeeObj.employeeNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="salary_year_edit" class="col-md-3 text-right">工资年份:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="salary_year_edit" name="salary.year" class="form-control" placeholder="请输入工资年份">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="salary_month_edit" class="col-md-3 text-right">工资月份:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="salary_month_edit" name="salary.month" class="form-control" placeholder="请输入工资月份">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="salary_salaryMoney_edit" class="col-md-3 text-right">工资金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="salary_salaryMoney_edit" name="salary.salaryMoney" class="form-control" placeholder="请输入工资金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="salary_fafang_edit" class="col-md-3 text-right">是否发放:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="salary_fafang_edit" name="salary.fafang" class="form-control" placeholder="请输入是否发放">
			 </div>
		  </div>
		</form> 
	    <style>#salaryEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSalaryModify();">提交</button>
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
    document.salaryQueryForm.currentPage.value = currentPage;
    document.salaryQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.salaryQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.salaryQueryForm.currentPage.value = pageValue;
    documentsalaryQueryForm.submit();
}

/*弹出修改工资界面并初始化数据*/
function salaryEdit(salaryId) {
	$.ajax({
		url :  basePath + "Salary/" + salaryId + "/update",
		type : "get",
		dataType: "json",
		success : function (salary, response, status) {
			if (salary) {
				$("#salary_salaryId_edit").val(salary.salaryId);
				$.ajax({
					url: basePath + "Employee/listAll",
					type: "get",
					success: function(employees,response,status) { 
						$("#salary_employeeObj_employeeNo_edit").empty();
						var html="";
		        		$(employees).each(function(i,employee){
		        			html += "<option value='" + employee.employeeNo + "'>" + employee.name + "</option>";
		        		});
		        		$("#salary_employeeObj_employeeNo_edit").html(html);
		        		$("#salary_employeeObj_employeeNo_edit").val(salary.employeeObjPri);
					}
				});
				$("#salary_year_edit").val(salary.year);
				$("#salary_month_edit").val(salary.month);
				$("#salary_salaryMoney_edit").val(salary.salaryMoney);
				$("#salary_fafang_edit").val(salary.fafang);
				$('#salaryEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除工资信息*/
function salaryDelete(salaryId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Salary/deletes",
			data : {
				salaryIds : salaryId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#salaryQueryForm").submit();
					//location.href= basePath + "Salary/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交工资信息表单给服务器端修改*/
function ajaxSalaryModify() {
	$.ajax({
		url :  basePath + "Salary/" + $("#salary_salaryId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#salaryEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#salaryQueryForm").submit();
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

