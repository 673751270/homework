<#-- Created by IntelliJ IDEA.
 User: Administrator
 Date: 2017/12/6
 Time: 14:00
 To change this template use File | Settings | File Templates.
 切片管理-->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>切片管理</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport"
        content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
          <link rel="stylesheet" href="${re.contextPath}/ftl/section/layui/css/layui.css">
  <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="${re.contextPath}/plugin/tools/tool.js"></script>
  <script type="text/javascript" src="${re.contextPath}/plugin/common/js/echarts.js"></script>
  <script type="text/javascript" src="${re.contextPath}/ftl/section/layui/layui.js"
          charset="utf-8"></script>

 
      
<style>
	html,body {
	height: 100%;
	width: 100%;
	}
	table th{
		background-color:#00A0B5;
		color: #ffffff;
	}
	 .layadmin-backlog-body {
    display: block;
    padding: 10px 15px;
    background-color: #f2f2f2;
    color: #999;
    border-radius: 2px;
    transition: all .3s;
    -webkit-transition: all .3s;
}
.layadmin-backlog-body p cite {
    font-style: normal;
    font-size: 25px;
    font-weight: 300;
    color: #009688;
}
.layadmin-carousel .layui-col-space10 {
    margin: 0;
}
.layadmin-backlog-body h3 {
    padding-bottom: 10px;
    font-size: 12px;
}
#layadmin-shortcut {
    text-align: center;
}
#layadmin-shortcut i {
    display: inline-block;
    width: 100%;
    height: 90%;
    line-height: 80px;
    text-align: center;
    border-radius: 2px;
    font-size: 30px;
    color: #333;
    transition: all .3s;
    -webkit-transition: all .3s;
}
.ulcc  li {
float: left;
width: 40%;
}
#layadmin-shortcut  cite {
    position: relative;
    top: 2px;
    display: block;
    color: #666;
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
    font-size: 14px;
}
</style>
</head>

