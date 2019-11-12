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

layui.use('tree', function(){
	layui.tree({
		  elem: '#demo',
		  skin: 'shihuang'//传入元素选择器
		  ,nodes: [{ //节点
		    name: '12区业务'
		    ,children: [{
		      name: '差动保护业务切片'
		      ,id: 121
		    },{
		      name: '三遥业务切片'
		      ,id: 122
		    }]
		  },{
		    name: '13区业务'
		    ,children: [{
		      name: '差动保护业务切片'
		    ,id: 131
		    },{
		      name: '三遥业务切片'
		    ,id: 132
		    }]
		  },{
		    name: '14区业务'
			,children: [{
			  name: '差动保护业务切片'
			,id: 141
			},{
			  name: '三遥业务切片'
		    ,id: 142
			}]
		     }]
	//节点点击事件
	,click: function(node){//node即为当前点击的节点数据
		if(node.id==121  || node.id==131 || node.id==141 ){
			 $('#qpmbid').html('20180116');
			 $('#yjqp').html('12区businessA');
			 $('#qp').html('切片3');
			 $('#dkczywsl').html('10');
			 $('#qy').html('龙华');
			 $('#kzxl').html('85%');
			 $('#zdys').html('1ms');
			 $('#zt').html('不在网');
			 $('#ydsl').html('2');
		}else if(node.id==122  || node.id==132 || node.id==142){
			 $('#qpmbid').html('20200125');
			 $('#yjqp').html('132区businessB');
			 $('#qp').html('切片5');
			 $('#dkczywsl').html('20');
			 $('#qy').html('南山');
			 $('#kzxl').html('0%');
			 $('#zdys').html('33ms');
			 $('#zt').html('未开通');
			 $('#ydsl').html('1');
		}
	  }  
		});
	
	});


