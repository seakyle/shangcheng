<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>字典管理</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="<s:url value='/admin/layui/css/layui.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/font_eolqem241z66flxr.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/news.css' />" media="all" />
	<style>
		#demo{
			display: block;
			float:left;
			width: 50%;
		}
		.add{
			display:block;
			float:left;
		}
		.news_list{
			padding: 20px;
		}
		.layui-btn-xs{
			height: 30px;
    		line-height: 30px;
    		padding: 0 8px;
    		margin-top: 3px;
		}
	</style>
</head>
<body class="childrenBody">
	<blockquote class="layui-elem-quote news_search">
		<div class="layui-inline">
		    <div class="layui-input-inline">
		    	<input type="text" value="" placeholder="请输入关键字" class="layui-input search_input">
		    </div>
		    <a class="layui-btn search_btn">查询</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn layui-btn-normal newsAdd_btn">添加模块</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn recommend" style="background-color:#5FB878">推荐文章</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn audit_btn">审核文章</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn layui-btn-danger batchDel">批量删除</a>
		</div>
		
	</blockquote>
	 
	<div class="layui-form news_list">
	  	<ul id="demo"></ul>
	  	<div class="add" style="display:none;">
		<form class="layui-form" url="<s:url value='/dictionary/save' />">
		<input type="hidden" name="id" class="dictionaryId">
		<input type="hidden" name="dictionary.level" class="dictionaryLevel">
		<div class="layui-form-item">
			<label class="layui-form-label">名称</label>
			<div class="layui-input-inline">
				<input type="text" name="dictionary.name" class="layui-input dictionaryName" lay-verify="required" placeholder="请输入名称">
				 
			</div>
			<button class="layui-btn layui-btn-xs">
   			 		<i class="layui-icon">&#xe654;</i>
  				</button>
		</div>
		<div class="layui-form-item">
			
			<div class="layui-inline">		
				<label class="layui-form-label">编码</label>
				<div class="layui-input-inline">
					<input type="text"  name="dictionary.code" class="layui-input dictionaryCode" lay-verify="required" placeholder="请输入编码" >
				</div>
			</div>
			
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">父节点</label>
				<div class="layui-input-inline">
					<input type="text"  name="parentId" class="layui-input parentNode" lay-verify="required" placeholder="请输入父节点" >
					<input type="hidden" name="dictionary.parentId" class="parentId">
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn submit" lay-submit="" lay-filter="addNews">保存节点</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				<button class="layui-btn layui-btn-danger delete">删除节点</button>
		    </div>
		</div>
	</form>
	</div>
	</div>
	

	<div id="page"></div>
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/page/dictionary/dictionaryList.js' />"></script>
	
</body>
</html>