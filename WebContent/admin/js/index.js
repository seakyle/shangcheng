var $,tab,skyconsWeather;
layui.config({
	base : "/shangcheng/admin/js/"
}).use(['bodyTab','form','element','layer','jquery'],function(){
	var form = layui.form(),
		layer = layui.layer,
		element = layui.element();
		$ = layui.jquery;
		tab = layui.bodyTab();
	//锁屏
	function lockPage(){
		layer.open({
			title : false,
			type : 1,
			content : $("#lock-box"),
			closeBtn : 0,
			shade : 0.9
		})
	}
	$(".lockcms").on("click",function(){
		window.sessionStorage.setItem("lockcms",true);
		lockPage();
	})
	// 判断是否显示锁屏
	if(window.sessionStorage.getItem("lockcms") == "true"){
		lockPage();
	}
	// 解锁
	$("#unlock").on("click",function(){
		if($(this).siblings(".admin-header-lock-input").val() == ''){
			layer.msg("请输入解锁密码！");
		}else{
			$.ajax({
				url:"/shangcheng/Admin/lockScreen",
				data:{"admin.username":$(".userName").val(),"admin.password":$(this).siblings(".admin-header-lock-input").val()},
				success:function(data){
					if(data.state){
						window.sessionStorage.setItem("lockcms",false);
						$(this).siblings(".admin-header-lock-input").val('');
						$("#lockPwd").val("");
						layer.closeAll("page");
					}else{
						layer.msg("密码错误，请重新输入！");
					}
				}
			});
			
				
			
		}
	});
	$(document).on('keydown', function() {
		if(event.keyCode == 13) {
			$("#unlock").click();
		}
	});

	//手机设备的简单适配
	var treeMobile = $('.site-tree-mobile'),
		shadeMobile = $('.site-mobile-shade')

	treeMobile.on('click', function(){
		$('body').addClass('site-mobile');
	});

	shadeMobile.on('click', function(){
		$('body').removeClass('site-mobile');
	});

	// 添加新窗口
	$(".layui-nav .layui-nav-item a").on("click",function(){
		if($(this)["0"].innerText != "锁屏"&&$(this)["0"].innerText != "退出"&&$(this)["0"].innerText != "系统公告"){
			addTab($(this));
			$(this).parent("li").siblings().removeClass("layui-nav-itemed");
			$($(".layui-tab-item.layui-show")["0"].firstChild).attr('src', $($(".layui-tab-item.layui-show")["0"].firstChild).attr('src'));
		}
	})

	//公告层
	function showNotice(){
		layer.open({
	        type: 1,
	        title: "系统公告", //不显示标题栏
	        closeBtn: false,
	        area: '310px',
	        shade: 0.8,
	        id: 'LAY_layuipro', //设定一个id，防止重复弹出
	        btn: ['火速围观'],
	        moveType: 1, //拖拽模式，0或者1
	        content: '<div style="padding:15px 20px; text-align:justify; line-height: 22px; text-indent:2em;border-bottom:1px solid #e2e2e2;"><p>这是一套学生信息管理系统，分为两个功能:<p>其一使用超级管理员的身份登录，可以对学生，课程等信息进行管理，并且可以对系统进行一些设置；</p>其二，使用学生的身份登录，可以进行选课以及对自己所选课程进行查看等功能。</p><p>本程序功能有待完善，欢迎大家指出程序不足。</p><p>QQ：644235159</p></div>',
	        success: function(layero){
				var btn = layero.find('.layui-layer-btn');
				btn.css('text-align', 'center');
				btn.on("click",function(){
					window.sessionStorage.setItem("showNotice","true");
				})
				if($(window).width() > 432){  //如果页面宽度不足以显示顶部“系统公告”按钮，则不提示
					btn.on("click",function(){
						layer.tips('系统公告躲在了这里', '#showNotice', {
							tips: 3
						});
					})
				}
	        }
	    });
	}
	
	//判断是否处于锁屏状态(如果关闭以后则未关闭浏览器之前不再显示)
	if(window.sessionStorage.getItem("lockcms") != "true" && window.sessionStorage.getItem("showNotice") != "true"){
		showNotice();
	}
	$(".showNotice").on("click",function(){
		showNotice();
	})

	element.tabChange("bodyTab",'');
	
	 //演示动画
	  $('.layui-anim').on('click', function(){
	    var othis = $(this), anim = othis.data('anim');
	 
	    //停止循环
	    if(othis.hasClass('layui-anim-loop')){
	      return othis.removeClass(anim);
	    }
	    
	    othis.removeClass(anim);
	    
	    setTimeout(function(){
	      othis.addClass(anim);
	    });
	    //恢复渐隐
	    if(anim === 'layui-anim-fadeout'){
	      setTimeout(function(){
	        othis.removeClass(anim);
	      }, 1300);
	    }
	  });

})

//打开新窗口
function addTab(_this){
	tab.tabAdd(_this);
}
