layui.config({
	base : "js/"
}).use(['form','layer','jquery','laypage','tree'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		$ = layui.jquery;
	$.ajaxSetup({  
	    async : false  
	}); 
	//加载页面数据
	var newsData = '';
	$.get("/shangcheng/Navs/list", function(data){
        	newsData = data;
        	newsList(newsData);
			newsList();
	})
var treeData;
$.get("/shangcheng/dictionary/listForTree", function(data){
	var parentNode = $(".parentNode");
	var html;
	for(var i = 0;i<data.length;i++){
		html+="<option value='"+data[i].parentNode+"'>"+data[i].name+"</option>";	
	}
	parentNode.append(html);
    treeData = data;
        	
	})
var parentNode;
$.get("/shangcheng/dictionary/findAll", function(data){
	parentNode=data;
})
$(".layui-btn-xs").click(function(){
	$(".parentNode").val($(".dictionaryName").val());
	$(".dictionaryName").val("");
	$(".dictionaryCode").val("");
	var level = $(".dictionaryLevel").val();
	$(".dictionaryLevel").val(parseInt(level)+1);
	$(".parentId").val( $(".dictionaryId").val());
	$(".dictionaryId").val("");
	$(".layui-btn.layui-btn-xs").hide();
	return false;
})
//树形菜单
layui.tree({
		  elem: '#demo', //传入元素选择器
		  nodes: treeData,
		  click: function(node){
			$(".add").show();
			if(node.level == 5){
				$(".layui-btn.layui-btn-xs").hide();
			}else{
				$(".layui-btn.layui-btn-xs").show();
			}
		    $(".dictionaryId").val(node.id);
		    $(".dictionaryName").val(node.name);
		    $(".dictionaryCode").val(node.code);
		    $(".dictionaryLevel").val(node.level);
		    for(var i = 0;i<parentNode.length;i++){
		    	if(parentNode[i].id == node.parentId){
		    		$(".parentNode").val(parentNode[i].name);
		    		$(".parentId").val(parentNode[i].id);
		    		break;
		    	}
		    	$(".parentNode").val("无");
		    	$(".parentId").val("00");
		    }
		  }  
});
	//查询
	$(".search_btn").click(function(){
		var newArray = [];
		if($(".search_input").val() != ''){
			var index = layer.msg('查询中，请稍候',{icon: 16,time:false,shade:0.8});
            setTimeout(function(){
            	$.ajax({
					url : "../../json/newsList.json",
					type : "get",
					dataType : "json",
					success : function(data){
						if(window.sessionStorage.getItem("addNews")){
							var addNews = window.sessionStorage.getItem("addNews");
							newsData = JSON.parse(addNews).concat(data);
						}else{
							newsData = data;
						}
						for(var i=0;i<newsData.length;i++){
							var newsStr = newsData[i];
							var selectStr = $(".search_input").val();
		            		function changeStr(data){
		            			var dataStr = '';
		            			var showNum = data.split(eval("/"+selectStr+"/ig")).length - 1;
		            			if(showNum > 1){
									for (var j=0;j<showNum;j++) {
		            					dataStr += data.split(eval("/"+selectStr+"/ig"))[j] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>";
		            				}
		            				dataStr += data.split(eval("/"+selectStr+"/ig"))[showNum];
		            				return dataStr;
		            			}else{
		            				dataStr = data.split(eval("/"+selectStr+"/ig"))[0] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>" + data.split(eval("/"+selectStr+"/ig"))[1];
		            				return dataStr;
		            			}
		            		}
		            		//文章标题
		            		if(newsStr.newsName.indexOf(selectStr) > -1){
			            		newsStr["newsName"] = changeStr(newsStr.newsName);
		            		}
		            		//发布人
		            		if(newsStr.newsAuthor.indexOf(selectStr) > -1){
			            		newsStr["newsAuthor"] = changeStr(newsStr.newsAuthor);
		            		}
		            		//审核状态
		            		if(newsStr.newsStatus.indexOf(selectStr) > -1){
			            		newsStr["newsStatus"] = changeStr(newsStr.newsStatus);
		            		}
		            		//浏览权限
		            		if(newsStr.newsLook.indexOf(selectStr) > -1){
			            		newsStr["newsLook"] = changeStr(newsStr.newsLook);
		            		}
		            		//发布时间
		            		if(newsStr.newsTime.indexOf(selectStr) > -1){
			            		newsStr["newsTime"] = changeStr(newsStr.newsTime);
		            		}
		            		if(newsStr.newsName.indexOf(selectStr)>-1 || newsStr.newsAuthor.indexOf(selectStr)>-1 || newsStr.newsStatus.indexOf(selectStr)>-1 || newsStr.newsLook.indexOf(selectStr)>-1 || newsStr.newsTime.indexOf(selectStr)>-1){
		            			newArray.push(newsStr);
		            		}
		            	}
		            	newsData = newArray;
		            	newsList(newsData);
					}
				})
            	
                layer.close(index);
            },2000);
		}else{
			layer.msg("请输入需要查询的内容");
		}
	})

	//添加文章
	$(".newsAdd_btn").click(function(){
		var index = layui.layer.open({
			title : "添加模块",
			type : 2,
			content : "navsAdd.jsp",
			success : function(layero, index){
				layui.layer.tips('点击此处返回模块列表', '.layui-layer-setwin .layui-layer-close', {
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

	//推荐文章
	$(".recommend").click(function(){
		var $checkbox = $(".news_list").find('tbody input[type="checkbox"]:not([name="show"])');
		if($checkbox.is(":checked")){
			var index = layer.msg('推荐中，请稍候',{icon: 16,time:false,shade:0.8});
            setTimeout(function(){
                layer.close(index);
				layer.msg("推荐成功");
            },2000);
		}else{
			layer.msg("请选择需要推荐的文章");
		}
	})

	//审核文章
	$(".audit_btn").click(function(){
		var $checkbox = $('.news_list tbody input[type="checkbox"][name="checked"]');
		var $checked = $('.news_list tbody input[type="checkbox"][name="checked"]:checked');
		if($checkbox.is(":checked")){
			var index = layer.msg('审核中，请稍候',{icon: 16,time:false,shade:0.8});
            setTimeout(function(){
            	for(var j=0;j<$checked.length;j++){
            		for(var i=0;i<newsData.length;i++){
						if(newsData[i].newsId == $checked.eq(j).parents("tr").find(".news_del").attr("data-id")){
							//修改列表中的文字
							$checked.eq(j).parents("tr").find("td:eq(3)").text("审核通过").removeAttr("style");
							//将选中状态删除
							$checked.eq(j).parents("tr").find('input[type="checkbox"][name="checked"]').prop("checked",false);
							form.render();
						}
					}
            	}
                layer.close(index);
				layer.msg("审核成功");
            },2000);
		}else{
			layer.msg("请选择需要审核的文章");
		}
	})

	//批量删除
	$(".batchDel").click(function(){
		var $checkbox = $('.news_list tbody input[type="checkbox"][name="checked"]');
		var $checked = $('.news_list tbody input[type="checkbox"][name="checked"]:checked');
		if($checkbox.is(":checked")){
			layer.confirm('确定删除选中的信息？',{icon:3, title:'提示信息'},function(index){
				var index = layer.msg('删除中，请稍候',{icon: 16,time:false,shade:0.8});
	            setTimeout(function(){
	            	//删除数据
	            	for(var j=0;j<$checked.length;j++){
	            		for(var i=0;i<newsData.length;i++){
							if(newsData[i].newsId == $checked.eq(j).parents("tr").find(".news_del").attr("data-id")){
								newsData.splice(i,1);
								newsList(newsData);
							}
						}
	            	}
	            	$('.news_list thead input[type="checkbox"]').prop("checked",false);
	            	form.render();
	                layer.close(index);
					layer.msg("删除成功");
	            },2000);
	        })
		}else{
			layer.msg("请选择需要删除的文章");
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
	$("body").on("click",".navs_edit",function(){  //编辑
		var _this = $(this);
		var index = layui.layer.open({
			title : "修改模块",
			type : 2,
			content : "/shangcheng/Navs/view?id="+_this.attr("data-id"),
			success : function(layero, index){
				layui.layer.tips('点击此处返回模块列表', '.layui-layer-setwin .layui-layer-close', {
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

	$("body").on("click",".news_collect",function(){  //收藏.
		if($(this).text().indexOf("已收藏") > 0){
			layer.msg("取消收藏成功！");
			$(this).html("<i class='layui-icon'>&#xe600;</i> 收藏");
		}else{
			layer.msg("收藏成功！");
			$(this).html("<i class='iconfont icon-star'></i> 已收藏");
		}
	})

	$("body").on("click",".news_del",function(){  //删除
		var _this = $(this);
		layer.confirm('确定删除此信息？',{icon:3, title:'提示信息'},function(index){
			//_this.parents("tr").remove();
		/*	for(var i=0;i<newsData.length;i++){
				if(newsData[i].newsId == _this.attr("data-id")){
					newsData.splice(i,1);
					newsList(newsData);
				}
			}*/
			
			$.ajax({
				"url":"/shangcheng/Navs/delete",
				"data":{"id":_this.attr("data-id")},
				"success":function(data){
					layer.msg("删除成功");
					var newsData = '';
					$.get("/shangcheng/Navs/list", function(data){
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
					dataHtml += '<tr>'
			    	+'<td><input type="checkbox" name="checked" lay-skin="primary" lay-filter="choose"></td>'
			    	+'<td>'+currData[i].title+'</td>'
			    	+'<td>'+currData[i].icon+'</td>';
			    	if(currData[i].spread == "false"){
			    		dataHtml += '<td>关闭</td>';
			    	}else{
			    		dataHtml += '<td>打开</td>';
			    	}
			    	dataHtml += '<td>'+currData[i].href+'</td>'
			    	+'<td>'
					+  '<a class="layui-btn layui-btn-mini navs_edit" data-id="'+data[i].id+'"><i class="iconfont icon-edit"></i> 编辑</a>'
					+  '<a class="layui-btn layui-btn-normal layui-btn-mini news_collect"><i class="layui-icon">&#xe600;</i> 收藏</a>'
					+  '<a class="layui-btn layui-btn-danger layui-btn-mini news_del" data-id="'+data[i].id+'"><i class="layui-icon">&#xe640;</i> 删除</a>'
			        +'</td>'
			    	+'</tr>';
				}
			}else{
				dataHtml = '<tr><td colspan="8">暂无数据</td></tr>';
			}
		    return dataHtml;
		}

		//分页
		var nums = 13; //每页出现的数据量
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
	$(".submit").click(function(){
		//$(".layui-form").submit();
		$.ajax({
			"url":$(".layui-form")[1].attributes[1].nodeValue,
			"data":$(".layui-form").serialize(),
			success:function(){
				$(".add").show();
				var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
				top.layer.close(index);
				 top.layer.msg("保存成功");
			 	 //layer.closeAll("iframe");
			 	var parentNode;
			 	$.get("/shangcheng/dictionary/findAll", function(data){
			 		parentNode=data;
			 	});
			 	layui.tree({
					  elem: '#demo', //传入元素选择器
					  nodes: treeData,
					  click: function(node){
						if(node.level == 4){
							$(".layui-btn.layui-btn-xs").hide();
						}
					    $(".dictionaryId").val(node.id);
					    $(".dictionaryName").val(node.name);
					    $(".dictionaryCode").val(node.code);
					    $(".dictionaryLevel").val(node.level);
					    for(var i = 0;i<parentNode.length;i++){
					    	if(parentNode[i].id == node.parentId){
					    		$(".parentNode").val(parentNode[i].name);
					    		$(".parentId").val(parentNode[i].id);
					    		break;
					    	}
					    	$(".parentNode").val("无");
					    	$(".parentId").val("00");
					    }
					  }  
			});
			}
		});
});
	$(".delete").click(function(){
		$.ajax({
			"url":"/shangcheng/dictionary/delete",
			"data":{"id":$(".dictionaryId").val()},
			"success":function(data){
				 top.layer.msg("删除成功");
			}
		});
	})
})


