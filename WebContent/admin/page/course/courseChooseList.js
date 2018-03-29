layui.config({
	base : "js/"
}).use(['form','layer','jquery','laypage'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		$ = layui.jquery;
		$form = $('form');
		var basePath = $("body",window.parent.document).attr("basePath");
	//加载页面数据
	var newsData = '';
	$.get(basePath+"/course/list", function(data){
        	newsData = data;
        	newsList(newsData);
			//执行加载数据的方法
			newsList();
	})

	//查询
	$(".search_btn").click(function(){
		var newArray = [];
		if($(".search_input").val() != ''){
			var index = layer.msg('查询中，请稍候',{icon: 16,time:false,shade:0.8});
			setTimeout(function(){
            	$.ajax({
					url : basePath+"/course/findByKeyWords",
					type : "post",
					dataType : "json",
					data:{"keywords":$(".search_input").val()},
					success : function(data){
			        	newsList(data);
						newsList();
					}
				})
            	
                layer.close(index);
            },2000);
		}else{
			layer.msg("请输入需要查询的内容");
		}
	})

	//添加文章
	$(".courseAdd_btn").click(function(){
		var index = layui.layer.open({
			title : "添加课程",
			type : 2,
			content : "courseAdd.jsp",
			success : function(layero, index){
				layui.layer.tips('点击此处返回学生信息列表', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			}
		})
		//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
		$(window).resize(function(){
			layui.layer.full(index);
		})
		layui.layer.full(index);
	})
	
	//是否展示
	form.on('switch(isChoose)', function(data){
		if(this.checked){
			var index = layer.msg('选课中，请稍候',{icon: 16,time:false,shade:0.8});
			console.log($(this)["0"].attributes[5].nodeValue);
			$.ajax({
				"url":basePath+"/course/save",
				"data":{"id":$(this)["0"].attributes[5].nodeValue},
				"success":function(data){
					  setTimeout(function(){
				            layer.close(index);
							layer.msg("选课成功");
				        },1000);
				}
			})
	      
		}else{
			var index = layer.msg('退选中，请稍候',{icon: 16,time:false,shade:0.8});
			$.ajax({
				"url":basePath+"/course/withdrawal",
				"data":{"id":$(this)["0"].attributes[5].nodeValue},
				"success":function(data){
					  setTimeout(function(){
				            layer.close(index);
							layer.msg("退选成功");
				        },1000);
				}
			})
		}
		
	})
 
	//操作
	$("body").on("click",".course_edit",function(){  //编辑
		var _this = $(this);
		console.log(_this);
		var index = layui.layer.open({
			title : "修改学生信息",
			type : 2,
			content : $("body").attr("basePath")+"/course/edit?id="+_this.attr("data-id"),
			success : function(layero, index){
				layui.layer.tips('点击此处返回学生信息列表', '.layui-layer-setwin .layui-layer-close', {
					tips: 3
				});
			}
		})
		//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
		$(window).resize(function(){
			layui.layer.full(index);
		})
		layui.layer.full(index);
	})


	$("body").on("click",".course_del",function(){  //删除
		var _this = $(this);
		layer.confirm('确定删除此信息？',{icon:3, title:'提示信息'},function(index){
			$.ajax({
				"url":basePath+"/course/delete",
				"data":{"id":_this.attr("data-id")},
				"success":function(data){
					layer.msg("删除成功");
					var newsData = '';
					$.get($("body").attr("basePath")+"/course/list", function(data){
				        	newsData = data;
				        	newsList(newsData);
							newsList();
					})
				}
			})
			layer.close(index);
		});
	})

	function newsList(that){
		//渲染数据
		function renderDate(data,curr){
			var dataHtml = '';
			if(!that){
				currData = newsData.concat().splice(curr*nums-nums, nums);
			}else{
				currData = that.concat().splice(curr*nums-nums, nums);
			}
			if(currData.length != 0){
				for(var i=0;i<currData.length;i++){
					var html="";
					if(currData[i].student.length ==0 ){
						html= '<input type="checkbox" name="choose" lay-skin="switch" lay-text="已选|未选" lay-filter="isChoose" valueId="'+currData[i].id+'">';
					}
					for(var k = 0;k<currData[i].student.length;k++){
			    		if(currData[i].student[k].stu_name == $(".name",window.parent.document).html()){
			    			html= '<input type="checkbox" name="choose" lay-skin="switch" lay-text="已选|未选" lay-filter="isChoose" valueId="'+currData[i].id+'" checked>';
			    			break;
			    		}else{
			    			html= '<input type="checkbox" name="choose" lay-skin="switch" lay-text="已选|未选" lay-filter="isChoose" valueId="'+currData[i].id+'">';
			    		}
			    	}
					dataHtml += '<tr>'
			    	+'<td>'+currData[i].course_id+'</td>'
			    	+'<td>'+currData[i].course_name+'</td>'
			    	+'<td>'+currData[i].course_credits+'</td>'
			    	+'<td>'+currData[i].course_description+'</td>'
			    	+'<td>'
			    	+ html
			        +'</td>'
			    	+'</tr>';
				}
			}else{
				dataHtml = '<tr><td colspan="8">暂无数据</td></tr>';
			}
		    return dataHtml;
		}

		//分页
		var nums = 10; //每页出现的数据量
		if(that){
			newsData = that;
		}
		laypage({
			cont : "page",
			pages : Math.ceil(newsData.length/nums),
			jump : function(obj){
				$(".news_content").html(renderDate(newsData,obj.curr));
				$('.news_list thead input[type="checkbox"]').prop("checked",false);
		    	form.render();
			}
		})
	}
})
