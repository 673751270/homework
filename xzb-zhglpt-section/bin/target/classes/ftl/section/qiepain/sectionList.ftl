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
          <link rel="stylesheet" href="${re.contextPath}/plugin/layui/css/layui.css">
    <link rel="stylesheet" href="${re.contextPath}/plugin/common/css/qiepian.css">
        <link rel="stylesheet" href="${re.contextPath}/plugin/common/css/lifang.css">
  <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="${re.contextPath}/plugin/layui/layui.all.js"
          charset="utf-8"></script>
  <script type="text/javascript" src="${re.contextPath}/plugin/tools/tool.js"></script>
  <script type="text/javascript" src="${re.contextPath}/plugin/common/js/echarts.js"></script>
<style>
 .layui-layer-dir {
    box-shadow: none;
    border: 1px solid #d2d2d2;
}
.site-dir1 li {
    line-height: 26px;
}
.container ul li{
		z-index: 5;
	    display: block;
	    height: 30px;
	    line-height: 35px;
	    border-radius: 4px;
		margin: 0;
		padding: 0;
		list-style: none;
	    margin-bottom:10px;
		-moz-user-select: none;
	    user-select: none;
	    text-indent: 10px;
	    color: #555;
	}
	.container ul li span{
		color:#666;
		font-size: 12px;
	}
	.contul{
		width: 180px;
	    height:280px;
	    padding: 15px;
		display: block;
		float: left;
	    border-radius: 5px;
	}
   .tariffCards > div:hover {
	  	border:solid 5px rgb(148,159,75);
	    cursor: pointer;
	    /*	 border:5px solid #44bfff;*/
	 	border-radius:25px;
	 	box-shadow:0 0 8px rgb(148,159,75);
	 	-moz-box-shadow:0 0 8px rgb(148,159,75);
	 	-webkit-box-shadow:0 0 8px rgb(148,159,75);
	}
	table th{
		background-color:#00A0B5;
		color: #ffffff;
	}
</style>
</head>

<body style="background-color:#f2f2f2;">
<div class="layui-fluid">
	<div class="layui-row">
		<div class="layui-col-md12">
			<div style="float: right;"><button class="layui-btn layui-btn-sm  layui-btn-normal" onclick="shuaxin();">取消</button>
				<button class="layui-btn layui-btn-sm ">提交</button></div>
		</div>
	</div>