<body style="background-color:#f2f2f2;">
	<div class="layui-row">
		<div class="layui-col-md12">
			<ul class="layui-nav">
			  <li class="layui-nav-item">
			  	<a href="">无线卡管理</a>
			  	 <dl class="layui-nav-child">
			      <dd><a href="">无线通信卡台账</a></dd>
			      <dd><a href="">流量监视</a></dd>
			      <dd><a href="">状态监视</a></dd>
			      <dd><a href="">流程管理</a></dd>
			      <dd><a href="">GIS展示</a></dd>
			      <dd><a href="">位置监视</a></dd>
			    </dl>
			  </li>
			  
			  <li class="layui-nav-item">
			    <a href="javascript:;">接入设备</a>
			    <dl class="layui-nav-child">
			      <dd><a href="">终端台账管理</a></dd>
			      <dd><a href="">新设备入网</a></dd>
			      <dd><a href="">告警管理</a></dd>
			      <dd><a href="">性能监视</a></dd>
			      <dd><a href="">状态监视</a></dd>
			      <dd><a href="">远程控制</a></dd>
			    </dl>
			  </li>
			  <li class="layui-nav-item">
			    <a href="javascript:;">统计分析</a>
			    <dl class="layui-nav-child">
			      <dd><a href="">流量统计分析</a></dd>
			      <dd><a href="">状态统计分析</a></dd>
			      <dd><a href="">无线通信卡统计</a></dd>
			      <dd><a href="">通信终端统计</a></dd>
			      <dd><a href="">告警统计分析</a></dd>
			      <dd><a href="">资费统计</a></dd>
			      <dd><a href="">故障分析</a></dd>
			    </dl>
			  </li>
			   <li class="layui-nav-item">
			    <a href="javascript:;">高级应用</a>
			    <dl class="layui-nav-child">
			      <dd><a href="">大屏展示接口</a></dd>
			      <dd><a href="">重要场景保障监视</a></dd>
			      <dd><a href="">终端预警</a></dd>
			      <dd><a href="">区域隐患预警</a></dd>
			    </dl>
			  </li>
			   <li class="layui-nav-item">
			    <a href="javascript:;">系统管理</a>
			    <dl class="layui-nav-child">
			      <dd><a href="">部门管理</a></dd>
			      <dd><a href="">角色管理</a></dd>
			      <dd><a href="">权限管理</a></dd>
			      <dd><a href="">用户管理</a></dd>
			      <dd><a href="">日志管理</a></dd>
			    </dl>
			  </li>
			   <li class="layui-nav-item" style="float: right;">
			  	<a href="${re.contextPath}/main"><i class="layui-icon" >&#xe68e;</i>&nbsp;进入系统</a>
			  </li>
			</ul>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md4" style="margin-right: 1%;margin-top: 1%;">
			<div class="layui-card">
			   <div class="layui-card-header"><i class="layui-icon" style="color:#00A0B5 ">&#xe63c</i><font color="#00A0B5" size="2">日卡统计</div>
			     <div class="layui-card-body" style="height: 550px;overflow: auto;">
	                <div carousel-item="">
	                  <ul class="layui-row layui-col-space10 layui-this"style="text-align: center;">
	                    <li class="layui-col-xs12" >
	                      <a lay-href="app/content/comment" class="layadmin-backlog-body" >
	                        <h3>总卡数</h3>
	                        <p><cite>88325</cite></p>
	                      </a>
	                    </li>
	                    <li class="layui-col-xs6">
	                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
	                        <h3>0流量卡数</h3>
	                        <p><cite>3000</cite></p>
	                      </a>
	                    </li>
	                    <li class="layui-col-xs6">
	                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
	                        <h3>超流量卡数</h3>
	                        <p><cite>2000</cite></p>
	                      </a>
	                    </li>
	                    <li class="layui-col-xs4" >
	                      <a lay-href="app/forum/list" class="layadmin-backlog-body">
	                        <h3>移动卡数量</h3>
	                        <p><cite>89325</cite></p>
	                      </a>
	                      
	                    </li>
	                       <li class="layui-col-xs4" >
	                      <a lay-href="app/forum/list" class="layadmin-backlog-body">
	                        <h3>联通卡数量</h3>
	                        <p><cite>87325</cite></p>
	                      </a>
	                      
	                    </li> 
	                     <li class="layui-col-xs4" >
	                      <a lay-href="app/forum/list" class="layadmin-backlog-body">
	                        <h3>电信卡数量</h3>
	                        <p><cite>86325</cite></p>
	                      </a>
	                      
	                    </li>
	                    <li class="layui-col-xs4" >
	                      <a lay-href="app/forum/list" class="layadmin-backlog-body">
	                        <h3>停机</h3>
	                        <p><cite>89325</cite></p>
	                      </a>
	                      
	                    </li>
	                       <li class="layui-col-xs4" >
	                      <a lay-href="app/forum/list" class="layadmin-backlog-body">
	                        <h3>在线</h3>
	                        <p><cite>87325</cite></p>
	                      </a>
	                      
	                    </li> 
	                     <li class="layui-col-xs4" >
	                      <a lay-href="app/forum/list" class="layadmin-backlog-body">
	                        <h3>不在线</h3>
	                        <p><cite>86325</cite></p>
	                      </a>
	                      
	                    </li>
	                     <li class="layui-col-xs4">
	                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
	                        <h3>配网卡数量</h3>
	                        <p><cite>1000</cite></p>
	                      </a>
	                    </li>
	                     <li class="layui-col-xs4">
	                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
	                        <h3>负控</h3>
	                        <p><cite>2000</cite></p>
	                      </a>
	                    </li>
	                     <li class="layui-col-xs4">
	                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
	                        <h3>集抄</h3>
	                        <p><cite>2000</cite></p>
	                      </a>
	                    </li>
	                     <li class="layui-col-xs3" >
	                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
	                        <h3>配度</h3>
	                        <p><cite style="font-size: 20px;">2000</cite></p>
	                      </a>
	                    </li>
	                     <li class="layui-col-xs3">
	                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
	                        <h3>充电桩</h3>
	                        <p><cite style="font-size: 20px;">2000</cite></p>
	                      </a>
	                    </li>
	                     <li class="layui-col-xs3">
	                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
	                        <h3>输电监测</h3>
	                        <p><cite style="font-size: 20px;">2000</cite></p>
	                      </a>
	                    </li>
	                    <li class="layui-col-xs3">
	                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
	                        <h3>电压监测</h3>
	                        <p><cite style="font-size: 20px;">2000</cite></p>
	                      </a>
	                    </li>
	                  </ul>
	                </div>
	     	 </div>
			</div>
		</div>
		<div class="layui-col-md4" style="background-color: #ffffff;margin-right: 1%;margin-top: 1%;">
			<div class="layui-card"  >
			        <div class="layui-card-header" ><i class="layui-icon" style="color:#00A0B5 ">&#xe715;</i> <font color="#00A0B5" size="2">地图</font> </div>
			        <div class="layui-card-body" style="height: 550px;" >
			        	<div id="main5" style="height:100%;width: 100%"></div>
	       		 	</div>
	     	 </div>
		</div>
	<div class="layui-col-md3" style="background-color: #ffffff;width: 30%;margin-top: 1%;">
		<div class="layui-card" >
	        <div class="layui-card-header" ><i class="layui-icon" style="color:#00A0B5 ">&#xe623;</i> <font color="#00A0B5" size="2">设备</font> </div>
	        <div class="layui-card-body" style="height:550px;">
	        <div class="layui-row" >
	        <div class="layui-col-xs3" id="layadmin-shortcut" style="height: 100px;margin-right: 1%;margin-top: 2%;">
                  <a lay-href="#">
                    <i class="layui-icon layui-icon-user layui-bg-orange" ></i>
                  </a>
	        </div>
	        	<div class="layui-col-md7">
		        	<ul class="ulcc" style="color: #FFB800;height: 100px;width:120%" >
		        		<li style="line-height:30px;" id="1"><span class="cccc">总数：10000</span></li>
						<li style="line-height:30px" id="2"><span class="cccc">配网自动化：5000</span></li>
						<li style="line-height:30px" id="3"><span class="cccc">输电检测：3000</span></li>
						<li style="line-height:30px" id="3"><span class="cccc">充电桩：2000</span></li>
						<li style="line-height:30px" id="3"><span class="cccc">计量：1000</span></li>
						<li style="line-height:30px" id="3"><span class="cccc">电压：1000</span></li>
		        	</ul>
	        	</div>
	        </div>
	        <div class="layui-row" >
	        	<hr class="layui-bg-blue">
	        </div>
			 <div class="layui-row">
				 <div class="layui-col-xs3" id="layadmin-shortcut" style="height: 100px;margin-right: 1%;margin-top: 4%;">
                  <a lay-href="#">
                    <i class="layui-icon layui-icon-chart layui-bg-red" ></i>
                  </a>
	        	</div>
				 <div class="layui-col-md6" style="margin-top: 1%;">
					<ul class="ulcc" style="color: rgb(251,47,111);height: 130px;width:120%">
		        		<li style="line-height:30px" id="1"><span class="cccc">告警数：10000</span></li>
						<li style="line-height:30px" id="2"><span class="cccc">紧急：5000</span></li>
						<li style="line-height:30px" id="3"><span class="cccc">重要：3000</span></li>
						<li style="line-height:30px" id="3"><span class="cccc">一般：3000</span></li>
						<li style="line-height:30px" id="3"><span class="cccc">正常：3000</span></li>
						<li style="line-height:30px" id="3"><span class="cccc">信号强度：3000</span></li>
						<li style="line-height:30px" id="3"><span class="cccc">信噪比：3000</span></li>
		        	</ul>
		        </div>
	         </div>
	          <div class="layui-row" >
	        	<hr class="layui-bg-blue">
	        </div>
			 <div class="layui-row">
				 <div class="layui-col-xs3" id="layadmin-shortcut" style="height: 100px;margin-right: 2%;margin-top: 2%;">
                  <a lay-href="#">
                    <i class="layui-icon layui-icon-home" style="background-color: #009688;color: #fff"></i>
                  </a>
	        	</div>
				 <div class="layui-col-md6" style="margin-top: 2%;">
				   <div carousel-item="">
	                  <ul class="layui-row layui-col-space10 layui-this" style="text-align: center;">
	                    <li class="layui-col-xs12">
	                      <a lay-href="app/content/comment" class="layadmin-backlog-body" >
	                        <h3>小区ID</h3>
	                        <p><cite>10000</cite></p>
	                      </a>
	                    </li>
		        	</ul>
		        </div>
	         </div>
      		 </div>
     	 </div>
	</div>
