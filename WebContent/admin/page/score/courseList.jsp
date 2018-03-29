<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>学生信息管理</title>
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
	<style type="text/css">
		.grid {
 			position: relative;
 			margin: 0 auto;
		}
		.grid-item {
			 position: absolute;
			 height:200px;
			 
			 border:1px solid #828282;
			 width:20%;
			 text-align:center;
			 border-radius: 5px;
			 opacity: 0;
			 background-color: #ffffff;
		   	 box-shadow: 1px 1px #9E9E9E;
		   	 padding-top: 15px;
    		padding-bottom: 15px;
		}
		.images{
			width:60%;
			margin-bottom: 20px;
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
	</blockquote>
	<div class="grid">
 		
	</div>
	<div id="page"></div>
	<script type="text/javascript" src="<s:url value='/admin/js/dynamics.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/js/minigrid.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/js/jquery.min.js' />"></script>
	
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
<%-- 	<script type="text/javascript" src="<s:url value='/admin/page/course/courseList.js' />"></script> --%>
	<script type="text/javascript">
	var teacher;
	if($('.userName', window.parent.document).val() == "admin"){
		teacher = "0"
	}else{
		teacher = $('.id', window.parent.document).val();
	}
	$.ajax({
		"url":'<s:url value="/course/findCourseByTeacher" />',
		"data":{"teacher":teacher},
		"async": false,
		"success":function(data){
			var html = "";
			var imagePath = "<s:url value='/upload/'/>"
			var href = "<s:url value='/admin/page/score/studentInfoList.jsp'/>"
			for(var i= 0;i<data.length;i++){
				html+="<a href='"+href+"?id="+data[i].id+"' class='studentList'><div class='grid-item'><img class='images' src='"+imagePath+data[i].image+"'><br>"+data[i].course_name+"<br>"+data[i].course_credits+"</div></a>"
			}
			$(".grid").append(html);
		}
	});
	 (function(){
		 function animate(item, x, y, index) {
		   dynamics.animate(item, {
		     translateX: x,
		     translateY: y,
		     opacity: 1
		    }, {
		      type: dynamics.spring,
		      duration: 800,
		      frequency: 120,
		      delay: 100 + index * 30
		    });
		  }
		  minigrid('.grid', '.grid-item', 60, animate);
		 
		  window.addEventListener('resize', function(){
			    minigrid('.grid', '.grid-item', 60, animate);
			  });
		})();
	
	</script>
</body>
</html>