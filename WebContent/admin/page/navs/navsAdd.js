layui.config({
	base : "js/"
}).use(['form','layer','jquery','layedit','laydate'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		layedit = layui.layedit,
		laydate = layui.laydate,
		$ = layui.jquery;
	//创建一个编辑器
 	var editIndex = layedit.build('news_content');
 	var addNewsArray = [],addNews;
 /*	form.on("submit(addNews)",function(data){
 		//是否添加过信息
	 	if(window.sessionStorage.getItem("addNews")){
	 		addNewsArray = JSON.parse(window.sessionStorage.getItem("addNews"));
	 	}
 		addNews = $(".layui-form").serialize();
 		
 		addNewsArray.unshift(JSON.parse(addNews));
 		window.sessionStorage.setItem("addNews",JSON.stringify(addNewsArray));
 		//弹出loading
 		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
        setTimeout(function(){
            top.layer.close(index);
			top.layer.msg("文章添加成功！");
 			layer.closeAll("iframe");
	 		//刷新父页面
	 		parent.location.reload();
        },2000);
 		return false;
 	})*/
	$(".layui-btn").click(function(){
		$(".layui-form").submit();
//		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
//		 top.layer.close(index);
		 top.layer.msg("保存成功");
	 	 layer.closeAll("iframe");
		 //刷新父页面
	 	parent.location.reload();
	});
	//是否展示
	form.on('switch(isShow)', function(data){
		if($(".spread").val() == "true"){
			$(".spread").val("false");
		}else{
			$(".spread").val("true");
		}		
		var index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
        setTimeout(function(){
            layer.close(index);
			layer.msg("展示状态修改成功！");
        },500);
        $(".navSpread").val($(".spread").val());
	})
	
})