</div>
<div class="layui-row" >
<div class="layui-col-md12" >
	<div class="layui-col-md6" id="bbb" style="background-color: #ffffff;margin-right: 1%;height: 100%">
		<div class="layui-carousel" id="test2" style="height:265px;">
		  <div carousel-item id="aaa" style="height: 100%;background-color: #ffffff">
		     <div id="u3_div"></div>
		     <div id="u2_div"></div>
		  </div>
		</div>
	</div>
	<div class="layui-col-md5"  style="background-color: #ffffff;height: 100%;width: 47.5%">
		<div class="layui-carousel" id="test1" style="height:225px;">
		  <div carousel-item id="aaa" style="height: 100%;background-color: #ffffff">
		     <div id="u216_div"></div>
		     <div id="u217_div"></div>
		  </div>
		</div>
	</div>	
	<!-- <div class="layui-col-md3"  style="background-color: #f2f2f2;width: 22%;height: 100%">
	  <div class="layui-row"  >
	   <div class="layui-col-md12">
		<div class="layui-card" style="height: 125px;">
	        <div class="layui-card-header">
	       	   总用户
	          <span class="layui-badge layui-bg-orange layuiadmin-badge">月</span>
	        </div>
	        <div class="layui-card-body layuiadmin-card-list">
	
	          <p class="layuiadmin-big-font">66,666</p>
	          <p>
        	    总计访问量 
         	   <span class="layuiadmin-span-color" style="position: absolute;right: 15px;">88万 <i class="layui-icon"></i></span>
        	  </p>
	        </div>
	        </div>
		 </div>
		</div>
		<div class="layui-row" >
		  <div class="layui-col-md12" style="margin-top: 1%">
			<div class="layui-card" style="height: 120px;">
		        <div class="layui-card-header">
		       	   在线用户
		          <span class="layui-badge layui-bg-orange layuiadmin-badge">月</span>
		        </div>
		        <div class="layui-card-body layuiadmin-card-list">
		
		          <p class="layuiadmin-big-font">100</p>
		          <p>
		      	       当前用户：admin
		            <span style="position: absolute;right: 15px;" class="layuiadmin-span-color"><i class="layui-icon"></i></span>
		          </p>
		        </div>
			 </div>
		  </div>
		</div>
	</div> -->
