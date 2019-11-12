
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
   </style>

</head>

<body style="background-color: #E0E0E0">
<div class="layui-fluid" style="height: 100%;" >
         <!-- 行元素 -->
    <div class="layui-row"  style="height: 48%;background-color: #E0E0E0; margin-top: 1%;" >
       <!-- 左边echart -->
       <div class="layui-col-md6" style=" height: 100%; background-color:#ffffff ;width: 49%;margin-right: 1%;">
        <div id="u215_div" class="u215_div" style="height: 100%;margin-right:5%;"></div>
       </div>
       
       <!-- 右边echart -->
       <div class="layui-col-md6" style="height: 100%; background-color:#ffffff ;width: 49%;margin-left: 1%;">
       <div id="u216_div" class="u216_div" style="height: 100%;margin-right:5%;"></div>
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
      <th lay-data="{fixed: 'right', width:180, align:'center', toolbar: '#barDemo'}">操作</th>
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

<script type="text/javascript" src="${re.contextPath}/ftl/section/operatorChargesQuery/js/ocq.js" charset="utf-8"></script>
 <script>
layui.use('table', function(){
  var table = layui.table;
  //监听表格复选框选择
  table.on('checkbox(demo)', function(obj){
    console.log(obj)
  
  });
  //监听工具条
  table.on('tool(demo)', function(obj){
    var data = obj.data;
    if(obj.event === 'detail'){
      layer.msg('ID：'+ data.id + ' 的查看操作');
    } else if(obj.event === 'del'){
      layer.confirm('真的删除行么', function(index){
        obj.del();
        layer.close(index);
      });
    } else if(obj.event === 'edit'){
      layer.alert('编辑行：<br>'+ JSON.stringify(data))
    }
  });
  
  var $ = layui.$, active = {
    getCheckData: function(){ //获取选中数据
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.alert(JSON.stringify(data));
    }
    ,getCheckLength: function(){ //获取选中数目
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.msg('选中了：'+ data.length + ' 个');
    }
    ,isAll: function(){ //验证是否全选
      var checkStatus = table.checkStatus('idTest');
      layer.msg(checkStatus.isAll ? '全选': '未全选')
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
  
 
  
});
</script>
</body>

</html>
