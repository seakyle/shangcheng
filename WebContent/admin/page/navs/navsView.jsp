<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>模块添加</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="<s:url value='/admin/layui/css/layui.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/font_eolqem241z66flxr.css' />" media="all" />
	<link rel="stylesheet" href="<s:url value='/admin/css/font-awesome-4.7.0/css/font-awesome.css' />" media="all" />
</head>
<style>
	option{
		display: -webkit-inline-box;
	}
	.modelIcon dd:nth-child(n+1)
    {
     	padding-left:30px !important;
    }
	.modelIcon dd:nth-child(1){
		position: absolute;
	}
	
	.modelIcon dd:nth-child(3n+1)
    {
     	position: absolute;
     	padding-left:5px !important;
     	pointer-events: none; 
     	
    }
	</style>
<body class="childrenBody">
	<form class="layui-form" action="<s:url value='/Navs/save' />">
	<input type="hidden" name="id" value="<s:property value='nav.id' />">
		<div class="layui-form-item">
			<label class="layui-form-label">模块标题</label>
			<div class="layui-input-block">
				<input type="text" name="nav.title" class="layui-input modelTitle" lay-verify="required" placeholder="请输入模块标题" value="<s:property value='nav.title' />" >
			</div>
		</div>
		<div class="layui-form-item">
			
			<div class="layui-inline">		
				<label class="layui-form-label">模块图标</label>
				<div class="layui-input-inline modelIcon"  style="pointer-events: none;">
					<select name="nav.icon" class="icon" lay-filter="browseLook" value="<s:property value='nav.icon' />">
				        <option value=""></option>
				    </select>
				    <div class=""></div>
				</div>
			</div>
			
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">父模块</label>
				<div class="layui-input-inline"  style="pointer-events: none;">
					<select name="parentId" class="parentNode" lay-filter="browseLook" value="<s:property value='nav.parentId' />">
				        <option value=""></option>
				    </select>
				</div>
			</div>
		</div>
		<div class="layui-form-item"  style="pointer-events: none;">
		<label class="layui-form-label">权限</label>
			<div class="layui-input-block  role">
									
				
			</div>
		</div>
		<input type="hidden" value="<s:property value='nav.type' />" class="type" />
		<div class="layui-form-item">
			<div class="layui-inline"  style="pointer-events: none;">
				<label class="layui-form-label">节点状态</label>
				<div class="layui-input-inline">
					<input type="checkbox" lay-skin="switch" lay-text="展开|关闭" lay-filter="isShow" value="<s:property value='nav.spread' />" class="spread">
					<input type="hidden" name="nav.spread" class="navSpread"/>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">模块链接</label>
			<div class="layui-input-block">
				<input type="text" name="nav.href" class="layui-input newsName" lay-verify="required" placeholder="请输入模块链接" value="<s:property value='nav.href' />">
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn close" lay-filter="close">关闭</button>
		    </div>
		</div>
	</form>
	
	<script type="text/javascript" src="<s:url value='/admin/js/jquery-3.2.1.min.js' />"></script>
	<script>
$.ajax({
	"url":"<s:url value='/Navs/findAll' />",
	"async":false,
	"data":{"type":$(".type").val()},
	 "success":function(data){
		 $(".parentNode").html("");
		 var html="<option value='0'>无</option>";
		 for(var i = 0;i<data.length;i++){
			if(data[i].id == $(".parentNode").attr("value")){
				html +="<option value='"+data[i].id+"' selected='true'>"+data[i].title+"</option>";
			}else if($(".modelTitle").val()!=data[i].title){
				html +="<option value='"+data[i].id+"'>"+data[i].title+"</option>";
			}
			
		 }
		 $(".parentNode").append(html);
	 }
});

if($(".spread").val() == "true"){
	$(".spread").click();
}

$.ajax({
	url:"<s:url value='/studentInfo/listForProvice' />",
	async : false,
	data:{"name":"fa"},
	success:function(data){
		var option =$(".icon")["0"].attributes[3].nodeValue;
		var html="";
		for(var i = 0;i<data.length;i++){
			if(option == data[i].name){
				html+="<span><i class='fa "+data[i].name+"' aria-hidden='true'></i>&nbsp;&nbsp;&nbsp;&nbsp;</span><option selected='true'>"+data[i].name+"</option>";
			}else{
				html+="<span><i class='fa "+data[i].name+"' aria-hidden='true'></i>&nbsp;&nbsp;&nbsp;&nbsp;</span><option>"+data[i].name+"</option>";
			}
			
		}
		$(".icon").append(html);
		console.log($(".fa"));
	}
}); 
$.ajax({
	url:"<s:url value='/studentInfo/listForProvice' />",
	async : false,
	data:{"name":"登录用户"},
	success:function(data){
		
		$.ajax({
			url:"<s:url value='/studentInfo/listForSelect' />",
			async : false,
			data:{"parentId":data[0].code},
			success:function(data){
				var html="";
				var type=$(".type").val().split(",");
				for(var i = 0;i<data.length;i++){
					var checked="";
					for(var k = 0;k<type.length;k++){
						if(type[k].trim() == data[i].code){
							checked="true";
							break;
						}else{
							checked="false";
						}
					}
					if(checked == "true"){
						html+='<div class="layui-input-inline" style="width:auto;"><input type="checkbox" name="nav.type" title="'+data[i].name+'" value="'+data[i].code+'" checked></div>';
					}else{
						html+='<div class="layui-input-inline" style="width:auto;"><input type="checkbox" name="nav.type" title="'+data[i].name+'" value="'+data[i].code+'"></div>';
					}
					
				}
				$(".role").append(html);
			}
		}); 
		
	}
}); 
var $layuiInput = $(".layui-input");
$layuiInput.attr("readonly","true");
</script>
	<script type="text/javascript" src="<s:url value='/admin/layui/layui.js' />"></script>
	<script type="text/javascript" src="<s:url value='/admin/page/navs/navsAdd.js' />"></script>
</body>

</html>