</div>
	 <div style="display: none;" id="tck">
		<ul  style="color: #ffffff;height: 130px;width: 170px;">
			<li style="line-height:30px;" id="3"><span class="cccc" >设备在线率：70%</span></li>
       		<li style="line-height:30px;" id="1"><span class="cccc" style="margin-left: 35px;">设备数：10000</span></li>
			<li style="line-height:30px;" id="2"><span class="cccc" style="margin-left: 35px;">卡数：5000</span></li>
			<li style="line-height:30px;" id="3"><span class="cccc" style="margin-left: 20px;">告警数：3000</span></li>
       	</ul>
     </div>
</div>
 <script type="text/javascript">
 var layer
 layui.use('layer', function(){ //独立版的layer无需执行这一句
	   layer = layui.layer;
 });
	 layui.use('carousel', function(){
		  var carousel = layui.carousel;
		  var carousel1 = layui.carousel;
		  //建造实例
		  carousel.render({
		    elem: '#test1'
		    ,width: '100%' //设置容器宽度
		    ,arrow: 'always' //始终显示箭头
		    //,anim: 'updown' //切换动画方式
		  });
		  carousel1.render({
			    elem: '#test2'
			    ,width: '100%' //设置容器宽度
			    ,arrow: 'always' //始终显示箭头
			    ,autoplay:false
			    //,anim: 'updown' //切换动画方式
			  });
		});
	 layui.use('element', function(){
		  var element = layui.element;
		});
	function shuaxin() {
	//	alert(top.$("#container").find("iframe").attr('src'));
		window.location.reload();
	}
	</script>
