var areaData = address;
var $form;
var form;
var $;
layui.config({
	base : "../../js/"
}).use(['form','layer','upload','laydate'],function(){
	form = layui.form();
	var layer = parent.layer === undefined ? layui.layer : parent.layer;
		$ = layui.jquery;
		$form = $('form');
		laydate = layui.laydate;
        layui.upload({
        	url : "../../json/userface.json",
        	success: function(res){
        		var num = parseInt(4*Math.random());  //生成0-4的随机数
        		//随机显示一个头像信息
		    	userFace.src = res.data[num].src;
		    	window.sessionStorage.setItem('userFace',res.data[num].src);
		    }
        });
        
        
        //添加验证规则
        form.verify({
            oldPwd : function(value, item){
                if(value != "123456"){
                    return "密码错误，请重新输入！";
                }
            },
            newPwd : function(value, item){
                if(value.length < 6){
                    return "密码长度不能小于6位";
                }
            },
            confirmPwd : function(value, item){
                if(!new RegExp($("#oldPwd").val()).test(value)){
                    return "两次输入密码不一致，请重新输入！";
                }
            }
        })

        //判断是否修改过头像，如果修改过则显示修改后的头像，否则显示默认头像
        if(window.sessionStorage.getItem('userFace')){
        	$("#userFace").attr("src",window.sessionStorage.getItem('userFace'));
        }else{
        	$("#userFace").attr("src","../../images/face.jpg");
        }

        //提交个人资料
        form.on("submit(changeUser)",function(data){
        	var index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
        		 setTimeout(function(){
        			 $.ajax({  
        	                cache: true,  
        	                type: "POST",  
        	                url:"/shangcheng/Admin/save",  
        	                data:$('#userInfoform').serialize(),// 你的formid  
        	                async: false,  
        	                error: function(request) {  
        	                    alert("error");  
        	                },  
        	                success: function(data) {  
        	                	if(data.state){
        	                		layer.msg(data.msg);
        	                	}else{
        	                		layer.msg(data.msg);
        	                	}
        	                }  
        	            });
                     layer.close(index);
                 },2000);
            
        	return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        })

        

        //修改密码
        form.on("submit(changePwd)",function(data){
        	var index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
            setTimeout(function(){
                layer.close(index);
                layer.msg("密码修改成功！");
                $(".pwd").val('');
            },2000);
        	return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        })
        var areaData;
 	$.ajax({
			url:"/shangcheng/studentInfo/listForProvice",
			async : false,
			data:{"name":"省"},
			success:function(data){
				areaData = data;
			}
			
		});
 	var address = $(".address").val();
 	loadProvince();
 	
 	 //加载省数据
 	function loadProvince() {
 		var province = address.substring(0,address.indexOf('省')+1);
 		console.log(areaData);
 	    var proHtml = '';
 	    for (var i = 0; i < areaData.length; i++) {
 	    	if(province == areaData[i].name){
 	    		 proHtml += '<option value="' + areaData[i].id+'" selected="true">' + areaData[i].name + '</option>';
 	    		 provinceCode = areaData[i];
 	    	}else{
 	    		 proHtml += '<option value="' + areaData[i].id+'">' + areaData[i].name + '</option>';
 	    	}
 	       
 	    }
 	    //初始化省数据
 	    $form.find('select[name=province]').append(proHtml);
 	    form.render();
 	    if(address != ""){
 	    	$form.find('select[name=area]').html('<option value="">请选择县/区</option>');
		    var city;
		    var count;
		    $.ajax({
				url:"/shangcheng/studentInfo/listForSelect",
				data:{"parentId":$(".province").val()},
				async : false,
				success:function(data){
					console.log(data);
					count = data.length;
					city = data;
				}
			});
		    if (count > 0) {
		    	 loadCity(city);
		    } else {
		        $form.find('select[name=city]').attr("disabled","disabled");
		    }
 	    }
 	   form.on('select(province)', function() {
 		  $form.find('select[name=area]').html('<option value="">请选择县/区</option>');
		    var city;
		    var count;
		    $.ajax({
				url:"/shangcheng/studentInfo/listForSelect",
				data:{"parentId":$(".province").val()},
				async : false,
				success:function(data){
					console.log(data);
					count = data.length;
					city = data;
				}
			});
		    if (count > 0) {
		    	 loadCity(city);
		    } else {
		        $form.find('select[name=city]').attr("disabled","disabled");
		    }
		});
 	  var area;
	    var count;
	    $.ajax({
			url:"/shangcheng/studentInfo/listForSelect",
			data:{"parentId":$("select[name=city]").val()},
			async : false,
			success:function(data){
				console.log(data);
				count = data.length;
				area = data;
			}
		});
	    if (count > 0) {
	    	loadArea(area);
	    } else {
	        $form.find('select[name=area]').attr("disabled","disabled");
	    }
	    var province = $("select[name=province]").find("option:selected").text();
	        var city = $("select[name=city]").find("option:selected").text();
        var area =  $("select[name=area]").find("option:selected").text();
	        $(".address").val(province+city+area);
 	}
	
 	 //加载市数据
 	function loadCity(citys) {
 		var city = address.substring(address.indexOf('省')+1,address.indexOf('市')+1);
 	    var cityHtml = '<option value="">请选择市</option>';
 	    for (var i = 0; i < citys.length; i++) {
 	    	if(city == citys[i].name){
 	    		cityHtml += '<option value="' + citys[i].id+'" selected="true">' + citys[i].name + '</option>';
 	    	}else{
 	    		cityHtml += '<option value="' + citys[i].id+'">' + citys[i].name + '</option>';
 	    	}
 	        
 	    }
 	    $form.find('select[name=city]').html(cityHtml).removeAttr("disabled");
 	    form.render();
 	    form.on('select(city)', function() {
 	    	var area;
 		    var count;
 		    $.ajax({
 				url:"/shangcheng/studentInfo/listForSelect",
 				data:{"parentId":$("select[name=city]").val()},
 				async : false,
 				success:function(data){
 					console.log(data);
 					count = data.length;
 					area = data;
 				}
 			});
 		    if (count > 0) {
 		    	loadArea(area);
 		    } else {
 		        $form.find('select[name=area]').attr("disabled","disabled");
 		    }
 		});
 	}
 	 //加载县/区数据
 	function loadArea(areas) {
 		var area = address.substring(address.indexOf('市')+1,address.length);
 	    var areaHtml = '<option value="">请选择县/区</option>';
 	    for (var i = 0; i < areas.length; i++) {
 	    	if(area == areas[i].name){
 	    		areaHtml += '<option value="' + areas[i].id + '" selected="true">' + areas[i].name + '</option>';
 	    	}else{
 	    		 areaHtml += '<option value="' + areas[i].id + '">' + areas[i].name + '</option>';
 	    	}
 	       
 	    }
 	    $form.find('select[name=area]').html(areaHtml).removeAttr("disabled");
 	    form.render();
 	    form.on('select(area)', function(data) {
 	        var province = $("select[name=province]").find("option:selected").text();
 	        var city = $("select[name=city]").find("option:selected").text();
	        var area =  $("select[name=area]").find("option:selected").text();
 	        $(".address").val(province+city+area);
 	    });
 	}
 	
// 	//上传图片
// 	layui.use('upload', function(){
// 		  var $ = layui.jquery
// 		  ,upload = layui.upload;
// 		  
// 		  //普通图片上传
// 		  var uploadInst = upload.render({
// 		    elem: '#test1'
// 		    ,url: '/SSM_Book/upload'
// 		    ,before: function(obj){
// 		      //预读本地文件示例，不支持ie8
// 		      obj.preview(function(index, file, result){
// 		        $('#demo1').attr('src', result); //图片链接（base64）
// 		      });
// 		    }
// 		    ,done: function(res){
// 		      //如果上传失败
// 		      if(res.code > 0){
// 		        return layer.msg('上传失败');
// 		      }
// 		      //上传成功
// 		    }
// 		    ,error: function(){
// 		      //演示失败状态，并实现重传
// 		      var demoText = $('#demoText');
// 		      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
// 		      demoText.find('.demo-reload').on('click', function(){
// 		        uploadInst.upload();
// 		      });
// 		    }
// 		  });
// 	});

})

 