<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>学生成绩管理</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="<s:url value='/admin/layui/css/layui.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/font_eolqem241z66flxr.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/news.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/font-awesome-4.7.0/css/font-awesome.css' />" media="all" />
</head>
<style>
	.score{
		border:unset;
		text-align:center;
		padding: 5px;
		filter:alpha(opacity=50);  
        -moz-opacity:0.5;  
        -khtml-opacity: 0.5;  
        opacity: 0.5;
        color:blcak;  
	}
	.score:focus{
		 filter:alpha(opacity=50);  
      -moz-opacity:0.5;  
      -khtml-opacity: 0.5;  
      opacity: 0.5;  
	}
</style>
<body class="childrenBody">
	<input type="hidden" id="id">
	<blockquote class="layui-elem-quote news_search">
		<div class="layui-inline">
		    <div class="layui-input-inline">
		    	<input type="text" value="" placeholder="请输入关键字" class="layui-input search_input">
		    </div>
		    <a class="layui-btn search_btn">查询</a>
		</div>
	</blockquote>
	<div class="layui-form news_list">
	  	<table class="layui-table">
		    <colgroup>
				<col width="10%">
				<col width="20%">
				<col width="10%">
				<col width="20%">
				<col width="20%">
				<col width="10%">
		    </colgroup>
		    <thead>
				<tr>
					<th><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" id="allChoose"></th>
					<th>学号</th>
					<th>姓名</th>
					<th>专业</th>
					<th>课程</th>
					<th>成绩</th>
				</tr> 
		    </thead>
		    <tbody class="news_content"></tbody>
		</table>
	</div>
	<div id="page"></div>
	<script type="text/javascript" src="<s:url value='/admin/js/jquery.min.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/page/score/studentInfoList.js' />"></script>
	<script>
	
	function LoadData(){
		var newsData = '';
		$.get("/shangcheng/studentInfo/list", function(data){
	        	newsList(data);

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
			    	+'<td>'+currData[i].stu_id+'</td>'
			    	+'<td>'+currData[i].stu_name+'</td>'
			    	+'<td>'+currData[i].sex+'</td>'
			    	+'<td>'+currData[i].major+'</td>'
			    	+'<td>'+currData[i].password+'</td>'
			    	+'<td>'
			    	+  '<a class="layui-btn layui-btn-normal layui-btn-mini stu_view" data-id="'+data[i].id+'"><i class="layui-icon">&#xe60b;</i> 详细</a>'
					+  '<a class="layui-btn layui-btn-mini stu_edit" data-id="'+data[i].id+'"><i class="iconfont icon-edit" ></i> 编辑</a>'
					+  '<a class="layui-btn layui-btn-danger layui-btn-mini stu_del" data-id="'+data[i].id+'"><i class="layui-icon">&#xe640;</i> 删除</a>'
					+  '<a class="layui-btn layui-btn-warm layui-btn-mini stu_course" data-id="'+data[i].id+'"><i class="layui-icon">&#xe63c;</i> 课程</a>'
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
	function getParamer(paramer){

		  var url=window.location.href.split("?")[1];            /*获取url里"?"后面的值*/
		  if(url.indexOf("&")>0){                                      /*判断是否是一个参数还是多个参数*/
		     urlParamArry=url.split("&");                            /*分开每个参数，并放到数组里*/
		     for(var i=0; i<urlParamArry.length; i++){
		     var paramerName=urlParamArry[i].split("=");   /*把每个参数名和值分开，并放到数组里*/
		     if(paramer==paramerName[0]){                     /*匹配输入的参数和数组循环出来的参数是否一样*/
		          return paramerName[1];                           /*返回想要的参数值*/
		     }
		  }
		}else{                                                              /*判断只有个参数*/
		   var paramerValue=url.split("=")[1];
		   return paramerValue;
		  }

		}
	$("#id").val(getParamer("id"));
	function saveorupdate(object){
		var score = $($(object)["0"].parentNode.parentNode).find(".score").val();
		if(parseInt(score)>100){
			layer.msg('请重新输入，得分必须小于100分', {icon: 5});
			$($(object)["0"].parentNode.parentNode).find(".score").val("");
			return;
		}else if(parseInt(score)<0){
			layer.msg('请重新输入，得分必须大于0分', {icon: 5});
		}else{
			var id = $($(object)["0"].parentNode.parentNode).find(".id").attr("data-id");
			var stu_id = $($(object)["0"].parentNode.parentNode).find(".stu_id").html();
			var stu_name = $($(object)["0"].parentNode.parentNode).find(".stu_name").html();
			var course_name = $($(object)["0"].parentNode.parentNode).find(".course_name").html();
			var course_id = $($(object)["0"].parentNode.parentNode).find(".course_id").html();
			var tch_id = $(".userName",window.parent.document).val();
			var tch_name = $(".name",window.parent.document).html();
			$.ajax({
				"url":"<s:url value='/score/save' />",
				"data":{
					"id":id,
					"score.stu_id":stu_id,
					"score.stu_name":stu_name,
					"score.course_name":course_name,
					"score.course_id":course_id,
					"score.score":score,
					"score.tch_id":tch_id,
					"score.tch_name":tch_name
					},
				"success":function(data){
						layer.msg(data.msg, {icon: 6});
				}
			})
		}
		
	}
	
	</script>
</body>
</html>