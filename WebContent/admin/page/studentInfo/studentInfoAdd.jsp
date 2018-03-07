<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>添加学生</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="<s:url value='/admin/layui/css/layui.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/user.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/cropper.min.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/ImgCropping.css' />" media="all" />
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
	<input type="hidden" name="stu.type" value="student" />
		<div class="user_left">
			<div class="layui-form-item">
			    <label class="layui-form-label">学生姓名</label>
			    <div class="layui-input-block">
			    	<input type="text" class="layui-input newsName" value="<s:property value='stu.stu_name' />" lay-verify="required" placeholder="请输入学生姓名" name="stu.stu_name">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">学生学号</label>
			    <div class="layui-input-block">
			    	<input type="text" class="layui-input newsName" lay-verify="required" value="<s:property value='stu.stu_id' />" placeholder="请输入学生学号" name="stu.stu_id">
			    </div>
			</div>
		<div class="layui-form-item">
				<label class="layui-form-label">性别</label>
			    <div class="layui-input-block sexDiv" value="<s:property value='stu.sex' />">
			    	<input type="radio" name="stu.sex" value="男" title="男" class="sex">
	     			<input type="radio" name="stu.sex" value="女" title="女" class="sex" >
	     			<input type="radio" name="stu.sex" value="保密" title="保密" class="sex">
			    </div>
			</div>
			
			<input type="hidden" name="stu.address" class="address" value="<s:property value='stu.address' />" >
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
	            <div class="layui-input-inline" style="margin-right: 0px;">
	                <select name="area" lay-filter="area" disabled>
	                    <option value="">请选择县/区</option>
	                </select>
	            </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">身份证号</label>
			    <div class="layui-input-block">
			    	<input type="text" class="layui-input" name="stu.stu_num" placeholder="请输入学生身份证号" value="<s:property value='stu.stu_num' />">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">所选专业</label>
			    <div class="layui-input-block">
			    	<select name="stu.major" lay-filter="major"  value="<s:property value='stu.major' />" class="major">
	                    <option value="">请选择学生所选专业</option>
	                </select>
			    </div>
			</div>
			<div class="layui-form-item">
			<label class="layui-form-label">密码</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input" name="stu.password" placeholder="请输入学生登录密码" value="<s:property value='stu.password' />">
			</div>
		</div>
		</div>
		
		<div class="user_right">
			<button type="button" class="l-btn" id="replaceImg">我要更换头像</button>
			<p></p>
			<img src="" class="layui-circle" id="userFace" url="<s:url value='/Admin/upload'/>" imageSrc="<s:url value='/upload/' />">
			<input type="hidden" name="stu.image" value="<s:property value='admin.image' />" id="image">
		</div>
		<!--图片裁剪框 start-->
<div style="display: none" class="tailoring-container">
    <div class="black-cloth" onclick="closeTailor(this)"></div>
    <div class="tailoring-content">
            <div class="tailoring-content-one">
                <label title="上传图片" for="chooseImg" class="l-btn choose-btn">
                    <input type="file" accept="image/jpg,image/jpeg,image/png" name="file" id="chooseImg" class="hidden" onchange="selectImg(this)">
                    选择图片
                </label>
                <div class="close-tailoring"  onclick="closeTailor(this)">×</div>
            </div>
            <div class="tailoring-content-two">
                <div class="tailoring-box-parcel">
                    <img id="tailoringImg">
                </div>
                <div class="preview-box-parcel">
                    <p>图片预览：</p>
                    <div class="square previewImg"></div>
                    <div class="circular previewImg"></div>
                </div>
            </div>
            <div class="tailoring-content-three">
                <button class="l-btn cropper-reset-btn" type="button">复位</button>
                <button class="l-btn cropper-rotate-btn" type="button">旋转</button>
                <button class="l-btn cropper-scaleX-btn" type="button">换向</button>
                <button class="l-btn sureCut" id="sureCut" type="button">确定</button>
            </div>
        </div>
</div>
<!--图片裁剪框 end-->
		
		<div class="layui-form-item" style="margin-left: 5%;">
		    <div class="layui-input-block">
		    	<button class="layui-btn" lay-submit="" lay-filter="changeUser">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	</form>
	<script type="text/javascript" src="<s:url value='/admin/js/jquery-3.2.1.min.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/js/cropper.min.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/page/user/address.js' /> "></script>
	<script type="text/javascript" src="<s:url value='/admin/page/studentInfo/student.js' /> "></script>
</body>
<script>
	var radio = $(".sex");
	for(var i = 0;i<radio.length;i++){
		if($(radio[i]).val() == $(".sexDiv").attr("value")){
			$(radio[i]).attr("checked","checked");
			break;
		}
	}
	//图像上传
    function selectImg(file) {
        if (!file.files || !file.files[0]){
            return;
        }
        var reader = new FileReader();
        reader.onload = function (evt) {
            var replaceSrc = evt.target.result;
            //更换cropper的图片
            $('#tailoringImg').cropper('replace', replaceSrc,false);//默认false，适应高度，不失真
        }
        reader.readAsDataURL(file.files[0]);
    }
    //关闭裁剪框
    function closeTailor() {
        $(".tailoring-container").toggle();
    }
</script>
</html>