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
	<link rel="stylesheet" href="<s:url value='/admin/css/cropper.min.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/ImgCropping.css' />" media="all" />
	<style type="text/css">
		.course_left{
			width: 45%;
    		float: left;
    		margin: 20px 0 0 5%;
		}
		.course_right{
			width: 25%;
    		float: left;
    		margin: 20px 0 0 5%;
    		text-align: center;
		}
		.course_right img#courseFace {
   			 width: 200px;
    		height: 200px;
    		margin-top: 10px;
		}
		.tailoring-container .tailoring-content{
			left:20%;
			top:5%;
		}
	</style>
</head>
<body class="childrenBody">
	<form class="layui-form" action="<s:url value='/course/save' />">
	<input type="hidden" name="id" value="<s:property value='course.id' />">
	<div class="course_left">
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
			<label class="layui-form-label">任课教师</label>
			<div class="layui-input-block">
					<select name="teacher" class="layui-input teacher" lay-filter="browseLook" value="<s:property value='course.teacher.tch_name' />">
				        <option value="">请选择任课教师</option>
				    </select>
				</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">课程学分</label>
			<div class="layui-input-block">
					<select name="course.course_credits" class="layui-input credits" lay-filter="browseLook" value="<s:property value='course.course_credits' />">
				        <option value="">请选择课程学分</option>
				        <option value="1.0">1.0</option>
				        <option value="2.0">2.0</option>
				        <option value="3.0">3.0</option>
				        <option value="4.0">4.0</option>
				        <option value="5.0">5.0</option>
				    </select>
				</div>
		</div>
		<div class="layui-form-item layui-form-text">
    		<label class="layui-form-label">课程描述</label>
    		<div class="layui-input-block">
      			<textarea  placeholder="请输入课程描述" class="layui-textarea" name="course.course_description"><s:property value='course.course_description' /></textarea>
    		</div>
  		</div>
  		</div>
  		<div class="course_right">
			<button type="button" class="layui-btn" id="replaceImg">上传课程封面</button>
			<p></p>
			<img src="" class="layui-circle" id="courseFace" url="<s:url value='/Admin/upload'/>" imageSrc="<s:url value='/upload/' />">
			<input type="hidden" name="course.image" value="<s:property value='course.image' />" id="image">
		</div>
			<!--图片裁剪框 start-->
<div style="display: none" class="tailoring-container">
    <div class="black-cloth" onclick="closeTailor(this)"></div>
    <div class="tailoring-content layui-anim layui-anim-scale">
            <div class="tailoring-content-one">
                <label title="上传图片" for="chooseImg" class="layui-btn choose-btn">
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
                <button class="layui-btn cropper-reset-btn" type="button">复位</button>
                <button class="layui-btn cropper-rotate-btn" type="button">旋转</button>
                <button class="layui-btn cropper-scaleX-btn" type="button">换向</button>
                <button class="layui-btn sureCut" id="sureCut" type="button">确定</button>
            </div>
        </div>
</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn submit" lay-submit="" lay-filter="addNews">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
		
	</form>
	<script type="text/javascript" src="<s:url value='/admin/js/jquery.min.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/js/cropper.min.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/page/course/courseAdd.js' />"></script>
	<script type="text/javascript">
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
</body>
</html>