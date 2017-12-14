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

	//创建一个编辑器
 	var editIndex = layedit.build('news_content');
 	var addNewsArray = [],addNews;
 	$(".layui-btn").click(function(){
		$(".layui-form").submit();
		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:true,shade:0.8});
		 top.layer.close(index);
		
	 	 layer.closeAll("iframe");
		 //刷新父页面
		 
	});
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
 	    var proHtml = '';
 	    for (var i = 0; i < areaData.length; i++) {
 	    	if(province == areaData[i].name){
 	    		 proHtml += '<option value="' + areaData[i].id+'" selected="true">' + areaData[i].name + '</option>';
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
 	    	}
 	        
 	    }
 	    $form.find('select[name=city]').html(cityHtml).removeAttr("disabled");
 	    form.render();
 	   
 	}
 	 //加载县/区数据
 	function loadArea(areas) {
 		var area = address.substring(address.indexOf('市')+1,address.length);
 	    var areaHtml = '<option value="">请选择县/区</option>';
 	    for (var i = 0; i < areas.length; i++) {
 	    	if(area == areas[i].name){
 	    		areaHtml += '<option value="' + areas[i].id + '" selected="true">' + areas[i].name + '</option>';
 	    	}
 	       
 	    }
 	    $form.find('select[name=area]').html(areaHtml).removeAttr("disabled");
 	    form.render();
 	   
 	}
})
