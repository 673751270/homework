<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>黑名单管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/layui/css/layui.css">
    <link rel="stylesheet" href="${re.contextPath}/plugin/lenos/main.css">
    <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/layui/layui.all.js" charset="utf-8"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/tools/tool.js"></script>

</head>
<body>
<div class="lenos-search">
    <div class="select">
        用户名：
        <div class="layui-inline">
            <input class="layui-input" height="20px" id="username" autocomplete="off">
        </div>
        真实姓名：
        <div class="layui-inline">
            <input class="layui-input" height="20px" id="realName" autocomplete="off">
        </div>
        IP：
        <div class="layui-inline">
            <div class="layui-input-inline">
                <input class="layui-input" height="20px" id="ip" autocomplete="off">
            </div>
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
          <@shiro.hasPermission name="informationpublish:select">
          <button class="layui-btn layui-btn-normal" data-type="add">
              <i class="layui-icon">&#xe608;</i>新增
          </button>
          </@shiro.hasPermission>
    <#--<@shiro.hasPermission name="informationpublish:update">
    <button class="layui-btn layui-btn-normal" data-type="update">
        <i class="layui-icon">&#xe642;</i>编辑
    </button>
    </@shiro.hasPermission>
    <@shiro.hasPermission name="informationpublish:del">
        <button class="layui-btn layui-btn-normal" data-type="detail">
            <i class="layui-icon">&#xe605;</i>查看
        </button>
    </@shiro.hasPermission>-->
    </div>
</div>
<table id="blacklislist" class="layui-hide" lay-filter="user"></table>
<script type="text/html" id="barDemo">
    <@shiro.hasPermission name="informationpublish:select">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    </@shiro.hasPermission>
    <@shiro.hasPermission name="informationpublish:update">
    <a class="layui-btn layui-btn-xs  layui-btn-normal" lay-event="edit">编辑</a>
    </@shiro.hasPermission>
    <@shiro.hasPermission name="informationpublish:del">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </@shiro.hasPermission>
</script>
<script>
    document.onkeydown = function (e) { // 回车提交表单
        var theEvent = window.event || e;
        var code = theEvent.keyCode || theEvent.which;
        if (code == 13) {
            $(".select .select-on").click();
        }
    }
    layui.use('table', function () {
        var table = layui.table,
                laydate = layui.laydate;

        //常规用法
        laydate.render({
            elem: '#publishTime'
        });

        //方法级渲染
        table.render({
            id: 'blacklislist',
            elem: '#blacklislist',
            url: 'showBlacklisList',
            cols: [[
                {field: 'username', title: '用户名'},
                {field: 'realName', title: '真是姓名'},
                {field: 'ip', title: 'ip'},
                {fixed: 'right', field: 'right', title: '操作', toolbar: "#barDemo"}

            ]]
            , page: true
        });

        var $ = layui.$, active = {
            select: function () {
                var username = $('#username').val();
                var realName = $('#realName').val();
                var ip = $('#ip').val();

                table.reload('blacklislist', {
                    where: {
                        username: username,
                        realName: realName,
                        ip: ip,

                    }
                });
            },
            reload: function () {
                $('#username').val('');
                $('#realName').val('');
                $('#ip').val('');
                table.reload('blacklislist', {
                    where: {}
                });
            },
            add: function () {
                add('添加黑名单', 'showAddBlacklis', 400, 250);
            },
            update: function () {
                var checkStatus = table.checkStatus('blacklislist')
                        , data = checkStatus.data;

                update('编辑黑名单', 'blacklislist?id=' + data[0].id, 700, 450);
            },
            detail: function () {
                var checkStatus = table.checkStatus('blacklislist')
                        , data = checkStatus.data;
                if (data.length != 1) {
                    layer.msg('请选择一行查看,已选[' + data.length + ']行', {icon: 5});
                    return false;
                }
                detail('查看黑名单', 'showEidtBlacklist?id=' + data[0].id, 700, 450);
            }
        };

        //监听表格复选框选择
        table.on('checkbox(user)', function (obj) {
            console.log(obj)
        });
        //监听工具条
        table.on('tool(user)', function (obj) {
            var data = obj.data;
            if (obj.event === 'detail') {
                detail('查看权利', 'showEidtBlacklist?id=' + data.id, 700, 450);
            } else if (obj.event === 'del') {
                layer.confirm('确定删除[<label style="color: #00AA91;">' + data.id + '</label>]数据?', {
                    btn: ['确认', '取消']
                }, function (index) {
                    layer.close(index);
                    toolDelByFlag(data.id, '', true, 'blacklislist');
                }, function () {
                });
            } else if (obj.event === 'edit') {
                update('编辑黑名单', 'showEidtBlacklist?id=' + data.id, 700, 450);
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

    function detail(title, url, w, h) {
        if (title == null || title == '') {
            title = false;
        }
        ;
        if (url == null || url == '') {
            url = "error/404";
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
        var index = layer.open({
            id: 'blacklislist-detail',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            resize: false,
            shadeClose: false,
            shade: 0.4,
            title: title,
            content: url + '&detail=true',
            // btn:['关闭']
        });
        layer.full(index);
    }

    /**
     * 更新权利
     */
    function update(title, url, w, h) {
        if (title == null || title == '') {
            title = false;
        }
        if (url == null || url == '') {
            url = "404.html";
        }
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        }
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        }
        var index = layer.open({
            id: 'blacklislist-update',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            resize: false,
            shadeClose: false,
            shade: 0.4,
            title: title,
            closeBtn: 0,
            content: url + '&detail=false'
        });
        layer.full(index);
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
            url = "404.html";
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
        var index = layer.open({
            id: 'blacklislist-add',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            resize: false,
            shadeClose: false,
            shade: 0.4,
            title: title,
            content: url,
            closeBtn: 0
        });
        layer.full(index);
    }
</script>
</body>

</html>
