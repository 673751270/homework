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
html,body {
   width: 100%;height: 100%;
}
  canvas {
        display: block;
      }
.container {
	position:absolute;
	margin-top:-29%;
	margin-left: 20%;
	 border-radius: 10px;
	height:150px;
	width:350px;
	border:solid 1px rgb(0,160,181);
}
 #table-xx th {
	 color: #FFFFFF;
	  font-size: 5px;
}
 #table-xx td {
	 color: #FFFFFF;
	 text-align:center;
	 font-size: 10px;
}
</style>
</head>

<!-- <body style="opacity: 1; background-image: linear-gradient(rgb(25,88,110), rgb(58, 231, 243), rgb(30, 150, 229));"> -->
<body style="opacity: 1; background: radial-gradient(rgb(25,88,110), rgb(0,0,0));">

  <div style="height: 100%">
	<div class="layui-row" style="height: 45%;">
	<div class="layui-col-md4" style="padding-top: 1%">
		<div class="tariffCards">
		    <div class="economy" onclick="showtari();" >
		    	<div style="transform: rotateZ(-45deg) rotateY(65deg);">
		    		<div class="box" >
					  <div class="front" >
					  </div>
					  <div class="left">
					  </div>
					  <div class="back">
					  </div>
					  <div class="right">
					  </div>
					  <div class="top">
					  </div>
					  <div class="bottom">
					  </div>
		    	</div>
		    	 <div style="position: absolute; margin-left: 5%;margin-top: 50%;">
				  		<span style="color: #FFFFFF;font-size: 25px;">三摇切片</span></br>
				 		</div>
				</div>
				  <div style="margin-left: -70%;margin-top: 25%; transform: rotateZ(-45deg) rotateY(65deg);">
		    		<div class="box" >
					  <div class="front" >
					  </div>
					  <div class="left">
					  </div>
					  <div class="back">
					  </div>
					  <div class="right">
					  </div>
					  <div class="top">
					  </div>
					  <div class="bottom">
					  </div>
		    	</div>
		    	 <div style="position: absolute; margin-left: 15%;margin-top: 35%;">
				  		<span style="color: #FFFFFF;font-size: 25px;">差动保护 </span></br>
				 		</div>
				</div>
		    </div>
		    <div class="premiumeconomy">
		    </div>
		</div>
		<div  class="container" style="display: none;">
			<div style="width: 100%;">
				<span style="color: #FFFFFF;padding-left: 3%;">网元监控信息</span><br>
				<table id="table-xx" style="padding-left: 5%;">
					<thead>
						<tr>
							<th style="width: 80px">节点类型</th>
							<th style="width: 80px">节点类型</th>
							<th style="width: 80px">部署DC</th>
							<th style="width: 80px">节点状态</th>
						</tr>
					</thead>
					<tr>
						<td>AUPF</td>
						<td>UPF72</td>
						<td>dc_id</td>
						<td>normal</td>
					</tr>
		  		</table>
		  		<span style="color: #FFFFFF;padding-left: 3%;">VM资源</span><br>
				<table id="table-xx" style="padding-left: 5%;">
					<thead>
						<tr>
							<th style="width: 80px">VM 001</th>
							<th style="width: 80px">VM 002</th>
							<th style="width: 80px">VM 003</th>
						</tr>
					</thead>
						<tr>
							<td>AUPF</td>
							<td>UPF72</td>
							<td>dc_id</td>
						</tr>
		  		</table>
			</div>
		</div>
		</div>
		<div class="layui-col-md6" style="padding-top: 1%;margin-right: 50px;background: url(${re.contextPath}/plugin/common/images/beijin1.png) no-repeat 0px center;background-size:100%;height:100%;">
			<div id="showCards" style="display: none;">
				<div class="tariffCards" style="margin-left:18%;margin-top: 10%">
			    <div class="economy" data-method="confirmTrans" onclick="showDiv();" >
			    	<div style="width:250px; margin-left: -10%;margin-top: 5%;transform: rotateZ(-45deg) rotateY(65deg);">
					  		<span style="color: #FFFFFF;font-size: 30px;">差动保护-EMBB</span></br></br>
					  		<span style="color: #FFFFFF;font-size: 30px;">在线终端：100</span></br></br>
					  		<span style="color: #FFFFFF;font-size: 30px;">宽带：50gpbs</span>
					 		</div>
			    </div>
				</div>
				<div class="tariffCards" style="margin-left:55%;margin-top: -45%">
			    <div class="economy"  data-method="confirmTrans" onclick="showDiv();">
			    	<div style="width:250px; margin-left: -10%;margin-top: 5%;transform: rotateZ(-45deg) rotateY(65deg);">
					  		<span style="color: #FFFFFF;font-size: 30px;">三摇-URLLC</span></br></br>
					  		<span style="color: #FFFFFF;font-size: 30px;">在线终端：100</span></br></br>
					  		<span style="color: #FFFFFF;font-size: 30px;">宽带：50gpbs</span>
					 </div>
			    </div>
				</div>
			</div>
		</div>
		<div class="layui-col-md1" style="margin-top: 1%; border-radius: 20%;width:11%; border: solid 1px #83eae9;">
			<div style="text-align: center;">
				<a class="layui-btn layui-btn-sm" href="${re.contextPath}/main" style="background: transparent;">进入管理系统&nbsp;&nbsp;<i class="layui-icon">&#xe65b</i></a>
			</div>
		</div>
	</div>
	<div class="layui-row" style="height: 50%;">
		<div class="layui-col-md12" style="height: 90%;" >
			<div class="layui-col-md4" style="height: 100%;" id="aaa">
				<div id="main2" ></div>
			</div>
			<div class="layui-col-md4" >
				<div id="main3" ></div>
			</div>
			<div class="layui-col-md4" >
				<div id="main4"></div>
			</div>
		</div>
	</div>
	</div>
