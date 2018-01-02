layui.config({
	base : "js/"
}).use(['form','layer','jquery','laypage'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		$ = layui.jquery;
		$form = $('form');
		$.ajaxSetup({  
		    async : false  
		}); 
	//加载页面数据
	var newsData = '';
	$.get("/shangcheng/studentInfo/courseSelected?id="+$('.id', window.parent.document).val(), function(data){
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
						url : "/shangcheng/course/findByKeyWords",
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


	//批量退选
	$(".batchDel").click(function(){
		var $checkbox = $('.news_list tbody input[type="checkbox"][name="checked"]');
		var $checked = $('.news_list tbody input[type="checkbox"][name="checked"]:checked');
		if($checkbox.is(":checked")){
			layer.confirm('确定退选选中课程？',{icon:3, title:'提示信息'},function(index){
				var index = layer.msg('退选中，请稍候',{icon: 16,time:false,shade:0.8});
	            setTimeout(function(){
	            	//删除数据
	            	var ids="";
	            	for(var i = 0;i<$checked.length;i++){
	            		ids += $($checked[i]).attr("data-id")+",";
	            	}
	            	$.ajax({
	    				"url":"/shangcheng/course/withdrawal",
	    				"data":{"ids":ids.substring(0,ids.length-1)},
	    				"success":function(data){
	    					layer.msg("退选成功");
	    					var newsData = '';
	    					var newsData = '';
	    					$.get("/shangcheng/studentInfo/courseSelected?id="+$('.id', window.parent.document).val(), function(data){
	    				        	newsData = data;
	    				        	newsList(newsData);
	    							//执行加载数据的方法
	    							newsList();
	    					})
	    				}
	    			})
	            	$('.news_list thead input[type="checkbox"]').prop("checked",false);
	            	form.render();
	                layer.close(index);
					layer.msg("退选成功");
	            },2000);
	        })
		}else{
			layer.msg("请选择需要退选的课程");
		}
	})

	//全选
	form.on('checkbox(allChoose)', function(data){
		var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"])');
		child.each(function(index, item){
			item.checked = data.elem.checked;
		});
		form.render('checkbox');
	});

	//通过判断文章是否全部选中来确定全选按钮是否选中
	form.on("checkbox(choose)",function(data){
		var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"])');
		var childChecked = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"]):checked')
		if(childChecked.length == child.length){
			$(data.elem).parents('table').find('thead input#allChoose').get(0).checked = true;
		}else{
			$(data.elem).parents('table').find('thead input#allChoose').get(0).checked = false;
		}
		form.render('checkbox');
	})

	//是否展示
	form.on('switch(isShow)', function(data){
		var index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
        setTimeout(function(){
            layer.close(index);
			layer.msg("展示状态修改成功！");
        },2000);
	})
 
	//操作
	$("body").on("click",".course_edit",function(){  //编辑
		var _this = $(this);
		console.log(_this);
		var index = layui.layer.open({
			title : "修改学生信息",
			type : 2,
			content : "/shangcheng/course/edit?id="+_this.attr("data-id"),
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


	$("body").on("click",".course_del",function(){  //退选
		var _this = $(this);
		layer.confirm('确定退选'+_this["0"].parentElement.parentElement.childNodes[2].innerHTML+'课程？',{icon:3, title:'提示信息'},function(){
		var index = layer.msg('退选中，请稍候',{icon: 16,time:false,shade:0.8});
		$.ajax({
			"url":"/shangcheng/course/withdrawal",
			"data":{"ids":$(_this).attr("data-id")},
			"success":function(data){
				  setTimeout(function(){
			            layer.close(index);
						layer.msg("退选成功");
			        },1000);
			
				  $.get("/shangcheng/studentInfo/courseSelected?id="+$('.id', window.parent.document).val(), function(data){
			        	newsData = data;
			        	newsList(newsData);
						//执行加载数据的方法
						newsList();
				})
			}
		})
		})
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
					dataHtml += '<tr>'
			    	+'<td><input type="checkbox" name="checked" lay-skin="primary" lay-filter="choose" data-id="'+data[i].id+'"></td>'
			    	+'<td>'+currData[i].course_id+'</td>'
			    	+'<td>'+currData[i].course_name+'</td>'
			    	+'<td>'+currData[i].course_credits+'</td>'
			    	+'<td>'+currData[i].course_description+'</td>'
			    	+'<td>'
					+  '<a class="layui-btn layui-btn-danger layui-btn-mini course_del" data-id="'+data[i].id+'"><i class="layui-icon">&#xe640;</i>退选</a>'
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
