<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>个人资料--layui后台管理模板</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="<s:url value='/admin/layui/css/layui.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/user.css' />" media="all" />
	<style type="text/css">
		.layui-form-item .layui-input-inline{
			width: 26%;
			margin-right: 9px;
		}
	</style>
</head>

<body class="childrenBody">
	<form class="layui-form"  id="userInfoform" action="<s:url value='/studentInfo/save' />" method="post">
	<input type="hidden" name="id" value="<s:property value='stu.id' />">
		<div class="user_left">
			<div class="layui-form-item">
			    <label class="layui-form-label">学生姓名</label>
			    <div class="layui-input-block">
			    	<input type="text" class="layui-input newsName" value="<s:property value='tch.tch_name' />" lay-verify="required" name="tch.tch_name">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">学生学号</label>
			    <div class="layui-input-block">
			    	<input type="text" class="layui-input newsName" lay-verify="required" value="<s:property value='tch.tch_id' />" name="tch.tch_id">
			    </div>
			</div>
		<div class="layui-form-item">
				<label class="layui-form-label">性别</label>
			    <div class="layui-input-block sexDiv" value="<s:property value='tch.sex' />"   style="pointer-events: none;">
			    	<input type="radio" name="tch.sex" value="男" title="男" class="sex">
	     			<input type="radio" name="tch.sex" value="女" title="女" class="sex">
	     			<input type="radio" name="tch.sex" value="保密" title="保密" class="sex">
			    </div>
			</div>
			
			<input type="hidden" name="stu.address" class="address" value="<s:property value='tch.address' />" >
			<div class="layui-form-item">
			    <label class="layui-form-label">家庭住址</label>
			    <div class="layui-input-inline"  style="pointer-events: none;">
	                <select name="province" lay-filter="province" class="province">
	                    <option value="">请选择省</option>
	                </select>
	            </div>
	            <div class="layui-input-inline" style="pointer-events: none;">
	                <select name="city" lay-filter="city" disabled>
	                    <option value="">请选择市</option>
	                </select>
	            </div>
	            <div class="layui-input-inline" style="margin-right: 0px; pointer-events: none;">
	                <select name="area" lay-filter="area" disabled>
	                    <option value="">请选择县/区</option>
	                </select>
	            </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">身份证号</label>
			    <div class="layui-input-block">
			    	<input type="text" class="layui-input" name="tch.tch_num" value="<s:property value='tch.tch_num' />">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">所属专业</label>
			    <div class="layui-input-block" style="pointer-events: none;">
			    	<select name="tch.major" lay-filter="major"  value="<s:property value='tch.major' />" class="major">
	                    <option value="">请选择教师所属专业</option>
	                </select>
			    </div>
			</div>
				<div class="layui-form-item">
			<label class="layui-form-label">密码</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="tch.password" value="<s:property value='tch.password' />">
			</div>
		</div>
		</div>
		<div class="user_right">
			
			<img src="" class="layui-circle" id="userFace" url="<s:url value='/Admin/upload'/>" imageSrc="<s:url value='/upload/' />">
			<input type="hidden" name="tch.image" value="<s:property value='tch.image' />" id="image">
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn close" lay-filter="close">关闭</button>
		    </div>
		</div>
	</form>
	<script type="text/javascript" src="<s:url value='/admin/js/jquery-3.2.1.min.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/page/user/address.js' /> "></script>
	<script type="text/javascript" src="<s:url value='/admin/page/user/user.js' /> "></script>
</body>
<script>
	var radio = $(".sex");
	for(var i = 0;i<radio.length;i++){
		if($(radio[i]).val() == $(".sexDiv").attr("value")){
			$(radio[i]).attr("checked","checked");
			break;
		}
	}
	var $layuiInput = $(".layui-input");
	$layuiInput.attr("readonly","true");
</script>
</html>