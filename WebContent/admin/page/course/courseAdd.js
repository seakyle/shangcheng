layui.config({
	base : "js/"
}).use(['form','layer','jquery','layedit','laydate'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		layedit = layui.layedit,
		laydate = layui.laydate,
		$ = layui.jquery;
		$form = $('form');
		var basePath = $("body",window.parent.parent.document).attr("basePath");
		if($("#image").val() != ""){
        	$("#courseFace").attr("src",$("#courseFace").attr("imageSrc")+$("#image").val());
        }else{
        	$("#courseFace").attr("src",$("#courseFace").attr("imageSrc")+"face.jpg");
        }
	//创建一个编辑器
 	var editIndex = layedit.build('news_content');
 	var addNewsArray = [],addNews;
 	$(".layui-btn.submit").click(function(){
		$(".layui-form").submit();
		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:true,shade:0.8});
		 top.layer.close(index);
		 top.layer.msg("保存成功");
	 	 layer.closeAll("iframe");
		 //刷新父页面
		 parent.location.reload();
	});
 	var credits = $(".credits").attr("value");
 	var option = $(".credits").find("option");
 	for(var i = 0;i<option.length;i++){
 		if($(option[i]).val() == credits){
 			$(option[i]).attr("selected","true");
 			form.render('select');
 			break;
 		}
 	}
 	//获取教师列表
 	$.ajax({
 		"url":basePath+"teacher/list",
 		"success":function(data){
 			var teacher = $(".teacher").attr("value");
 		 	var option = $(".teacher").find("option");
 		 	var html="";
 		 	for(var i = 0;i<data.length;i++){
 		 		if(data[i].tch_name == teacher){
 		 			html+="<option value='"+data[i].id+"' selected='true'>"+data[i].tch_name+"</option>";
 		 		}else{
 		 			html+="<option value='"+data[i].id+"'>"+data[i].tch_name+"</option>";
 		 		}
 		 	}
 		 	$(".teacher").append(html);
		 	form.render('select');
 		}
 	})
 	 //弹出图片裁剪框
    $("#replaceImg").on("click",function () {
        $(".tailoring-container").toggle();
    });
    
    //cropper图片裁剪
    $('#tailoringImg').cropper({
        aspectRatio: 1/1,//默认比例
        preview: '.previewImg',//预览视图
        guides: false,  //裁剪框的虚线(九宫格)
        autoCropArea: 0.5,  //0-1之间的数值，定义自动剪裁区域的大小，默认0.8
        movable: false, //是否允许移动图片
        dragCrop: true,  //是否允许移除当前的剪裁框，并通过拖动来新建一个剪裁框区域
        movable: true,  //是否允许移动剪裁框
        resizable: true,  //是否允许改变裁剪框的大小
        zoomable: false,  //是否允许缩放图片大小
        mouseWheelZoom: false,  //是否允许通过鼠标滚轮来缩放图片
        touchDragZoom: true,  //是否允许通过触摸移动来缩放图片
        rotatable: true,  //是否允许旋转图片
        crop: function(e) {
            // 输出结果数据裁剪图像。
        }
    });
    //旋转
    $(".cropper-rotate-btn").on("click",function () {
        $('#tailoringImg').cropper("rotate", 45);
    });
    //复位
    $(".cropper-reset-btn").on("click",function () {
        $('#tailoringImg').cropper("reset");
    });
    //换向
    var flagX = true;
    $(".cropper-scaleX-btn").on("click",function () {
        if(flagX){
            $('#tailoringImg').cropper("scaleX", -1);
            flagX = false;
        }else{
            $('#tailoringImg').cropper("scaleX", 1);
            flagX = true;
        }
        flagX != flagX;
    });
    function dataURLtoFile(dataurl, filename) {
        var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
            bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
        while(n--){
            u8arr[n] = bstr.charCodeAt(n);
        }
        return new File([u8arr], filename, {type:mime});
    }
    //裁剪后的处理
    $("#sureCut").on("click",function () {
        if ($("#tailoringImg").attr("src") == null ){
            return false;
        }else{
            var cas = $('#tailoringImg').cropper('getCroppedCanvas');//获取被裁剪后的canvas
            var base64url = cas.toDataURL('image/png'); //转换为base64地址形式
            $("#courseFace").prop("src",base64url);//显示为图片的形式
            var formData=new FormData();
            var name = "aaa.jpg";
            formData.append('file',dataURLtoFile(base64url, name),name);

            $.ajax({
                method:"post",
                url: $("#courseFace").attr("url"), //用于文件上传的服务器端请求地址
                data: formData,
                processData: false,
                contentType: false,
                success:function(result){
                	$("#courseFace").attr("src",$("#courseFace").attr("imageSrc")+result);
            		$("#image").val(result);
                }
            });
            //关闭裁剪框
            closeTailor();
        }
    });
 	
})
