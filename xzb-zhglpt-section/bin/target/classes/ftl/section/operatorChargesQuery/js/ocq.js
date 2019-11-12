
var dom = document.getElementById("u215_div");
var myChart = echarts.init(dom);
option = null;
option = {
    title: {
        
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data:['A区业务','B区业务','C区业务']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    toolbox: {
        feature: {
        	 /* saveAsImage: {}*/
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
		axisLabel: {
                            show: true,
                            textStyle: {
                                color: '##DCDCDC'
                            }
                        },
    },
    yAxis: {
        type: 'value',
		axisLabel: {
                            show: true,
                            textStyle: {
                                color: '##DCDCDC'
                            }
                        },
    },
    series: [
        {
            name:'A区业务',
            type:'line',
            stack: '总量',
            data:[0, 350, 350, 310, 350, 259, 100,250,350,330,350,150]
        },
        {
            name:'B区业务',
            type:'line',
            stack: '总量',
            data:[250, 182, 191, 234, 290, 330, 310,350,200,123,320,100]
        },
        {
            name:'C区业务',
            type:'line',
            stack: '总量',
            data:[650, 732, 601, 554, 490, 330, 410,425,450,422,333,410]
        }
    ]
};

    myChart.setOption(option);
	
    
    //第二个echart
	var dom = document.getElementById("u216_div");
	var myChart = echarts.init(dom);
	var app = {};
	option = null;
	app.title = '嵌套环形图';

	option = {
	    tooltip: {
	        trigger: 'item',
	        formatter: "{a} <br/>{b}: {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        x: 'left',
	        data:['A区业务','B区业务','C区业务']
	    },
	    series: [
	        {
	            name:'A区业务',
	            type:'pie',
	            selectedMode: 'single',
	            radius: [0, '30%'],

	            label: {
	                normal: {
	                    position: 'inner'
	                }
	            },
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data:[
	                {value:335, name:'10%', selected:true},
	                {value:679, name:'20%'},
	                {value:1548, name:'70%'}
	            ]
	        },
	        {
	            name:'',
	            type:'pie',
	            radius: ['40%', '55%'],
	            label: {
	                normal: {
	                    formatter: '{a|{a}}{abg|}\n{hr|}\n  {b|{b}：}{c}  {per|{d}%}  ',
	                   
	                    borderWidth: 1,
	                    borderRadius: 4,
	                    // shadowBlur:3,
	                    // shadowOffsetX: 2,
	                    // shadowOffsetY: 2,
	                    // shadowColor: '#999',
	                    // padding: [0, 7],
	                    rich: {
	                        a: {
	                            color: '#999',
	                            lineHeight: 22,
	                            align: 'center'
	                        },
	                        // abg: {
	                        //     backgroundColor: '#333',
	                        //     width: '100%',
	                        //     align: 'right',
	                        //     height: 22,
	                        //     borderRadius: [4, 4, 0, 0]
	                        // },
	                        hr: {
	                            borderColor: '#aaa',
	                            width: '100%',
	                            borderWidth: 0.5,
	                            height: 0
	                        },
	                        b: {
	                            fontSize: 12,
	                            lineHeight: 33
	                        },
	                        per: {
	                            color: '#eee',
	                            backgroundColor: '#334455',
	                            padding: [2, 4],
	                            borderRadius: 2
	                        }
	                    }
	                }
	            },
	            data:[
	                {value:335, name:'A区业务'},
	                {value:310, name:'B区业务'},
	                {value:234, name:'C区业务'}
	              
	            ]
	        }
	    ]
	};

	    myChart.setOption(option);
    
    
    
	