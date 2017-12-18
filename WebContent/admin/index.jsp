<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>学生信息管理系统</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="icon" href="<s:url value='/admin/favicon.ico' />">
<link rel="stylesheet"
	href="<s:url value='/admin/layui/css/layui.css' />" media="all" />
<link rel="stylesheet"
	href="<s:url value='/admin/css/font_eolqem241z66flxr.css' />"
	media="all" />
<link rel="stylesheet" href="<s:url value='/admin/css/main.css' />"
	media="all" />
<link rel="stylesheet"
	href="<s:url value='/admin/css/font-awesome-4.7.0/css/font-awesome.css' />"
	media="all" />
</head>
<body class="main_body">
	<div class="layui-layout layui-layout-admin">
		<!-- 顶部 -->
		<div class="layui-header header">
			<div class="layui-main">
				<a href="#" class="logo">学生信息后台管理</a>
				<!-- 搜索 -->
				<div class="layui-form component">
					<select name="modules" lay-verify="required" lay-search="">
						<option value="">直接选择或搜索选择</option>
						<option value="1">layer</option>
						<option value="2">form</option>
						<option value="3">layim</option>
						<option value="4">element</option>
						<option value="5">laytpl</option>
						<option value="6">upload</option>
						<option value="7">laydate</option>
						<option value="8">laypage</option>
						<option value="9">flow</option>
						<option value="10">util</option>
						<option value="11">code</option>
						<option value="12">tree</option>
						<option value="13">layedit</option>
						<option value="14">nav</option>
						<option value="15">tab</option>
						<option value="16">table</option>
						<option value="17">select</option>
						<option value="18">checkbox</option>
						<option value="19">switch</option>
						<option value="20">radio</option>
					</select> <i class="layui-icon">&#xe615;</i>
				</div>
				<!-- 天气信息 -->
				<div class="weather" pc>
					<div id="tp-weather-widget"></div>
					<script>
						(function(T, h, i, n, k, P, a, g, e) {
							g = function() {
								P = h.createElement(i);
								a = h.getElementsByTagName(i)[0];
								P.src = k;
								P.charset = "utf-8";
								P.async = 1;
								a.parentNode.insertBefore(P, a)
							};
							T["ThinkPageWeatherWidgetObject"] = n;
							T[n] || (T[n] = function() {
								(T[n].q = T[n].q || []).push(arguments)
							});
							T[n].l = +new Date();
							if (T.attachEvent) {
								T.attachEvent("onload", g)
							} else {
								T.addEventListener("load", g, false)
							}
						}(window, document, "script", "tpwidget",
								"//widget.seniverse.com/widget/chameleon.js"))
					</script>
					<script>
						tpwidget("init", {
							"flavor" : "slim",
							"location" : "WX4FBXXFKE4F",
							"geolocation" : "enabled",
							"language" : "zh-chs",
							"unit" : "c",
							"theme" : "black",
							"container" : "tp-weather-widget",
							"bubble" : "enabled",
							"alarmType" : "badge",
							"color" : "#FFFFFF",
							"uid" : "U3C5F3DB0C",
							"hash" : "ae8d5d5e17a4172b65c42b81d9647e58"
						});
						tpwidget("show");
					</script>
				</div>
				<!-- 顶部右侧菜单 -->
				<ul class="layui-nav top_menu">
					<li class="layui-nav-item showNotice" id="showNotice" pc><a
						href="javascript:;"><i class="iconfont icon-gonggao"></i><cite>系统公告</cite></a>
					</li>
					<li class="layui-nav-item" mobile><a href="javascript:;"
						data-url="page/user/changePwd.html"><i
							class="iconfont icon-shezhi1" data-icon="icon-shezhi1"></i><cite>设置</cite></a>
					</li>
					<li class="layui-nav-item" mobile><a href="javascript:;"><i
							class="iconfont icon-loginout"></i> 退出</a></li>
					<li class="layui-nav-item lockcms" pc><a href="javascript:;"><i
							class="iconfont icon-lock1"></i><cite>锁屏</cite></a></li>
					<li class="layui-nav-item" pc><a href="javascript:;"
						style="pointer-events: none;"> <img
							src="<s:url value='/upload/%{image}' />"
							class="layui-circle faceImage" width="35" height="35"> <cite><s:property
									value="name" /></cite>
					</a>
						<dl class="layui-nav-child">

							<dd class="info"></dd>

							<dd>
								<a href="javascript:;"
									data-url="<s:url value='/admin/page/user/changePwd.jsp' />"><i
									class="iconfont icon-shezhi1" data-icon="icon-shezhi1"></i><cite>修改密码</cite></a>
							</dd>
							<dd>
								<a href="<s:url value='/Admin/quit' />"><i
									class="iconfont icon-loginout"></i><cite>退出</cite></a>
							</dd>
						</dl></li>
				</ul>
			</div>
		</div>
		<!-- 左侧导航 -->
		<div class="layui-side layui-bg-black">
			<div class="user-photo">
				<a class="img" title="我的头像"><img class="layui-anim faceImage"
					data-anim="layui-anim-rotate layui-anim-loop"
					src="<s:url value='/upload/%{image}' />"></a>
				<p>
					你好！<span class="name"><s:property value="name" /></span>, 欢迎登录 <input
						type="hidden" class="id" value="<s:property value="id" />" />
				</p>
				<input type="hidden" class="type"
					value="<s:property value='type' />" /> <input type="hidden"
					class="userName" value="<s:property value='userName' />" />
			</div>
			<div class="navBar layui-side-scroll"></div>
		</div>
		<!-- 右侧内容 -->
		<div class="layui-body layui-form">
			<div class="layui-tab marg0" lay-filter="bodyTab">
				<ul class="layui-tab-title top_tab">
					<li class="layui-this" lay-id=""><i
						class="iconfont icon-computer"></i> <cite>后台首页</cite></li>
				</ul>
				<div class="layui-tab-content clildFrame">
					<div class="layui-tab-item layui-show">
						<iframe src="<s:url value='/admin/page/main.jsp' />"></iframe>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- 锁屏 -->
	<div class="admin-header-lock" id="lock-box" style="display: none;">
		<div class="admin-header-lock-img">
			<img src="<s:url value='/upload/%{image}' />" />
		</div>
		<div class="admin-header-lock-name" id="lockUserName">
			<s:property value="name" />
		</div>
		<div class="input_btn">
			<input type="password" class="admin-header-lock-input layui-input"
				placeholder="请输入密码解锁.." name="lockPwd" id="lockPwd" />
			<button class="layui-btn" id="unlock">解锁</button>
		</div>
		<p>请输入密码，否则不会解锁成功哦！！！</p>
	</div>
	<!-- 移动导航 -->
	<div class="site-tree-mobile layui-hide">
		<i class="layui-icon">&#xe602;</i>
	</div>
	<div class="site-mobile-shade"></div>
	<script type="text/javascript"
		src="<s:url value='/admin/js/jquery-3.2.1.min.js' />"></script>
	<script type="text/javascript"
		src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/js/nav.js' />"></script>
	<script>
		var navs = $.ajax({
			"url" : "<s:url value='/Navs/findAll' />",
			async : false,
			"data" : {
				"type" : $(".type").val()
			},
			"success" : function(data) {
				var navs = [];
				for (var i = 0; i < data.length; i++) {
					if (data[i].spread == "false") {
						data[i].spread = false;
						navs.push(data[i]);
					} else {
						navs.push(data[i]);
					}
				}
			}
		});
		if ($(".type").val().trim() == 'student') {
			$(".logo").html('学生选课系统');
		}
		html = "";
		if ("<s:property value='type'/>" == "student") {
			html = '<a href="javascript:;" data-url="<s:url value='/studentInfo/perInfoedit' />?id=<s:property value='id' />"><i class="iconfont icon-zhanghu" data-icon="icon-zhanghu"></i><cite>个人资料</cite></a>';
		} else {
			html = '<a href="javascript:;" data-url="<s:url value='/Admin/edit' />?id=<s:property value='id' />"><i class="iconfont icon-zhanghu" data-icon="icon-zhanghu"></i><cite>个人资料</cite></a>';
		}
		$(".info").append(html)
	</script>
	<script type="text/javascript"
		src="<s:url value='/admin/js/leftNav.js' />"></script>
	<script type="text/javascript"
		src="<s:url value='/admin/js/index.js' />"></script>
</body>
</html>