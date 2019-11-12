
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
  <script type="text/javascript" src="${re.contextPath}/ftl/section/layui/layui.js" charset="utf-8"></script>
  <script type="text/javascript" src="${re.contextPath}/ftl/section/operatorDemand/js/demandSchedule.js" charset="utf-8"></script>
   <style>
   	html,body{
   		height: 100%;
   	}
   </style>

</head>

<body style="background-color: #E0E0E0">
       <div class="layui-fluid"  >
      <div class="layui-row"  style="height: 10%;overflow: auto;" >
       
          <div class="layui-col-md12"  >
           <div class="nva" style=" margin: 5px 0px 5px 0px;"  >
		  	<!--输入框-->
			<input type="text" name="orderno" id="order_no"  placeholder="请输入单号" style="height: 26px;">
            <button class="layui-btn layui-btn-sm"  id="selectno"><i class="layui-icon">&#xe615;</i>搜索</button>
            
          </div>
             
          </div>
      </div>
          <!--查询条件end  -->
          
          
          <!--表格区-->
  <!--   <div class="layui-btn-group demoTable" style="margin-top: 2px;">
        <button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
        <button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
        <button class="layui-btn" data-type="isAll">验证是否全选</button>
    </div> -->
    
    <div class="layui-row"  style="height: 48%;overflow: auto; background-color: #ffffff">
       <div class="layui-col-md12" >
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
 <div id="bjtest">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>
</script>
    
          </div>
      </div>
   <!--顶部结束  -->
   <!-- 中部开始 -->
   <div class="layui-row"  style="height: 2px;;overflow: auto; ">
       <div class="layui-col-md12" >
       <hr style="background-color: #E0E0E0">
   </div>
   </div>
   
   <!-- 底部开始 -->
   
    <div class="layui-row"  style="height: 10%;overflow: auto;" >
          <div class="layui-col-md12"  >
           <div class="nva" style=" margin: 5px 0px 5px 0px;"  >
            <button class="layui-btn layui-btn-sm"onclick="order()" style="margin-left:1%;">
            	<i class="layui-icon">&#xe605;</i> 
                                  订购
            </button>
            
            <button class="layui-btn layui-btn-sm"onclick="repurchase()" style="margin-left:3%;">
            	<i class="layui-icon">&#x1006;</i> 
                                   退购
            </button>
          </div>
          </div>
      </div>
   
    <div class="layui-row"  style="height: 40%;overflow: auto; background-color: #ffffff">
    
       <div class="layui-col-md12" >
    <table class="layui-table" lay-data="{ 
    url:'${re.contextPath}/department_Apply/DepartmentApply',size: 'sm',page: { 
     layout: ['limit', 'count', 'prev', 'page', 'next', 'skip']
    ,limits:[5,10, 20, 30, 40, 50]
    ,limit:5
      ,groups: 1  
    }, id:'idTest1'}" lay-filter="demo1">
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
      <!-- <th lay-data="{fixed: 'right', width:158, align:'center', toolbar: '#barDemo'}"></th> -->
    </tr>
  </thead>
</table>

    
          </div>
      </div>
     
</div>

 <!-- 查看按钮开始 --> 
