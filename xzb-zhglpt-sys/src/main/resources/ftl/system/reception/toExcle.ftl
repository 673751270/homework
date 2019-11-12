<#-- Created by IntelliJ IDEA.
 User: Administrator
 Date: 2017/12/6
 Time: 14:00
 To change this template use File | Settings | File Templates.
 用户管理-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/layui/css/layui.css">
    <link rel="stylesheet" href="${re.contextPath}/plugin/lenos/main.css">
    <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/layui/layui.all.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/tools/tool.js"></script>

</head>

<body>
<h1>导出机构信息</h1>
<div class="lenos-search">
    <div class="select">
        搜索：管理部门：
        <div class="layui-inline">
            <input class="layui-input" height="20px" id="departType" autocomplete="off">
        </div>
        是否会员：
        <div class="layui-inline">
            <input class="layui-input" height="20px" id="ismember" autocomplete="off">
        </div>
        状态：
        <div class="layui-inline">
            <input class="layui-input" height="20px" id="state" autocomplete="off">
        </div>
        已年报年份：
        <div class="layui-inline">
            <input class="layui-input" height="20px" id="annals" autocomplete="off">
        </div>
        已缴年费年份：
        <div class="layui-inline">
            <input class="layui-input" height="20px" id="clubYear" autocomplete="off">
        </div>
    <#--邮箱：-->
    <#--<div class="layui-inline">-->
    <#--<input class="layui-input" height="20px" id="email" autocomplete="off">-->
    <#--</div>-->
        <button class="select-on layui-btn layui-btn-sm" data-type="select"><i class="layui-icon"></i>
        </button>

        <button class="layui-btn" style="height: 30px; line-height: 30px;float: right;" onclick="exportExcel()">
            导出excle
        </button>
        <button class="layui-btn layui-btn-sm icon-position-button" id="refresh" style="float: right;"
                data-type="reload">
            <i class="layui-icon">ဂ</i>
        </button>
    </div>

</div>

<table id="toExcleList" class="layui-hide" lay-filter="toexcle"></table>
<script type="text/html" id="toolBar">


    <a class="layui-btn layui-btn-xs  layui-btn-normal" lay-event="edit">编辑</a>

    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>

</script>

