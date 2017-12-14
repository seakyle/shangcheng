<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Minimal and Clean Sign up / Login and Forgot Form by FreeHTML5.co</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FreeHTML5.co" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />

  	<!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="<s:url value='favicon.ico' />">

	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
	
	<link rel="stylesheet" href="<s:url value='/admin/login/css/bootstrap.min.css' />">
	<link rel="stylesheet" href="<s:url value='/admin/login/css/animate.css' />">
	<link rel="stylesheet" href="<s:url value='/admin/login/css/style.css' />">


	<!-- Modernizr JS -->
	<script src="<s:url value='/admin/login/js/modernizr-2.6.2.min.js' />"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="<s:url value='/admin/login/js/respond.min.js' />"></script>
	<![endif]-->

	</head>
	<body class="style-2">

		<div class="container">
			
			<div class="row">
				<div class="col-md-4">
					

					<!-- Start Sign In Form -->
					<form action="<s:url value='/checkLogin/checkLogin' />" class="fh5co-form animate-box" data-animate-effect="fadeInLeft" method="post">
						<h2>登录</h2>
						<div class="form-group">
							<label for="username" class="sr-only">用户名</label>
							<input type="text" class="form-control" name="admin.username" id="username" placeholder="请输入用户名" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="password" class="sr-only">密码</label>
							<input type="password" class="form-control" name="admin.password" id="password" placeholder="请输入密码" autocomplete="off">
						</div>
						 <div class="form-group">
                        	<label for="code" class="sr-only">验证码</label>
                            <input type="text" class="form-control" id="code" name="code" placeholder="请输入验证码" autocomplete="off">
                           <img src="<s:url value='/admin/login/image.jsp' />" style="height:43px;position: absolute;top: 312px;left: 63%" alt="" width="100" height="32" class="passcode" style="height:43px;cursor:pointer;" onclick="this.src=this.src+'?'">    
                    </div>
						<div class="form-group">
							<label for="remember"><input type="checkbox" id="remember"> 记住我</label>
						</div>
						<div class="form-group">
							<p>没有注册? <a href="<s:url value='/admin/login/sign-up2.html' />">注册</a> | <a href="<s:url value='/admin/login/forgot2.html' />">忘记密码?</a></p>
						</div>
						<div class="form-group">
							<input type="submit" value="登录" class="btn btn-primary">
						</div>
					</form>
					<!-- END Sign In Form -->

				</div>
			</div>
			
		</div>
	
	<!-- jQuery -->
	<script src="<s:url value='/admin/login/js/jquery.min.js' />"></script>
	<!-- Bootstrap -->
	<script src="<s:url value='/admin/login/js/bootstrap.min.js' />"></script>
	<!-- Placeholder -->
	<script src="<s:url value='/admin/login/js/jquery.placeholder.min.js' />"></script>
	<!-- Waypoints -->
	<script src="<s:url value='/admin/login/js/jquery.waypoints.min.js' />"></script>
	<!-- Main JS -->
	<script src="<s:url value='/admin/login/js/main.js' />"></script>

	</body>
</html>

