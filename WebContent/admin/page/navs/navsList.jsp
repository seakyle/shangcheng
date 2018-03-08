<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>模块管理</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="<s:url value='/admin/layui/css/layui.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/font_eolqem241z66flxr.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/news.css' />" media="all" />
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
			<a class="layui-btn layui-btn-danger batchDel">批量删除</a>
		</div>
		
	</blockquote>
	<div class="layui-form news_list">
	  	<table class="layui-table">
		    <colgroup>
				<col width="5%">
				<col width="6%">
				<col width="6%">
				<col width="5%">
				<col width="8%">
				<col width="10%">
		    </colgroup>
		    <thead>
				<tr>
					<th><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" id="allChoose"></th>
					<th>模块名称</th>
					<th>模块图标</th>
					<th>节点状态</th>
					<th>模块链接</th>
					<th>操作</th>
				</tr> 
		    </thead>
		    <tbody class="news_content"></tbody>
		</table>
	</div>
	<div id="page"></div>
	<script type="text/javascript" src="<s:url value='/admin/js/jquery.min.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/page/navs/navsList.js' />"></script>
	<script type="text/javascript">
	
	function LoadData(){
		var newsData = '';
		$.get("<s:url value='/Navs/list' />", function(data){
	        	newsData = data;
	        	newsList(newsData);
		})
	}
	function newsList(that){
		//渲染数据
		function renderDate(data,curr){
			var dataHtml = '';
			if(!that){
				currData = newsData.concat().splice(curr*nums-nums, nums);
			}else{
				currData = that.concat().splice(curr*nums-nums, nums);
			}
			if(currData.length != 0){
				for(var i=0;i<currData.length;i++){
					dataHtml += '<tr>'
			    	+'<td><input type="checkbox" name="checked" lay-skin="primary" lay-filter="choose" data-id="'+data[i].id+'"></td>'
			    	+'<td>'+currData[i].title+'</td>'
			    	+'<td>'+currData[i].icon+'</td>';
			    	if(currData[i].spread == "false"){
			    		dataHtml += '<td>关闭</td>';
			    	}else{
			    		dataHtml += '<td>打开</td>';
			    	}
			    	dataHtml += '<td>'+currData[i].href+'</td>'
			    	+'<td>'
					+  '<a class="layui-btn layui-btn-mini navs_edit" data-id="'+data[i].id+'"><i class="iconfont icon-edit"></i> 编辑</a>'
			    	+  '<a class="layui-btn layui-btn-normal layui-btn-mini nav_view" data-id="'+data[i].id+'"><i class="layui-icon">&#xe60b;</i> 详细</a>'
					+  '<a class="layui-btn layui-btn-danger layui-btn-mini news_del" data-id="'+data[i].id+'"><i class="layui-icon">&#xe640;</i> 删除</a>'
			        +'</td>'
			    	+'</tr>';
				}
			}else{
				dataHtml = '<tr><td colspan="8">暂无数据</td></tr>';
			}
		    return dataHtml;
		}
	//分页
	var nums = 10; //每页出现的数据量
	if(that){
		newsData = that;
	}
	layui.use('laypage', function(){
		  var laypage = layui.laypage;
	laypage({
		cont : "page",
		pages : Math.ceil(newsData.length/nums),
		jump : function(obj){
			$(".news_content").html(renderDate(newsData,obj.curr));
			$('.news_list thead input[type="checkbox"]').prop("checked",false);
		}
	})
	})
	}
	
	</script>
</body>
</html>