<div id="look" style="display: none;" >
<div class="layui-fluid">
 <div class="layui-col-md12">
 
 <form class="layui-form layui-form-pane" action="" id="sumitform">
   <div class="layui-form-item">
    <label class="layui-form-label">编号</label>
    <div class="layui-input-block">
      <input type="text" name="title"  disabled="disabled" class="layui-input" id="id" placeholder="编号自动生成" >
    </div>
  </div>
  
   <div class="layui-form-item">
    <label class="layui-form-label">单号</label>
    <div class="layui-input-block">
      <input type="text" name="title"  class="layui-input" id="orderno" placeholder="请输入单号">
    </div>
  </div>
  
   <div class="layui-form-item">
    <label class="layui-form-label">名称</label>
    <div class="layui-input-block">
      <input type="text" name="title" autocomplete="off"  class="layui-input" id="ordername" placeholder="请输入名称">
    </div>
  </div>
  
   <div class="layui-form-item">
    <label class="layui-form-label">区域</label>
    <div class="layui-input-block">
      <input type="text" name="title" autocomplete="off"  class="layui-input" id="region" placeholder="请输入区域">
    </div>
  </div>
  
   <div class="layui-form-item">
    <label class="layui-form-label">申请人</label>
    <div class="layui-input-block">
      <input type="text" name="title" autocomplete="off" class="layui-input" id="applicant" placeholder="请输入申请人" >
    </div>
  </div>
  
   <div class="layui-form-item">
    <label class="layui-form-label">当前环节</label>
    <div class="layui-input-block">
      <input type="text" name="title" autocomplete="off"  class="layui-input" id="currentlink" placeholder="请输入当前环节">
    </div>
  </div>
  
   <div class="layui-form-item">
    <label class="layui-form-label">当前处理人</label>
    <div class="layui-input-block">
      <input type="text" name="title" autocomplete="off"  class="layui-input" id="currenthandler" placeholder="请输入当前环节"> 
    </div>
  </div>
  
   <div class="layui-form-item">
    <label class="layui-form-label">状态</label>
    <div class="layui-input-block">
      <input type="text" name="title" autocomplete="off"  class="layui-input" id="state" placeholder="请输入当前状态">
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block" id="update_bot" class="input_bot" style="display: none;">
	    <button class="layui-btn" lay-submit lay-filter="formDemo">确定</button>
	     <a  href="javascript:;" class="layui-btn layui-layer-close  layui-layer-close1" >取消</a>
	</div>
	  <div class="layui-input-block" id="add_bot" class="input_bot" style="display: none;">
	    <button class="layui-btn" lay-submit lay-filter="addformDemo">确定</button>
	    <a  href="javascript:;" class="layui-btn layui-layer-close  layui-layer-close1" >取消</a>
	</div>
  </div>
 
  </form>
   <!-- 查看结束 -->
 </div>
 
</div> 
 
</div>

 <script>
layui.use('table', function(){
  //监听表格复选框选择
   var table = layui.table;
   var oe =false;
   var of =false;
  table.on('checkbox(demo)', function(obj){
    of=false;
    console.log(obj)
  });
  
  //监听查看-编辑-删除
  table.on('tool(demo)', function(obj){
    var data = obj.data;
    if(obj.event === 'detail'){
    	$("#update_bot").hide();
  	    $("#add_bot").hide(); 
    	oe=true;
    	//遍历数据到表单中
    	$("#look input").each(function(){
    		var id=$(this).attr("id")
    		$("#"+id).attr("value",data[id]);
    	}) 
    	layer.open({
      	  type: 1, 
      	  title:['查看'] ,
      	  content:$("#look").html()
      	});
    } else if(obj.event === 'del'){
    	  oe=true;
      layer.confirm('真的删除行么', function(index){
        obj.del();
        layer.close(index);
      });
    } else if(obj.event === 'edit'){
    	oe=true;
    	//遍历数据到表单中
    	$("#look input").each(function(){
    		var id=$(this).attr("id")
    		$("#"+id).attr("value",data[id]);
    	}) 
    	//编辑的时候追加按钮
    	/* var html='  <div class="layui-input-block" id="input_bot" class="input_bot" >'+
    	      '<button class="layui-btn" lay-submit lay-filter="formDemo">确定</button>'+
    	      '<button class="layui-btn  lay-submit layui-btn-primary" lay-filter="cancel" >取消</button></div>'
    	      $("#sumitform").append(html); */
    	 $("#update_bot").show();
    	  $("#add_bot").hide(); 
    	layer.open({
      	  type: 1, 
      	  title:['查看'] ,
      	  content:$("#look").html()
      	});
    }
    
  });
  
  //监听 行单击事件(table—id的值)
  table.on('row(demo)', function(obj){
	if(oe !=true || of==true) {
		oe=false;
	    var orderno = obj.data.orderno;
	    table.reload('idTest1',{
	        where:{orderno:orderno}
	    });
    //标注选中样式
    obj.tr.addClass('layui-table-click').siblings().removeClass('layui-table-click');
	}else{
		oe=false;
	}
  });
  
  var $ = layui.$, active = {
    //搜索框条件查询
    selectno:function () {
        var orderno=$("#order_no").val();
        table.reload('idTest',{
            where:{orderno:orderno}
        });
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
  $("#selectno").on('click',function(){
	  active.selectno();
  });
  
});

//编辑确定按钮
layui.use('form', function(){
	  var form = layui.form;
	  //监听提交
	  form.on('submit(formDemo)', function(data){
	    layer.msg("您点击了修改按钮");
	    return false;
	  });
	  form.on('submit(addformDemo)', function(data){
		    layer.msg("您点击了新增按钮");
		    return false;
		  });
});



</script>

</body>

</html>
