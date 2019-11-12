


function add(){
	//新增
	 $("#sumitform input").attr("value","");
	$("#update_bot").hide();
	  $("#add_bot").show(); 
	 
layer.open({
  type: 1, 
  title:['查看'] ,
  content:$("#look").html()
});  
}

function expor(){
	layer.open({
		  title: '导出'
		  ,content: '该功能暂未开发,敬请期待！'
		});     
}

function fypg(){
	layer.open({
		  title: '费用评估'
		  ,content: '该功能暂未开发,敬请期待！'
		});     
}

function wlpg(){
	layer.open({
		  title: '网络评估'
		  ,content: '该功能暂未开发,敬请期待！'
		});     
}







