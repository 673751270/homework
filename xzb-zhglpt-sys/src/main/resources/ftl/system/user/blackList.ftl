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
<div class="lenos-search">
    <div class="select">
        用户名：
        <div class="layui-inline">
            <input class="layui-input" height="20px" id="uname" autocomplete="off">
        </div>
        手机：
        <div class="layui-inline">
            <input class="layui-input" height="20px" id="email" autocomplete="off">
        </div>
        <button class="select-on layui-btn layui-btn-sm" data-type="select"><i class="layui-icon"></i>
        </button>
        <button class="layui-btn layui-btn-sm icon-position-button" id="refresh" style="float: right;"
                data-type="reload">
            <i class="layui-icon">ဂ</i>
        </button>
    </div>

</div>
<div class="layui-col-md12" style="height:40px;margin-top:3px;">
    <div class="layui-btn-group">
    </div>
</div>
<table id="userList" class="layui-hide" lay-filter="user"></table>
<script type="text/html" id="barDemo">
    <@shiro.hasPermission name="blackList:show">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="unlock">解锁</a>
    </@shiro.hasPermission>
</script>
<script type="text/html" id="switchTpl">
    <input type="checkbox" name="sex" lay-skin="switch" lay-text="女|男" lay-filter="sexDemo">
</script>
<script>
    document.onkeydown = function (e) { // 回车提交表单
        var theEvent = window.event || e;
        var code = theEvent.keyCode || theEvent.which;
        if (code === 13) {
            $(".select .select-on").click();
        }
    }
    layui.use('table', function () {
        var table = layui.table;
        //方法级渲染
        table.render({
            id: 'userList',
            elem: '#userList'
            , url: 'showBlackList'
            , cols: [[
                {checkbox: true, fixed: true, width: '5%'}
                , {
                    field: 'username',
                    title: '用户名',
                    sort: true,
                    style: 'background-color: #009688; color: #fff;'
                }
                , {field: 'age', title: '年龄', sort: true, width: '5%'}
                , {field: 'realName', title: '真实姓名'}
                , {field: 'email', title: '手机'}
                , {field: 'photo', title: '头像', template: '#switchTpl'}
                , {field: 'departmentName', title: '部门'}
                , {field: 'positionName', title: '职务'}
                , {fixed: 'right', field: 'right', title: '操作', toolbar: "#barDemo"}
            ]]
            , page: true
        });

        var $ = layui.$, active = {
            select: function () {
                table.reload('userList', {
                    where: {
                        username: $('#uname').val(),
                        email: $('#email').val()
                    }
                });
            },
            reload: function () {
                table.reload('userList', {
                    where: {
                        username: $('#uname').val(),
                        email: $('#email').val()
                    }
                });
            }
        };

        //监听表格复选框选择
        table.on('checkbox(user)', function (obj) {
            console.log(obj)
        });
        //监听工具条
        table.on('tool(user)', function (obj) {
            var data = obj.data;
            if (obj.event === 'unlock') {
                post('unlock', data, 'userList')
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
</script>
</body>

</html>
