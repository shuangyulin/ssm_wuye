<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:include page="check_logstate.jsp"/>
 
<!DOCTYPE html>
<html>
<head>
<title>信息管理系统</title>
<meta charset="UTF-8" />
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="css/admin.css" />
</head>
<body class="easyui-layout">

<div data-options="region:'north',title:'header',split:true,noheader:true" style="height:60px;background-color:#01B1EA;">
	<div class="logo">XXX系统后台管理</div>
	<div class="logout">您好，<%=session.getAttribute("username")%> | <a href="logout">退出</a></div>
</div>   
<div data-options="region:'south',title:'footer',split:true,noheader:true" style="height:35px;line-height:30px;text-align:center;">
	&copy; Powered by dashen
</div>    
<div data-options="region:'west',title:'导航',split:true,iconCls:'icon-world'" style="width:200px;padding:10px;">
	<ul id="nav"></ul>
</div>   
<div data-options="region:'center'" style="overflow:hidden;">
	<div id="tabs">
		<div title="起始页" iconCls="icon-house" style="padding:0 10px;display:block;font-size:70px">
			<br/><br/> <center>欢迎来到后台管理系统！</center>
		</div>
	</div>
</div> 


<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js" ></script>
<script type="text/javascript" src="js/admin.js"></script>
</body>
</html>