<div class="layui-row">
	<div  class="container" style="height: 100%;">
		<div class="layui-col-md3" style="margin-right: 20px">
			<div class="layui-card" >
			        <div class="layui-card-header" style=""><font color="#666" size="2">序列号
			        &nbsp;&nbsp;&nbsp;&nbsp;项目名称</font> </div>
			        <div class="layui-card-body" style="height: 280px;">
			        <ul >
						<li style="line-height:30px" id="1"><span>1</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cccc">深圳111项目</span></li>
						<li style="line-height:30px" id="2"><span>2</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cccc">深圳222项目</span></li>
						<li style="line-height:30px" id="3"><span>3</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cccc">深圳333项目</span></li>
						<li style="line-height:30px" id="4"><span>4</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cccc">深圳444项目</span></li>
						<li style="line-height:30px" id="5"><span>5</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cccc">深圳555项目</span></li>
						<li style="line-height:30px" id="6"><span>6</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cccc">深圳666项目</span></li>
					</ul>
	       		 </div>
	     	 </div>
		</div>
		<ul >
		<div class="layui-col-md5" style="background-color: #ffffff;margin-right: 15px">
			<div class="layui-card" >
			        <div class="layui-card-header" ><i class="layui-icon" style="color:#00A0B5 ">&#xe656;</i> <font color="#00A0B5" size="2">切片</font> </div>
			        <div class="layui-card-body" style="height: 280px;overflow-y:auto;" >
			        	<div class="tariffCards" style="text-align: center; ">
						    <div class="economy" id="economy"></div>
						    <div class="premiumeconomy" id="premiumeconomy"></div>
						    <div class="first">
						  	 	<div class="cross" onclick="test();"></div>
						    </div>
						</div>
	       		 	</div>
	     	 </div>
		</div>
		</ul>
	</div>
	<div class="layui-col-md3" style="background-color: #ffffff;width: 30%">
		<div class="layui-card" >
	        <div class="layui-card-header" ><i class="layui-icon" style="color:#00A0B5 ">&#xe623;</i> <font color="#00A0B5" size="2">动作</font> </div>
	        <div class="layui-card-body" style="height: 280px; overflow: auto;">
	        	<ul  id="centhtml">
	        	</ul>
      		 </div>
     	 </div>
	</div>
	<div id="sss" style="display: none">
		<li style="float: left;width: 50px;padding-top: 18px;">
		<div style="transform: rotateZ(-45deg) rotateY(65deg);" id="ssb" data-id="" onclick="test1(this);">
			<div class="box">
			  <div class="front" id="front">
			  </div>
			  <div class="left" id="left">
			  </div>
			  <div class="back" id="back">
			  </div>
			  <div class="right" id="right">
			  </div>
			  <div class="top" id="top">
			  </div>
			  <div class="bottom" id="bottom">
			  </div>
			</div>
		</div>
		</li>
	</div>
	<div class="layui-row">
	<div class="layui-col-md11.5" style="margin-top:10px;margin-bottom:10px; overflow: auto;background-color: #ffffff">
		<div class="layui-card" >
		        <div class="layui-card-header" ><i class="layui-icon" style="color:#00A0B5 ">&#xe62d;</i> <font color="#00A0B5" size="2">详细列表</font> </div>
		        <div class="layui-card-body" style="height:440px;" >
			        <table class="layui-table">
					  <thead>
					    <tr>
					       <th>切片模板id</th>
					       <td id="moban">1</td>
					    </tr> 
					     <tr>
					       <th>行业客户</th>
					       <td>人工设定，电网/水利/医疗</td>
					    </tr>
					    <tr>
					       <th>运营商标识</th>
					       <td>系统自动分配</td>
					    </tr>
					      <tr>
					       <th>网络选择标识符</th>
					       <td>系统分配</td>
					    </tr>
					    <tr>
					       <th>切片基本信息</th>
					       <td>每小时最大请求数，数据包大小等，由接口获取，再根据在线率转换确定</td>
					    </tr>
					    <tr>
					       <th>最大终端连接数</th>
					       <td>由接口获取，根据卡数确定</td>
					    </tr>
					    <tr>
					       <th>服务区域</th>
					       <td>经纬度区域范围，根据接口区域字段确定</td>
					    </tr>
					    <tr>
					       <th>游牧性</th>
					       <td>接口获取，高、中、低</td>
					    </tr>
					    <tr>
					       <th>隔离程度</th>
					       <td>物理隔离/逻辑隔离</td>
					    </tr>
					      <tr>
					       <th>保障级别</th>
					       <td>高/中/低</td>
					    </tr>
					      <tr>
					       <th>切片类型</th>
					       <td>EMBB/URLLC</td>
					    </tr>
					  </thead>
					</table>
       			 </div>
     	 </div>
	</div>
	</div>
</div>
<div class="layui-row">
<div class="layui-col-md13">
	<div class="layui-col-md6"  style="background-color: #ffffff;margin-right: 10px;">
		<div id="u2_div" style="height:240px;"></div>
	</div>
	<div class="layui-col-md5"  style="background-color: #ffffff;width: 49%">
		<div id="u4_div" style="height:240px;"></div>
	</div>
	</div>