</body>
<script>
$(function(){
	lunbo();
	lunbo2();
	doquery5();
	lunbo3();
	shiyan();
});
function shiyan() {
	var dom = document.getElementById("u2_div");
	 dom.style.width = $("#aaa").width()+ 'px';
	 dom.style.height = $("#aaa").height()+ 'px';
	var myChart = echarts.init(dom);

	option = null;
	option = {
	    title: {
	    	text: '服务性能',
	        textStyle: {
		        	fontSize:12,              //标题颜色
		        	color: '#FFFFFF'
		      	},
		      	backgroundColor:'rgb(0,160,181)',
		      	borderColor:'rgb(0,160,181)',//标题边框颜色
				borderWidth:1,//标签线框
				borderRadius:5,//边框切圆角
				top:'20px',//组件离上边的距离middle,top,bottom*/ //此二者的优先级高于x吗?答案：是
	        	left:'10px'
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    xAxis: {
	        type: 'category',
	        boundaryGap: false,
	        data: ['09:42:30','09:42:32','09:42:34','09:42:36','09:42:38','09:42:42','09:42:44','09:42:46','09:42:48','09:42:50','09:42:52'
	               ,'09:42:54','09:42:56','09:42:58','09:42:60','09:42:62','09:42:64','09:42:66'],
			axisLabel: {
                show: true,
                textStyle: {
                    color: '#00A0B5'
                }
            },
	    },
	    yAxis: {
	        type: 'value',
			axisLabel : {
			   textStyle: {
		           color: '#00A0B5'
		       }
		    }
	    },
		
	    series: [
	        {
	            name:'CPU',
	            type:'line',
	            stack: '占比',
	            data:[0, 35, 30, 31, 35, 25, 10,25,35,33,30,10,33,30,25,10,25,35,33,30,10]
	        },
	        {
	            name:'内存',
	            type:'line',
	            stack: '总量',
	            data:[25, 18, 19, 23, 29, 33, 31,35,20,12,32,10,33,30,10,33,31,35,33,30,10]
	        },
	        {
	            name:'磁盘',
	            type:'line',
	            stack: '总量',
	            data:[25, 18, 19, 23, 29, 33, 31,35,20,12,32,10,33,30,10,33,31,35,33,30,10]
	        }
	    ]
	};

	    myChart.setOption(option);
}
function hexing() {
	//第二个
    var dom = document.getElementById("u4_div");
    var myChart = echarts.init(dom);
    dom.style.width = $(".layui-col-md3").clientWidth + 'px';
    option = null;
    var app = {};
    option = null;
    var posList = [
        'left', 'right', 'top', 'bottom',
        'inside',
        'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
        'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
    ];

    app.configParameters = {
        rotate: {
            min: -90,
            max: 90
        },
        align: {
            options: {
                left: 'left',
                center: 'center',
                right: 'right'
            }
        },
        verticalAlign: {
            options: {
                top: 'top',
                middle: 'middle',
                bottom: 'bottom'
            }
        },
        position: {
            options: echarts.util.reduce(posList, function (map, pos) {
                map[pos] = pos;
                return map;
            }, {})
        },
        distance: {
            min: 0,
            max: 100
        }
    };

    app.config = {
        rotate: 90,
        align: 'left',
        verticalAlign: 'middle',
        position: 'insideBottom',
        distance: 15,
        onChange: function () {
            var labelOption = {
                normal: {
                    rotate: app.config.rotate,
                    align: app.config.align,
                    verticalAlign: app.config.verticalAlign,
                    position: app.config.position,
                    distance: app.config.distance
                }
            };
            myChart.setOption({
                series: [{
                    label: labelOption
                }, {
                    label: labelOption
                }, {
                    label: labelOption
                }, {
                    label: labelOption
                }]
            });
        }
    };


    var labelOption = {
        normal: {
            show: true,
            position: app.config.position,
            distance: app.config.distance,
            align: app.config.align,
            verticalAlign: app.config.verticalAlign,
            rotate: app.config.rotate,
            formatter: '{c}  {name|{a}}',
            fontSize: 12,
            rich: {
               
            }
        }
    };

    option = {
    	title: {
    	    	text: '设备在线率',
    	        textStyle: {
    		        	fontSize:12,              //标题颜色
    		        	color: '#FFFFFF'
    		      	},
    		      	backgroundColor:'rgb(0,160,181)',
    		      	borderColor:'rgb(0,160,181)',//标题边框颜色
    				borderWidth:1,//标签线框
    				borderRadius:5,//边框切圆角
    				top:'20px',//组件离上边的距离middle,top,bottom*/ //此二者的优先级高于x吗?答案：是
    	        	left:'10px'
    	  },	
        color: [ '#F17B22', '#18EED3', '#D6F065'],
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
    	grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        legend: {
            data: ['CPU', 'SMF', 'UDF'],
            itemWidth: 25,
	        itemHeight: 5,
	        itemGap: 8,
	        textStyle: {
		        	fontSize:8,              //标题颜色
		        	color: '#00cad8'
		      	},
	        
	        orient: 'horizontal',  //垂直显示
	        y: 'top',    //延Y轴居中
	        x: 'right' //居右显示
        },
        
        calculable: true,
        xAxis: [
            {
                type: 'category',
                axisTick: {show: false},
                data: ['友方', '苪智', '韦德','沅鹏','中移物联'],
    			axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#00A0B5'
                    }
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
    			axisLabel : {
		    	   textStyle: {
		               color: '#00A0B5'
		         }
		    	}
            },
    		
        ],
        series: [
            
            {
                name: '告警数',
                type: 'bar',
                barWidth : 10,
                data: [40, 50, 30,40, 30],
                itemStyle: {
                            //柱形图圆角，鼠标移上去效果
                            emphasis: {
                                barBorderRadius: [20, 20, 20, 20]
                            },
                             
                            normal: {
                                //柱形图圆角，初始化效果
                                barBorderRadius:[20, 20, 20, 20]
                            }
                        },
    					
            }
        ]
    };

    myChart.setOption(option);
}
function lunbo2() {
	//第三个
    var dom = document.getElementById("u217_div");
    dom.style.width = $("#aaa").width()+ 'px';
    dom.style.height = $("#aaa").height()+ 'px';
    var myChart = echarts.init(dom);
    option = null;
    var app = {};
    option = null;
    var posList = [
        'left', 'right', 'top', 'bottom',
        'inside',
        'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
        'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
    ];

    app.configParameters = {
        rotate: {
            min: -90,
            max: 90
        },
        align: {
            options: {
                left: 'left',
                center: 'center',
                right: 'right'
            }
        },
        verticalAlign: {
            options: {
                top: 'top',
                middle: 'middle',
                bottom: 'bottom'
            }
        },
        position: {
            options: echarts.util.reduce(posList, function (map, pos) {
                map[pos] = pos;
                return map;
            }, {})
        },
        distance: {
            min: 0,
            max: 100
        }
    };

    app.config = {
        rotate: 90,
        align: 'left',
        verticalAlign: 'middle',
        position: 'insideBottom',
        distance: 15,
        onChange: function () {
            var labelOption = {
                normal: {
                    rotate: app.config.rotate,
                    align: app.config.align,
                    verticalAlign: app.config.verticalAlign,
                    position: app.config.position,
                    distance: app.config.distance
                }
            };
            myChart.setOption({
                series: [{
                    label: labelOption
                }, {
                    label: labelOption
                }, {
                    label: labelOption
                }, {
                    label: labelOption
                }]
            });
        }
    };


    var labelOption = {
        normal: {
            show: true,
            position: app.config.position,
            distance: app.config.distance,
            align: app.config.align,
            verticalAlign: app.config.verticalAlign,
            rotate: app.config.rotate,
            formatter: '{c}  {name|{a}}',
            fontSize: 12,
            rich: {
               
            }
        }
    };

    option = {
    	title: {
    	    	text: '卡流量',
    	        textStyle: {
    		        	fontSize:12,              //标题颜色
    		        	color: '#FFFFFF'
    		      	},
    		      	backgroundColor:'rgb(0,160,181)',
    		      	borderColor:'rgb(0,160,181)',//标题边框颜色
    				borderWidth:1,//标签线框
    				borderRadius:5,//边框切圆角
    				top:'20px',//组件离上边的距离middle,top,bottom*/ //此二者的优先级高于x吗?答案：是
    	        	left:'10px'
    	  },	
        color: [ '#F17B22', '#18EED3', '#D6F065'],
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
    	grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        
        calculable: true,
        xAxis: [
            {
                type: 'category',
                axisTick: {show: false},
                data: ['移动', '联通', '电信'],
    			axisLabel: {
                                show: true,
                                textStyle: {
                                    color: '#666'
                                }
                            }
            }
        ],
        yAxis: [
            {
                type: 'value',
    			axisLabel : {
		    	   textStyle: {
		               color: '#D6F065'
		         }
		    	}
            },
    		
        ],
        series: [
            
            {
                name: '告警数',
                type: 'bar',
                barWidth : 30,
                data: [4000, 5000, 3000],
                itemStyle: {
                            //柱形图圆角，鼠标移上去效果
                            emphasis: {
                                barBorderRadius: [20, 20, 20, 20]
                            },
                             
                            normal: {
                                //柱形图圆角，初始化效果
                                barBorderRadius:[20, 20, 20, 20],
                                color: function(params) { 
                                    var colorList = ['#C33531','#EFE42A','#64BD3D','#EE9201','#29AAE3', '#B74AE5','#0AAF9F','#E89589','#16A085','#4A235A','#C39BD3 ','#F9E79F','#BA4A00','#ECF0F1','#616A6B','#EAF2F8','#4A235A','#3498DB' ]; 
                                    return colorList[params.dataIndex] 
                                }
                            }
                        },
    					
            }
        ]
    };

    myChart.setOption(option);
}
function lunbo() {
	var dom = document.getElementById("u216_div");
	  dom.style.width = $("#aaa").width()+ 'px';
	  dom.style.height = $("#aaa").height()+ 'px';
	var myChart = echarts.init(dom);
	var app = {};
	option = null;

	option = {
		    title : {
		        text: '终端告警数统计',
		        subtext: '告警数',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: ['友方','苪智','韦德','沅鹏','中移物联']
		    },
		    series : [
		        {
		            name: '告警量',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		                {value:335, name:'友方'},
		                {value:310, name:'苪智'},
		                {value:234, name:'韦德'},
		                {value:135, name:'沅鹏'},
		                {value:1548, name:'中移物联'}
		            ],
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }
		    ]
		};

	    myChart.setOption(option);
}
function doquery5(){
      $.get('${re.contextPath}/plugin/common/js/guangzou.json', function (yCjson) {
      echarts.registerMap('广州', yCjson);
      var chart = echarts.init(document.getElementById('main5'));
      
      option5 = {
          tooltip: {
	            trigger: 'item',
	          formatter: '{b}<br/>在线率{c}%'
          	//formatter:function(params)//数据格式
              //{
              //var relVal = params.name+"<br/>";
              //return relVal;
              //}
	        },
        
	        dataRange: {
	            x: 'left',
	            y: 'bottom',
	            min:0,
          	max:100,
	            textStyle:{color:"#666"},
	            splitList: [
	                {start: 90, end: 100,color: '#009688'},
	                {start: 70, end: 89.99, color: 'rgb(255,184,0)'},
	                {start: 0, end: 69.99,  color: 'rgb(213,58,53)'},
	            ],
	        },
          series:[
          	{
          		name:'设备在线率',
          		type:'map',
          		map:'广州',
          		zoom: 1.2,
          		mapLocation:{
          			  x: 'center'
          		},
          		 label: { 
		                normal: {show: true,
		                	}, 
		                emphasis: {show: true,
		                	 textStyle:{color:"#fff"},
		                	} 
		            },
		           itemStyle: {
			         normal: {
			             label: {
			                 show: true,
			                 formatter:'{c}',
			                 color:"#fff"
			             },
			            	 borderWidth:2,
			            	 borderColor:'#9A9A9A',
			             },
			             emphasis: {// 也是选中样式
			                    borderWidth:1,
			                    areaColor: 'rgba(128, 128, 128, 0.1)',
			                    label: {
			                        show: true,
			                        textStyle: {
			                            color: '#fff'
			                        }
			                    }
			                 }

			         }, 
          		data:  [{name: '天河区', value: 97},
		                {name: '海珠区', value: 77},
		                {name: '萝岗区', value: 86},
		                {name: '黄埔区', value: 72},
		                {name: '白云区', value: 95},
		                {name: '越秀区', value: 89},
		                {name: '荔湾区', value: 59},
		                {name: '番禺区', value: 90},
		                {name: '花都区', value: 64},
		                {name: '从化市', value: 91},
		                {name: '南沙区', value: 49},
		                {name: '增城市', value: 58}]
			         ,
          	}
          ],
          
      };
      chart.setOption(option5);
      chart.on('click', function (params) { 
    	  var tckhtml=$("#tck").html();
    	  layer.msg(tckhtml, {
  	        time: 20000, //20s后自动关闭
  	        btn: ['确定', '取消']
  	      });
      });
	})
}
function lunbo3() {
	//第三个
    var dom = document.getElementById("u3_div");
    dom.style.width = $("#aaa").width()+ 'px';
    dom.style.height = $("#aaa").height()+ 'px';
    var myChart = echarts.init(dom);
    option = {
    	    title: {
    	    	text: 'XXX服务性能',
    	        textStyle: {
    		        	fontSize:12,              //标题颜色
    		        	color: '#FFFFFF'
    		      	},
    		      	backgroundColor:'rgb(0,160,181)',
    		      	borderColor:'rgb(0,160,181)',//标题边框颜色
    				borderWidth:1,//标签线框
    				borderRadius:5,//边框切圆角
    				top:'20px',//组件离上边的距离middle,top,bottom*/ //此二者的优先级高于x吗?答案：是
    	        	left:'10px'
    	    },
            tooltip: {
                trigger: 'axis'
            },
            xAxis: {
            	 data: ['09:42:30','09:42:32','09:42:34','09:42:36','09:42:38','09:42:42','09:42:44','09:42:46','09:42:48','09:42:50','09:42:52'
     	               ,'09:42:54','09:42:56','09:42:58','09:42:60','09:42:62','09:42:64','09:42:66']
            },
            yAxis: {
                splitLine: {
                    show: false
                }
            },
            visualMap: {
                top: 10,
                right: 5,
                pieces: [{
                    gt: 0,
                    lte: 30,
                    color: '#096'
                }, {
                    gt: 30,
                    lte: 50,
                    color: '#ffde33'
                }, {
                    gt: 50,
                    lte: 100,
                    color: '#cc0033'
                }],
                outOfRange: {
                    color: '#999'
                }
            },
            series:[
 	        {
 	            name:'CPU',
 	            type:'line',
 	            stack: '占比',
 	            data:[0, 35, 30, 31, 35, 25, 10,25,35,33,30,10,33,30,25,10,25,35,33,30,10],
 	            markLine: {
                   silent: true,
                   data: [{
                       yAxis: 50
                   }, {
                       yAxis: 100
                   }, {
                       yAxis: 150
                   }, {
                       yAxis: 200
                   }, {
                       yAxis: 300
                   }]
                }
 	        },
 	        {
 	            name:'内存',
 	            type:'line',
 	            stack: '总量',
 	            data:[25, 18, 19, 23, 29, 33, 31,35,20,12,32,10,33,30,10,33,31,35,33,30,10],
 	            markLine: {
                   silent: true,
                   data: [{
                       yAxis: 50
                   }, {
                       yAxis: 100
                   }, {
                       yAxis: 150
                   }, {
                       yAxis: 200
                   }, {
                       yAxis: 300
                   }]
                }
 	        }
 	        ,
 	        {
 	            name:'磁盘',
 	            type:'line',
 	            stack: '总量',
 	            data:[25, 18, 19, 23, 29, 33, 31,35,20,12,32,10,33,30,10,33,31,35,33,30,10],
 	            markLine: {
                   silent: true,
                   data: [{
                       yAxis: 50
                   }, {
                       yAxis: 100
                   }, {
                       yAxis: 150
                   }, {
                       yAxis: 200
                   }, {
                       yAxis: 300
                   }]
                }
 	        }
 	    ]
        };

    myChart.setOption(option);
}
    </script>
</html>
