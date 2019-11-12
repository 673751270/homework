<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加权利</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/layui/css/layui.css">
    <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/layui/layui.all.js" charset="utf-8"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/tools/tool.js"></script>
</head>
<div class="x-body">
    <div class="layui-form layui-form-pane" style="margin: 20px;">
        <div style="width:100%;overflow: auto;min-height: 800px;">
            <div class="layui-form-item">
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
                    <legend style="font-size:16px;">权利内容</legend>
                </fieldset>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">权力名称</label>
                <div class="layui-input-block">
                    <input type="text" name="title" id="rightName" lay-verify="title" placeholder="请输入标题"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">权利编码</label>
                <div class="layui-input-block">
                    <input type="text" name="title" id="rightCode" lay-verify="title" placeholder="请输入标题"
                           autocomplete="off"
                           class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label for="email" class="layui-form-label">
                    <span class="x-red"></span>权利人
                </label>
                <div class="layui-input-block">
                    <input type="text" lay-verify="userNames" autocomplete="off"
                           class="layui-input" name="userNames" id="userNames" placeholder="请选择">
                </div>
            </div>
        </div>
        <div style="width: 100%;height: 55px;background-color: white;border-top:1px solid #e6e6e6;
  position: fixed;bottom: 0px;margin-left:-20px;">
            <div class="layui-form-item" style=" float: right;margin-right: 30px;margin-top: 8px" id="buttons">

                <button class="layui-btn layui-btn-normal" lay-filter="add" lay-submit="" id="add">
                    保存
                </button>
                <button class="layui-btn layui-btn-primary" id="close">
                    取消
                </button>
            </div>
        </div>
    </div>
</div>
<body>
<script>
    layui.config({
        base: '${re.contextPath}/plugin/tools/' //此处路径请自行处理, 可以使用绝对路径
    }).extend({
        show: 'show'
    });


    layui.use(['form', 'layer', 'upload', 'show'], function () {
        $ = layui.jquery;
        var form = layui.form, layer = layui.layer, show = layui.show;


        show.into("userList", "请选中用户然后添加", 700, window.innerHeight, '#userNames', 'checkbox',
                {
                    d: [
                    <#list department as d>
                    {
                        "name": "${d.departmentName}", "value": "${d.id}", "size": "${d.users?size}", u: [
                            <#list d.users as u>
                                <#if curentUser.id!=u.id>
                            {"name": "${u.realName}", "value": "${u.id}", "typeId": "${d.id}"},
                                </#if>
                            </#list>
                        ]
                    },
                    </#list>
                    ]
                }, true);


        //自定义验证规则
        form.verify({
            userNames: function (value) {
                if (value == "") {
                    return '你还未选择收信人';
                }
            }
            , title: [/^.{1,}$/, "不能为空"]
            , content: function (value) {
                if (layedit.getContent(editIndex) == "") {
                    return '不能为空';
                }
            }
        });


        $('#close').click(function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);

        });
        //监听提交
        form.on('submit(add)', function (data) {
            var rightName = $('#rightName').val();
            var rightCode = $('#rightCode').val();
            // var userIds = $('#userNames').val();
            var s = $('#userNames').val();
            var userIds = s.substring(0, s.lastIndexOf(','));


            var dataInput = {
                rightName: rightName,
                rightCode: rightCode,
                userIds: userIds
            }

            layerAjax('addAuthentication', dataInput, 'authenticationlist');
            return false;
        });
        form.render();
    });
</script>
</body>

</html>
