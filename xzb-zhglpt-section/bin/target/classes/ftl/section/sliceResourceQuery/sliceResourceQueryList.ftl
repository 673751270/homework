
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>layui</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  
    <link rel="stylesheet" href="${re.contextPath}/ftl/section/layui/css/layui.css">
  <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="${re.contextPath}/plugin/common/js/echarts.js"></script>

  <script type="text/javascript" src="${re.contextPath}/ftl/section/layui/layui.js" charset="utf-8"></script>
  
   <style>
   	html,body{	
   		height: 100%;
   	}
   .layui-tree-skin-shihuang .layui-tree-branch{color: #00A0B5;} 
   </style>

</head>

<body style="background-color: #E0E0E0">
<div class="layui-fluid" style="height: 100%;" >
         <!-- 行元素 -->
    <div class="layui-row"  style="height: 48%;background-color: #E0E0E0; margin-top: 1%;" >
       <!-- 左边echart -->
       <div class="layui-col-md6" style=" height: 100%; background-color:#ffffff ;width: 39%;margin-right: 1%;">
       
       <ul id="demo" lay-size="sm"></ul>
       
       </div>
       
       <!-- 右边echart -->
       <div class="layui-col-md6" style="height: 100%; background-color:#ffffff ;width: 59%;margin-left: 1%; overflow: auto;">
       <table class="layui-table" lay-size="sm" style="margin-left: 1%;height: 100%;width: 99%;">
		    <tr>
		      <th style="background-color:#c3dfb8 ;color: #fff">切片模板ID</th>
		      <td id="qpmbid">123</td>
		      <th style="background-color:#c3dfb8;color: #fff">一级切片</th>
		      <td id="yjqp">12业务A</td>
		    </tr> 
		     <tr>
		      <th style="background-color:#c3dfb8;color: #fff">切片名称</th>
		      <td id="qp">切片1</td>
		      <th style="background-color:#c3dfb8;color: #fff">二级切片</th>
		      <td>差动保护业务切片</td>
		    </tr> 
		     <tr>
		      <th style="background-color:#c3dfb8;color: #fff" >单卡承载业务数量</th>
		      <td id="dkczywsl">2</td>
		      <th style="background-color:#c3dfb8;color: #fff">在线率</th>
		      <td id="kzxl">95%</td>
		    </tr> 
		     <tr>
		      <th style="background-color:#c3dfb8;color: #fff">区域</th>
		      <td id="qy">福田区</td>
		      <th style="background-color:#c3dfb8;color: #fff">服务支持级别</th>
		      <td>高</td>
		    </tr> 
		     <tr>
		     <th style="background-color:#c3dfb8;color: #fff">连接规模</th>
		      <td>5</td>
		      <th style="background-color:#c3dfb8;color: #fff"> 状态</th>
		      <td id="zt">在网</td>
		    </tr> 
		     <tr>
		     <th style="background-color:#c3dfb8;color: #fff">最大延时</th>
		      <td id="zdys">15ms</td>
		      <th style="background-color:#c3dfb8;color: #fff">上行速率</th>
		      <td>3Mbps</td>
		    </tr> 
		     <tr>
		     <th style="background-color:#c3dfb8;color: #fff">下行速率</th>
		      <td>2.5Mbps</td>
		      <th style="background-color:#c3dfb8;color: #fff"> 移动速率</th>
		      <td id="ydsl">0</td>
		    </tr> 
		     <tr>
		     <th style="background-color:#c3dfb8;color: #fff">游牧性</th>
		      <td>完全绑定</td>
		      <th style="background-color:#c3dfb8;color: #fff"></th>
		      <td></td>
		    </tr> 
		    
        </table>
       
       </div>
       
    </div>
         <!-- 分界线 -->
         
    <div class="layui-row"  style="height: 48%;margin-top:1%; background-color: #ffffff" >
       <div class="layui-col-md12" >
       <!-- 表格开始 -->
     <table class="layui-table" lay-data="{url:'${re.contextPath}/department_Apply/DepartmentApply',size: 'sm',page: { 
      layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
    ,limits:[5,10, 20, 30, 40, 50]
    ,limit:5
      ,groups: 1 
   
      
    }, id:'idTest'}" lay-filter="demo">
  <thead>
    <tr>
     <th lay-data="{type:'checkbox', fixed: 'left' }"></th>
      <th lay-data="{field:'id', sort: true, fixed: true}">ID</th>
      <th lay-data="{field:'orderno'}">单号</th>
      <th lay-data="{field:'ordername', sort: true}">名称</th>
      <th lay-data="{field:'region'}">区域</th>
      <th lay-data="{field:'applicant'}">申请人</th>
      <th lay-data="{field:'currentlink', sort: true}">当前环节</th>
      <th lay-data="{field:'currenthandler'}">当前处理人</th>
      <th lay-data="{field:'state', sort: true}">状态</th>
      <!-- <th lay-data="{fixed: 'right', width:180, align:'center', toolbar: '#barDemo'}">操作</th> -->
    </tr>
  </thead>
</table>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

    
       </div>
    </div>
     
</div>

<script type="text/javascript" src="${re.contextPath}/ftl/section/sliceResourceQuery/js/sliceRescourceQuery.js" charset="utf-8"></script>
<script type="text/javascript">

	

</script>
</body>

</html>