</div>
</div>
 <script type="text/javascript">
	$(function(){
	    //出入允许拖拽节点的父容器，一般是ul外层的容器
	    drag.init('container');
	
	});
	function test1(e) {
		$("#moban").html($(e).data("id"));
	}
	function shuaxin() {
	//	alert(top.$("#container").find("iframe").attr('src'));
		window.location.reload();
	}
	var indexr=2;
	var index_id='';
	var xmmc='';
	function test() {
			var testlengh=$(".premiumeconomy").length;
			indexr=indexr-1;
			$(".premiumeconomy:eq("+(testlengh-1)+")").after('<div class="premiumeconomy" id="premiumeconomy'+testlengh+'"> </div>')
		}
	/** 拖拽功能实现原理和说明：
	
	1、说明：拖拽实现一般有两种方式，一种是使用html的新特性dragable，但是由于在火狐浏览器上dragable每拖拽一次会打开一个新的标签，
	尝试阻止默认行为和冒泡都无法解决，所以使用第二种方法来实现拖拽。第二种方法是使用js监听鼠标三个事件，配合节点操作来实现。
	
	2、实现原理：
	    01-在允许拖拽的节点元素上，使用on来监听mousedown(按下鼠标按钮)事件，鼠标按下后，克隆当前节点
	    02-监听mousemove(鼠标移动)事件，修改克隆出来的节点的坐标，实现节点跟随鼠标的效果
	    03-监听mouseup(放开鼠标按钮)事件，将原节点克隆到鼠标放下位置的容器里，删除原节点，拖拽完成。
	
	3、优势：
	    01-可动态添加允许拖拽的节点(因为使用了on委托事件)
	    02-可获取到原节点，跟随节点，目标节点的对象，可根据需要进行操作。
	    03-使用js实现，兼容性好。
	**/
	
	
	//拖拽
	var drag = {
	
	    class_name : null,  //允许放置的容器
		permitDrag : false,	//是否允许移动标识
	
		_x : 0,             //节点x坐标
	    _y : 0,			    //节点y坐标
	    _left : 0,          //光标与节点坐标的距离
	    _top : 0,           //光标与节点坐标的距离
	
	    old_elm : null,     //拖拽原节点
	    tmp_elm : null,     //跟随光标移动的临时节点
	    new_elm : null,     //拖拽完成后添加的新节点
	
	    //初始化
	    init : function (className){
	
	        //允许拖拽节点的父容器的classname(可按照需要，修改为id或其他)
	        drag.class_name = className;
	
	        //监听鼠标按下事件，动态绑定要拖拽的节点（因为节点可能是动态添加的）
	        $('.' + drag.class_name).on('mousedown', 'ul li', function(event){
	        		var classid= document.elementFromPoint(event.pageX,event.pageY).id;
	        		index_id=$(this).attr("id");
	        		xmmc=$(this).find(".cccc").html();
	            //当在允许拖拽的节点上监听到点击事件，将标识设置为可以拖拽
	            drag.permitDrag = true;
	            //获取到拖拽的原节点对象
	            drag.old_elm = $(this);
	            //执行开始拖拽的操作
	            drag.mousedown(event);
	            return false;
	        });
	
	        //监听鼠标移动
	        $(document).mousemove(function(event){
	            //判断拖拽标识是否为允许，否则不进行操作
	            if(!drag.permitDrag) return false;
	            //执行移动的操作
	            drag.mousemove(event);
	            return false;
	        });
	
	        //监听鼠标放开
	        $(document).mouseup(function(event){
	            //判断拖拽标识是否为允许，否则不进行操作
	            if(!drag.permitDrag) return false;
	            //拖拽结束后恢复标识到初始状态
	            drag.permitDrag = false;
	            //执行拖拽结束后的操作
	            drag.mouseup(event);
	            return false;
	        });
	
	    },
	
		//按下鼠标 执行的操作
		mousedown : function (event){
			console.log('我被mousedown了');
	        //1.克隆临时节点，跟随鼠标进行移动
	        drag.tmp_elm = $(drag.old_elm).clone();
	
	        //2.计算 节点 和 光标 的坐标
	        drag._x = $(drag.old_elm).offset().left;
	        drag._y = $(drag.old_elm).offset().top;
	
	        var e = event || window.event;
	        drag._left = e.pageX - drag._x;
	        drag._top = e.pageY - drag._y;
	        //3.修改克隆节点的坐标，实现跟随鼠标进行移动的效果
	        $(drag.tmp_elm).css({
	            'position' : 'absolute',
	            'background-color' : '#FF8C69',
	            'width':'180px',
	            'left' : drag._x,
	            'top' : drag._y-60,
	        });
	
	        //4.添加临时节点
	        tmp = $(drag.old_elm).parent().append(drag.tmp_elm);
	        drag.tmp_elm = $(tmp).find(drag.tmp_elm);
	
		},
	
		//移动鼠标 执行的操作
		mousemove : function (event){
			console.log('我被mousemove了');
	
	        //2.计算坐标
	        var e = event || window.event;
	        var x = e.pageX - drag._left;
	        var y = e.pageY - drag._top;
	        var maxL = $(document).width() - $(drag.old_elm).outerWidth();
	        var maxT = $(document).height() - $(drag.old_elm).outerHeight();
	        //不允许超出浏览器范围
	        x = x < 0 ? 0: x;
	        x = x > maxL ? maxL: x;
	        y = y < 0 ? 0: y;
	        y = y > maxT ? maxT: y;
	
	        //3.修改克隆节点的坐标
	        $(drag.tmp_elm).css({
	            'left' : x,
	            'top' : y-60,
	        });
	
	        //判断当前容器是否允许放置节点
	        $.each($('.' + drag.class_name + ' ul'), function(index, value){
	
	            //获取容器的坐标范围 (区域)
	            var box_x = $(value).offset().left;     //容器左上角x坐标
	            var box_y = $(value).offset().top;      //容器左上角y坐标
	            var box_width = $(value).outerWidth();  //容器宽
	            var box_height = $(value).outerHeight();//容器高
	            
	            //给可以放置的容器加背景色
	            if(e.pageX > box_x && e.pageX < box_x-0+box_width && e.pageY > box_y && e.pageY < box_y-0+box_height){
	                //判断是否不在原来的容器下（使用坐标进行判断：x、y任意一个坐标不等于原坐标，则表示不是原来的容器）
	                if($(value).offset().left !== drag.old_elm.parent().offset().left 
	                || $(value).offset().top !== drag.old_elm.parent().offset().top){
	                    
	                }
	            }
	
	        });
	
		},
	
	    //放开鼠标 执行的操作
	    mouseup : function (event){
	        console.log('我被mouseup了');
	         console.log(event);
	        //移除临时节点
	        $(drag.tmp_elm).remove();
	        //判断所在区域是否允许放置节点
	        var e = event || window.event;
	  	    var classid= document.elementFromPoint(e.pageX,e.pageY).id;
	  	    if ($("#"+classid).parent().parent().attr("id")=='ssb') {
	  	    			return;
	  	    }
	        $.each($('.' + drag.class_name + ' .tariffCards'), function(index, value){
	
	            //获取容器的坐标范围 (区域)
	            var box_x = $(value).offset().left;     //容器左上角x坐标
	            var box_y = $(value).offset().top;      //容器左上角y坐标
	            
	            var box_width = $(value).outerWidth();  //容器宽
	            var box_height = $(value).outerHeight();//容器高
	            //判断放开鼠标位置是否想允许放置的容器范围内
	                //判断是否不在原来的容器下（使用坐标进行判断：x、y任意一个坐标不等于原坐标，则表示不是原来的容器）
	                if($(value).offset().left !== drag.old_elm.parent().offset().left 
	                || $(value).offset().top !== drag.old_elm.parent().offset().top){
	                    //向目标容器添加节点并删除原节点
	                    tmp = $(drag.old_elm).clone();
	                    $("#sss").find("#ssb").attr("data-id",index_id);
	                    $("#sss").find(".box").attr("id",index_id);
	                    var newObj = $("#"+classid).append($("#sss").html());
	                    $(drag.old_elm).remove();
	                    $("#centhtml").append("<li class='layui-elem-quote'>"+xmmc+"加入切片</li>");
	                    //获取新添加节点的对象
	                    drag.new_elm = $(newObj).find($("#sss").html());
	                }
	        });
	
	    },
	
	};
	
	</script>
