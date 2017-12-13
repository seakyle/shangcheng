<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>模块添加</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="<s:url value='/admin/layui/css/layui.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/font_eolqem241z66flxr.css' />" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" action="<s:url value='/Navs/save' />">
	<input type="hidden" name="id" value="<s:property value='nav.id' />">
		<div class="layui-form-item">
			<label class="layui-form-label">模块标题</label>
			<div class="layui-input-block">
				<input type="text" name="nav.title" class="layui-input newsName" lay-verify="required" placeholder="请输入模块标题" value="<s:property value='nav.title' />">
			</div>
		</div>
		<div class="layui-form-item">
			
			<div class="layui-inline">		
				<label class="layui-form-label">模块图标</label>
				<div class="layui-input-inline">
					<input type="text"  name="nav.icon" class="layui-input newsAuthor" lay-verify="required" placeholder="请输入模块图标"  value="<s:property value='nav.icon' />">
				</div>
			</div>
			
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">父模块</label>
				<div class="layui-input-inline">
					<select name="parentId" class="parentNode" lay-filter="browseLook" value="<s:property value='nav.parentId' />">
				        <option value=""></option>
				    </select>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">节点状态</label>
				<div class="layui-input-inline">
					<select name="nav.spread" class="spread" lay-filter="browseLook"  value="<s:property value='nav.spread' />">
				        <option value="false">关闭</option>
				        <option value="true">打开</option>
				    </select>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">模块链接</label>
			<div class="layui-input-block">
				<input type="text" name="nav.href" class="layui-input newsName" lay-verify="required" placeholder="请输入模块链接" value="<s:property value='nav.href' />">
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="addNews">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	</form>
	
	<script type="text/javascript" src="<s:url value='/admin/js/jquery-3.2.1.min.js' />"></script>
	<script>
$.ajax({
	"url":"<s:url value='/Navs/findAll' />",
	"async":false,  
	 "success":function(data){
		 $(".parentNode").html("");
		 var html="<option value='0'>无</option>";
		 for(var i = 0;i<data.length;i++){
			if(data[i].id == $(".parentNode").attr("value")){
				html +="<option value='"+data[i].id+"' selected='true'>"+data[i].title+"</option>";
			}else{
				html +="<option value='"+data[i].id+"'>"+data[i].title+"</option>";
			}
			
		 }
		 $(".parentNode").append(html);
	 }
});
var option = $(".spread option");
for(var i = 0;i<option.length;i++){
	if(option[i].value == $(".spread").attr("value")){
		option[i].selected=true;
	}
}
</script>
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/page/dictionary/dictionaryAdd.js' />"></script>
</body>

</html>