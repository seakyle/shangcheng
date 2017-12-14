<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>课程信息添加</title>
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
	<form class="layui-form" action="<s:url value='/course/save' />">
	<input type="hidden" name="id" value="<s:property value='course.id' />">
		<div class="layui-form-item">
			<label class="layui-form-label">课程编号</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input newsName" value="<s:property value='course.course_id' />" lay-verify="required" placeholder="请输入课程编号" name="course.course_id">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">课程名称</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input newsName" lay-verify="required" value="<s:property value='course.course_name' />" placeholder="请输入课程名称" name="course.course_name">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">课程学分</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input newsName" value="<s:property value='course.course_credits' />" lay-verify="required" placeholder="请输入课程学分" name="course.course_credits">
			</div>
		</div>
		<div class="layui-form-item layui-form-text">
    		<label class="layui-form-label">课程描述</label>
    		<div class="layui-input-block">
      			<textarea  placeholder="请输入课程描述" class="layui-textarea" name="course.course_description"><s:property value='course.course_description' /></textarea>
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
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/page/course/courseAdd.js' />"></script>
</body>
</html>