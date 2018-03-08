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
	$(".layui-btn.submit").click(function(){
		var index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
		 setTimeout(function(){
			$.ajax({
				url:$(".layui-form").attr("href"),
				data:$(".layui-form").serialize(),
				success:function(){
					 layer.close(index);
					 layer.closeAll("iframe");
					 top.layer.msg("保存成功");
					 window.parent.LoadData();
				}
			})
          },2000);
		 
		 return false;
		 
		 //刷新父页面
	 	//parent.location.reload();
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
	$(".close").click(function(){
 		layer.closeAll("iframe");
 		return false;
 	})
})
