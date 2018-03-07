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
 	
 	
})
