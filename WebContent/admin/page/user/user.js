var areaData = address;
var $form;
var form;
var $;
layui.config({
	base : "../../js/"
}).use(['form','layer','upload','laydate','element'],function(){
	form = layui.form();
	var layer = parent.layer === undefined ? layui.layer : parent.layer;
		$ = layui.jquery;
		$form = $('form');
		laydate = layui.laydate;
		element = layui.element();
        layui.upload({
        	url : $("#userFace").attr("url"),
        	success: function(res){
        		$("#userFace").attr("src",$("#userFace").attr("imageSrc")+res);
        		$("#image").val(res);
		    }
        });
        if($("#image").val() != ""){
        	$("#userFace").attr("src",$("#userFace").attr("imageSrc")+$("#image").val());
        }else{
        	$("#userFace").attr("src",$("#userFace").attr("imageSrc")+"face.jpg");
        }
        
        //添加验证规则
        form.verify({
        	oldPwd : function(value, item){
               if(value==$("#oldPwd").val()){
            	   return "新密码与旧密码不能相同";
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
      

        //提交个人资料
        form.on("submit(changeUser)",function(data){
        	var index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
        		 setTimeout(function(){
        			 $.ajax({  
        	                cache: true,  
        	                type: "POST",  
        	                url:$("#userInfoform").attr("action"),  
        	                data:$('#userInfoform').serialize(),// 你的formid  
        	                async: false,  
        	                error: function(request) {  
        	                    alert("error");  
        	                },  
        	                success: function(data) {  
        	                	if(data.state){
        	                		layer.msg(data.msg);
        	                		var faceImage = $('.faceImage', window.parent.document);
        	                		for(var i = 0;i<faceImage.length;i++){
        	                			$(faceImage[i]).attr("src",$("#userFace").attr("src"));
        	                		}
        	                	}else{
        	                		layer.msg(data.msg);
        	                	}
        	                }  
        	            });
                     layer.close(index);
                     layer.closeAll("iframe");
                     
                     
                 },2000);
        		 
        	return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        })

        
console.log($(".loginout"));
        //修改密码
        form.on("submit(changePwd)",function(data){
        	$.ajax({
        		"url":$(".changePwd").attr("action"),
        		"data":{"admin.username":$(".userName").val(),"password":$("#oldPwd").val(),"admin.password":$(".currentPwd").val()},
        		"success":function(data){
        			console.log(data);
        			var index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
        			if(data.state){
        				setTimeout(function(){
                            layer.close(index);
                            layer.msg(data.msg);
                            $(".pwd").val('');
                            window.parent.location.href = $(".changePwd").attr("href");
                        },1000);
        			}else{
                        setTimeout(function(){
                            layer.close(index);
                            layer.msg(data.msg,{icon:5,shift:6});
                            $(".pwd").val('');
                        },1000);
        			}
        			
        		}
        	});
        	
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
 	var flag = true;
 	loadProvince();
 	//关闭按钮
 	$(".close").click(function(){
 		layer.closeAll("iframe");
 		return false;
 	})
 	
 	 //加载省数据
 	function loadProvince() {
 		var province = address.substring(0,address.indexOf('省')+1);
 		console.log(areaData);
 	    var proHtml = '';
 	    for (var i = 0; i < areaData.length; i++) {
 	    	if(province == areaData[i].name){
 	    		 proHtml += '<option value="' + areaData[i].code+'" selected="true">' + areaData[i].name + '</option>';
 	    		 provinceCode = areaData[i];
 	    	}else{
 	    		 proHtml += '<option value="' + areaData[i].code+'">' + areaData[i].name + '</option>';
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
	        flag = false;
 	}
	
 	 //加载市数据
 	function loadCity(citys) {
 		var city = address.substring(address.indexOf('省')+1,address.indexOf('市')+1);
 	    var cityHtml = '<option value="">请选择市</option>';
 	    for (var i = 0; i < citys.length; i++) {
 	    	if(city == citys[i].name && flag){
 	    		cityHtml += '<option value="' + citys[i].code+'" selected="true">' + citys[i].name + '</option>';
 	    	}else{
 	    		cityHtml += '<option value="' + citys[i].code+'">' + citys[i].name + '</option>';
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
 	    	if(area == areas[i].name && flag){
 	    		areaHtml += '<option value="' + areas[i].code+ '" selected="true">' + areas[i].name + '</option>';
 	    	}else{
 	    		 areaHtml += '<option value="' + areas[i].code + '">' + areas[i].name + '</option>';
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
 	$.ajax({
		url:"/shangcheng/dictionary/findMajor",
		async : false,
		success:function(data){
			var major = $form.find('select[class=major]').attr("value");
			var html = "";
			for(var i = 0;i<data.length;i++){
				if(major == data[i].name){
					html += "<option value='"+data[i].name+"' selected>"+data[i].name+"</option>";
				}else{
					html += "<option value='"+data[i].name+"'>"+data[i].name+"</option>";
				}
				
			}
			$form.find('select[class=major]').html(html);
			form.render();
		}
		
	});

})

 