</body>
<script>
$(function() {
 	doquery2();
 	doquery();
 	doquery3();
 	
});
function hidediv() {
	$(".container").hide();
}

function showDiv() {
	 layer.msg($(".container").html(), {
	        time: 20000, //20s后自动关闭
	        btn: ['确定', '取消']
	      });
}
function showtari() {
	$("#showCards").show();
}
function doquery3 () {
	var dom = document.getElementById("main4");
	 dom.style.width = $("#aaa").width()+ 'px';
	  dom.style.height = $("#aaa").height()+ 'px';
	  // 基于准备好的dom，初始化echarts实例
      var myChart1 = echarts.init(dom);
      // 指定图表的配置项和数据
     option1 = {
		    title: {
		        text: '吞吐量(Mbps)',
		        textStyle: {
			        	fontSize:12,              //标题颜色
			        	color: '#FFFFFF'
			      	},
			      	backgroundColor:'#00435d',
			      	borderColor:'#00435d',//标题边框颜色
					borderWidth:1,//标签线框
					borderRadius:5,//边框切圆角
					top:'20px',//组件离上边的距离middle,top,bottom*/ //此二者的优先级高于x吗?答案：是
		        	left:'10px'
		    },
		    tooltip: {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		   	legend: {//图例信息
				  	 data:['UL-DC','DL-DC'],
			    	icon: 'rectangle',
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
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis: {
		    	splitLine:{show: false},//去除网格线
		        type: 'category',
		        //  改变x轴颜色
		            axisLine:{
		                lineStyle:{
		                    color:'#0095ca',
		                }
		            },
		        boundaryGap: false,
		        data:['09:42:30','09:42:31','09:42:32','09:42:33','09:42:34','09:42:35','09:42:36','09:42:37'],
		        axisLabel:{
		              textStyle:{
		                 color:"#FFFFFF", //刻度颜色
		                 fontSize:8  //刻度大小
		            },
		             interval:0   
		          },
		          
		    },
		    yAxis: {
		    	//splitLine:{show: false},//去除网格线
		        type: 'value',
		        //  改变x轴颜色
		            axisLine:{
		                lineStyle:{
		                    color:'#0095ca',
		                }
		            },
		       
		        splitNumber:4
		    },
		    series: [
		        {
		            name:'UL-DC',
		            type:'line',
		            smooth: true,
		            stack: '毫秒1',
		             symbol:'circle',
		            itemStyle : {
						normal : {
							color: '#00FF00',
							lineStyle:{
								color:'#00FF00'
							}
						}
					},
		            data:[10, 20, 25, 18, 17, 25, 26, 22, 23, 26]
		        },
		        {
		            name:'DL-DC',
		            type:'line',
		            smooth: true,
		            stack: '毫秒1',
		             symbol:'circle',
		            itemStyle : {
						normal : {
							color: 'red',
							lineStyle:{
								color:'red'
							}
						}
					},
		            data:[20, 30, 35, 28, 27, 35, 36, 32, 33, 36]
		        }
		    ]
		};
      // 使用刚指定的配置项和数据显示图表。
      myChart1.setOption(option1);
}
function doquery2 () {
	var dom= document.getElementById('main2')
	  dom.style.width = $("#aaa").width()+ 'px';
	  dom.style.height = $("#aaa").height()+ 'px';
	  // 基于准备好的dom，初始化echarts实例
      var myChart1 = echarts.init(dom);
      // 指定图表的配置项和数据
     option1 = {
		    title: {
		        text: '时延(ms)',
		        textStyle: {
			        	fontSize:12,              //标题颜色
			        	color: '#FFFFFF'
			      	},
			      	backgroundColor:'#00435d',
			      	borderColor:'#00435d',//标题边框颜色
					borderWidth:1,//标签线框
					borderRadius:5,//边框切圆角
					top:'20px',//组件离上边的距离middle,top,bottom*/ //此二者的优先级高于x吗?答案：是
		        	left:'10px'
		    },
		    tooltip: {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    legend: {//图例信息
		    	icon: 'circle',
		    	itemWidth: 20,
		        itemHeight: 10,
		        itemGap: 10,
		        textStyle: {
			        	fontSize:8,              //标题颜色
			        	color: '#00cad8'
			      	},
		        
		        orient: 'vertical',  //垂直显示
		        y: 'top',    //延Y轴居中
		        x: 'right' //居右显示
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis: {
		    	splitLine:{show: false},//去除网格线
		        type: 'category',
		        //  改变x轴颜色
		            axisLine:{
		                lineStyle:{
		                    color:'#0095ca',
		                }
		            },
		        boundaryGap: false,
		        data:['09:42:30','09:42:31','09:42:32','09:42:33','09:42:34','09:42:35','09:42:36','09:42:37'],
		        axisLabel:{
		              textStyle:{
		                 color:"#FFFFFF", //刻度颜色
		                 fontSize:8  //刻度大小
		            },
		             interval:0   
		          },
		          
		    },
		    yAxis: {
		    	//splitLine:{show: false},//去除网格线
		        type: 'value',
		        //  改变x轴颜色
		            axisLine:{
		                lineStyle:{
		                    color:'#0095ca',
		                }
		            },
		       
		        splitNumber:4
		    },
		    series: [
		        {
		            name:'移动',
		            type:'line',
		            smooth: true,
		            stack: '毫秒1',
		             symbol:'circle',
		            itemStyle : {
						normal : {
							color: '#FFC0CB',
							lineStyle:{
								color:'#FFC0CB'
							}
						}
					},
		            data:[10, 20, 25, 18, 17, 25, 26, 22, 23, 26]
		        }
		    ]
		};
      // 使用刚指定的配置项和数据显示图表。
      myChart1.setOption(option1);
}
function doquery(){
	var dom= document.getElementById('main3')
	  dom.style.width = $("#aaa").width()+ 'px';
	  dom.style.height = $("#aaa").height()+ 'px';
        // 基于准备好的dom，初始化echarts图表
     	 var myChart = echarts.init(dom,'macarons');
       	option = {
       		title: {
			        text: '核心网资源（%）',
			        textStyle: {
				        	fontSize:12,              //标题颜色
				        	color: '#FFFFFF'
				      	},
				      	backgroundColor:'#00435d',
				      	borderColor:'#00435d',//标题边框颜色
						borderWidth:1,//标签线框
						borderRadius:5,//边框切圆角
						top:'20px',//组件离上边的距离middle,top,bottom*/ //此二者的优先级高于x吗?答案：是
			        	left:'25px'
		    	},
			    tooltip : {
			        trigger: 'axis'
			    },
				legend: {//图例信息
				  	 data:['CPU','RAM','Disk'],
			    	icon: 'rectangle',
			    	itemWidth: 25,
			        itemHeight: 8,
			        itemGap: 8,
			        textStyle: {
				        	fontSize:8,              //标题颜色
				        	color: '#00cad8'
				      	},
			        
			        orient: 'horizontal',  //垂直显示
			        y: 'top',    //延Y轴居中
			        x: 'right' //居右显示
			    },
			     calculable : true,
			    grid: {
			        left: '5%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    xAxis : [
			        {
			            type : 'category',
			            data : ['服务标志1','服务标志2','服务标志3','服务标志4'],
			            boundaryGap : true,
			             axisLine:{
			                lineStyle:{
			                    color:'#0095ca',
			                }
			            },
			             axisLabel:{
			             	show:true,
				              textStyle:{
				                 color:"#FFFFFF", //刻度颜色
				                 fontSize:9 //刻度大小
				            },
				             interval:0  
				          },
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value',
			            axisLine:{
			                lineStyle:{
			                    color:'#0095ca',
			                }
			            },
			        }
			        
			    ],
			    series : [
			        {
			            name:'CPU',
			            type:'bar',
			             barWidth: 10,
			            data:[210, 250, 280, 210],
			        },
			        {
			            name:'RAM',
			            type:'bar',
			             barWidth: 10,
			            data:[200, 200, 250, 180],
			        },
			        {
			            name:'Disk',
			            type:'bar',
			             barWidth: 10,
			            data:[200, 200, 250, 180],
			        },
			        
			    ]
			};

      // 为echarts对象加载数据 
    	  myChart.setOption(option); 
      } 
</script>
</html>
