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
		.layui-upload-button{
			left: 24px;
		}
	</style>
</head>

<body class="childrenBody">
	<form class="layui-form"  id="userInfoform" action="<s:url value='/Admin/save' />" method="post">
	<input type="hidden" name="id" value="<s:property value='admin.id' />">
		<div class="user_left">
			<div class="layui-form-item">
			    <label class="layui-form-label">用户名</label>
			    <div class="layui-input-block">
			    	<input type="text" class="layui-input newsName" value="<s:property value='admin.name' />" lay-verify="required" placeholder="请输入用户名" name="admin.name">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">真实姓名</label>
			    <div class="layui-input-block">
			    	<input type="text" class="layui-input newsName" value="<s:property value='admin.realname' />" lay-verify="required" placeholder="请输入真实姓名" name="admin.realname">
			    </div>
			</div>
		<div class="layui-form-item">
				<label class="layui-form-label">性别</label>
			    <div class="layui-input-block sexDiv" value="<s:property value='admin.sex' />">
			    	<input type="radio" name="admin.sex" value="男" title="男" class="sex">
	     			<input type="radio" name="admin.sex" value="女" title="女" class="sex" >
	     			<input type="radio" name="admin.sex" value="保密" title="保密" class="sex">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">手机号码</label>
			    <div class="layui-input-block">
			    	<input type="text" class="layui-input newsName" value="<s:property value='admin.phonenum' />" lay-verify="required" placeholder="请输入手机号码" name="admin.phonenum">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">出生年月</label>
			    <div class="layui-input-block">
			    	<input type="text" value="<s:property value='admin.birthday' />" placeholder="请输入出生年月" lay-verify="required|date" onclick="layui.laydate({elem: this,max: laydate.now()})" class="layui-input" id="text1">
			    </div>
			</div>
			<input type="hidden" name="admin.address" class="address" value="<s:property value='admin.address' />" >
			<div class="layui-form-item">
			    <label class="layui-form-label">家庭住址</label>
			    <div class="layui-input-inline">
	                <select name="province" lay-filter="province" class="province">
	                    <option value="">请选择省</option>
	                </select>
	            </div>
	            <div class="layui-input-inline">
	                <select name="city" lay-filter="city" disabled>
	                    <option value="">请选择市</option>
	                </select>
	            </div>
	            <div class="layui-input-inline">
	                <select name="area" lay-filter="area" disabled>
	                    <option value="">请选择县/区</option>
	                </select>
	            </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">邮箱</label>
			    <div class="layui-input-block">
			    	<input type="text" value="<s:property value='admin.email' />" name="admin.email" placeholder="请输入邮箱" lay-verify="required|email" class="layui-input">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">自我评价</label>
			    <div class="layui-input-block">
			    	<textarea  placeholder="请输入自我评价" class="layui-textarea" name="admin.appraise"><s:property value='admin.appraise' /></textarea>
			    </div>
			</div>
		</div>
		<div class="user_right">
			<input type="file" name="dddd" class="layui-upload-file" lay-title="我要更换头像">
			<p></p>
			<img src="" class="layui-circle" id="userFace">
		</div>
		<div class="layui-form-item" style="margin-left: 5%;">
		    <div class="layui-input-block">
		    	<button class="layui-btn" lay-submit="" lay-filter="changeUser">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
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
	/* function sub(){
		  $("#userInfoform").ajaxSubmit(function(message) {   
		       console.log(message);
		   });   
		  return false;
	} */
	
</script>
</html>