<script>
    layui.laytpl.toDateString = function (d, format) {
        var date = new Date(d || new Date())
                , ymd = [
            this.digit(date.getFullYear(), 4)
            , this.digit(date.getMonth() + 1)
            , this.digit(date.getDate())
        ]
                , hms = [
            this.digit(date.getHours())
            , this.digit(date.getMinutes())
            , this.digit(date.getSeconds())
        ];

        format = format || 'yyyy-MM-dd HH:mm:ss';

        return format.replace(/yyyy/g, ymd[0])
                .replace(/MM/g, ymd[1])
                .replace(/dd/g, ymd[2])
                .replace(/HH/g, hms[0])
                .replace(/mm/g, hms[1])
                .replace(/ss/g, hms[2]);
    };

    //数字前置补零
    layui.laytpl.digit = function (num, length, end) {
        var str = '';
        num = String(num);
        length = length || 2;
        for (var i = num.length; i < length; i++) {
            str += '0';
        }
        return num < Math.pow(10, length) ? str + (num | 0) : num;
    };

    document.onkeydown = function (e) { // 回车提交表单
        var theEvent = window.event || e;
        var code = theEvent.keyCode || theEvent.which;
        if (code == 13) {
            $(".select .select-on").click();
        }
    }
    layui.use(['table'], function () {
        var table = layui.table;
        //方法级渲染
        table.render({
            id: 'toExcleList',
            elem: '#toExcleList',
            url: 'showToExcleList',
            page: true,
            limit: 10,
            // height: 'full-90',
            cols: [[ //表头
                {field: 'rownum', title: '编号', width: '5%'},
                {field: 'orgName', title: '机构名称', width: '30%'}
                , {field: 'principal', title: '负责人', width: '10%'}
                , {field: 'registerNum', title: '证号', width: '10%'}
                , {field: 'addressArea', title: '地址', width: '10%'}
                , {field: 'oph', title: '电话', width: '10%'}
                , {field: 'fax', title: '传真', width: '10%'}
                , {field: 'zip', title: '邮编', width: '10%'}
                , {field: 'departType', title: '管理部门', width: '10%'}
                , {field: 'annals', title: '已年度报告', width: '10%'}
                , {field: 'clubYear', title: '已缴纳会费', width: '10%'}
                , {field: 'ismember', title: '是否会员', width: '7%'}
                , {field: 'state', title: '状态', width: '5%'}
            ]]
        });

        var $ = layui.$, active = {
            select: function () {
                var departType = $('#departType').val();
                var ismember = $('#ismember').val();
                var state = $('#state').val();
                var annals = $('#annals').val();
                var clubYear = $('#clubYear').val();

                if (ismember == "是" || state == "正常") {
                    ismember = 1;
                    state = 1;
                }
                if (ismember == "否" || state == "撤销") {
                    ismember = 0;
                    state = 0;
                }

                table.reload('toExcleList', {
                    where: {
                        departType: departType,
                        ismember: ismember,
                        state: state,
                        annals: annals,
                        clubYear: clubYear
                    }
                });
            },
            reload: function () {
                $('#departType').val('');
                $('#ismember').val('');
                $('#state').val('');
                $('#annals').val('');
                $('#clubYear').val('');
                table.reload('toExcleList', {
                    where: {
                        toExcleList: null,
                    }
                });
            },
            add: function () {
                add('添加角色', 'showAddDepartment', 700, 450);
            },
            update: function () {
                var checkStatus = table.checkStatus('departmentList')
                        , data = checkStatus.data;
                if (data.length != 1) {
                    layer.msg('请选择一行编辑', {icon: 5});
                    return false;
                }
                update('编辑角色', 'updateDepartment?id=' + data[0].id, 700, 450);
            },
            detail: function () {
                var checkStatus = table.checkStatus('departmentList')
                        , data = checkStatus.data;
                if (data.length != 1) {
                    layer.msg('请选择一行查看', {icon: 5});
                    return false;
                }
                detail('查看角色信息', 'updateDepartment?id=' + data[0].id, 700, 450);
            }
        };

        //监听表格复选框选择
        table.on('checkbox(department)', function (obj) {
            //console.log(obj)
        });
        //监听工具条
        table.on('tool(department)', function (obj) {
            var data = obj.data;
            // if (obj.event === 'detail') {
            //     detail('编辑角色', 'updateRole?id=' + data.id, 700, 450);
            // } else
            if (obj.event === 'del') {
                layer.confirm('确定删除角色[<label style="color: #00AA91;">' + data.departmentName + '</label>]?', function () {
                    del(data.id);
                });
            } else if (obj.event === 'edit') {
                update('编辑角色', 'updateDepartment?id=' + data.id, 700, 450);
            }
        });

        $('.layui-col-md12 .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        $('.select .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


    });

    function del(id) {
        $.ajax({
            url: "del",
            type: "post",
            data: {id: id},
            success: function (d) {
                if (d.msg) {
                    layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['120px', '80px'], anim: 2});
                    layui.table.reload('departmentList');
                } else {
                    layer.msg(d.msg, {icon: 5, offset: 'rb', area: ['120px', '80px'], anim: 2});
                }
            }
        });
    }

    function detail(title, url, w, h) {
        var number = 1;
        if (title == null || title == '') {
            title = false;
        }
        ;
        if (url == null || url == '') {
            url = "/error/404";
        }
        ;
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        }
        ;
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        }
        ;
        layer.open({
            id: 'department-detail',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            maxmin: true,
            shadeClose: true,
            shade: 0.4,
            title: title,
            content: url + '&detail=true',
            // btn:['关闭']
        });
    }

    /**
     * 更新用户
     */
    function update(title, url, w, h) {
        if (title == null || title == '') {
            title = false;
        }
        if (url == null || url == '') {
            url = "/error/404";
        }
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        }
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        }
        layer.open({
            id: 'department-update',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            maxmin: true,
            shadeClose: false,
            shade: 0.4,
            title: title,
            content: url + '&detail=false'
        });
    }

    /*弹出层*/
    /*
     参数解释：
     title   标题
     url     请求的url
     id      需要操作的数据id
     w       弹出层宽度（缺省调默认值）
     h       弹出层高度（缺省调默认值）
     */
    function add(title, url, w, h) {
        if (title == null || title == '') {
            title = false;
        }
        ;
        if (url == null || url == '') {
            url = "/error/404";
        }
        ;
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        }
        ;
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        }
        ;
        layer.open({
            id: 'department-add',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            maxmin: true,
            shadeClose: false,
            shade: 0.4,
            title: title,
            content: url
        });
    }

    function exportExcel() {
        var departType = $('#departType').val();
        var ismember = $('#ismember').val();
        var state = $('#state').val();
        var annals = $('#annals').val();
        var clubYear = $('#clubYear').val();

        if (departType == '' && ismember == '' && state == '' && annals == '' && clubYear == '') {
            alert("导出全部数据量太大，请根据条件导出！");
            return;
        }

        // window.location.href = "/xzb-wb/reception/export?departType=" + departType + "&ismember=" + ismember + "&state=" + state + "&annals=" + annals +"&clubYear=" + clubYear;
        $.ajax({
            type: 'post',
            url: '/xzb-wb/reception/checkMax',
            dataType: "text",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            traditional: true, //使json格式的字符串不会被转码
            data: {
                "departType": departType,
                "ismember": ismember,
                "state": state,
                "annals": annals,
                "clubYear": clubYear
            },
            beforeSend: function () {
                //注意，layer.msg默认3秒自动关闭，如果数据加载耗时比较长，需要设置time
                loadingFlag = layer.msg('正在导出数据，请稍候……', {icon: 16, shade: 0.01, shadeClose: false, time: 6000000});
            },
            success: function (res) {

                if (res == "false") {
                    layer.close(loadingFlag);
                    alert("您导出的数据量过大，请根据条件查询！")
                } else {
                    this.beforeSend();
                    window.location.href = "/xzb-wb/reception/export?departType=" + departType + "&ismember=" + ismember + "&state=" + state + "&annals=" + annals + "&clubYear=" + clubYear;

                }
            },
            error: function (res) {
                alert("请求是吧")
            },
            complete: function () {
                layer.close(loadingFlag);
            }
        })
    }
</script>
</body>

</html>