</body>
<script>
$(function(){
	 var thtml="<span>项目编号：xxxxxx</span></br>&nbsp;&nbsp;<span>区域：福田</span></br>";
     thtml +="&nbsp;&nbsp;<span>项目名称：深圳项目扩展</span></br>&nbsp;<span> 安装地点：深圳福田站</span></br>";
     thtml +="&nbsp;&nbsp;<span>终端厂家：北京四方</span></br>&nbsp;<span> 业务类型：DTU</span>";
     $(".cccc").each(function() {
    	 $(this).hover(function() {
             tipsId = layer.tips(thtml, this,{tips: [2, '#00A0B5']});
         }, function() {
             if (tipsId)
                 layer.close(tipsId);
         });
     });
	shiyan();
	hexing();
});
function shiyan() {
	var dom = document.getElementById("u2_div");
	dom.style.width = $(".layui-col-md6").clientWidth + 'px';
	var myChart = echarts.init(dom);

	option = null;
	option = {
	    title: {
	    	text: '时延(ms)',
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
	        data: ['09:42:30','09:42:32','09:42:34','09:42:36','09:42:38','09:42:40'],
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
	            name:'A区业务',
	            type:'line',
	            stack: '总量',
	            data:[0, 35, 30, 31, 35, 25, 10,25,35,33,30,10]
	        },
	        {
	            name:'B区业务',
	            type:'line',
	            stack: '总量',
	            data:[25, 18, 19, 23, 29, 33, 31,35,20,12,32,10]
	        }
	    ]
	};

	    myChart.setOption(option);
}
function hexing() {
	//第二个
    var dom = document.getElementById("u4_div");
    var myChart = echarts.init(dom);
    dom.style.width = $(".layui-col-md5").clientWidth + 'px';
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
    	    	text: '核心网资源(%)',
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
                data: ['CPU', 'SMF', 'UDF'],
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
                name: 'CPU',
                type: 'bar',
                
                data: [40, 50, 30],itemStyle: {
                            //柱形图圆角，鼠标移上去效果
                            emphasis: {
                                barBorderRadius: [20, 20, 20, 20]
                            },
                             
                            normal: {
                                //柱形图圆角，初始化效果
                                barBorderRadius:[20, 20, 20, 20]
                            }
                        },
    					
            },
            {
                name: 'SMF',
                type: 'bar',
             
                data: [25, 35, 34],itemStyle: {
                            //柱形图圆角，鼠标移上去效果
                            emphasis: {
                                barBorderRadius: [20, 20, 20, 20]
                            },
                             
                            normal: {
                                //柱形图圆角，初始化效果
                                barBorderRadius:[20, 20, 20, 20]
                            }
                        },
            },
            {
                name: 'UDF',
                type: 'bar',
                
                data: [42, 42, 32],itemStyle: {
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
    </script>
</html>
