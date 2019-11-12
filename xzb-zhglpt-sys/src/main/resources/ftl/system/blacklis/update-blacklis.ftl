<#--Created by IntelliJ IDEA.
User:
Date: 2017/12/18
Time: 10:05
To change this template use File | Settings | File Templates.-->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">

<head>
    <meta charset="UTF-8">
    <title>黑名单管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/layui/css/layui.css">
    <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/layui/layui.all.js" charset="utf-8"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/tools/tool.js"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/tools/update-setting.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var flag = '${detail}';
            if (flag) {
                $("form").disable();
            }
        });
    </script>

</head>
<body>
<div class="x-body">
    <div class="layui-form layui-form-pane" style="margin: 20px;">
        <div style="width:30%;overflow: auto;min-height: 200px;margin: 0 auto;">
            <div class="layui-form-item">
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
                    <legend style="font-size:16px;">黑名单内容</legend>
                </fieldset>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <input type="text" name="userName" id="userName" lay-verify="userName"
                           value="${blacklist.username}"
                           placeholder="请输入标题" autocomplete="off" class="layui-input"
                    <#if detail>
            disabled
                    </#if>>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">真实姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="realName" id="realName" lay-verify="realName"
                           value="${blacklist.realName}"
                           placeholder="请输入权利编码" autocomplete="off" class="layui-input"
                    <#if detail>
            disabled
                    </#if>>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">ip</label>
                <div class="layui-input-block">
                    <input type="text" name="ip" id="ip" lay-verify="ip"
                           value="${blacklist.ip}"
                           placeholder="请输入权利人名" autocomplete="off" class="layui-input"
                    <#if detail>
            disabled
                    </#if>>
                </div>
            </div>
        </div>
      <#if !detail>
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
      </#if>
    </div>
</div>
<script>
    layui.config({
        base: '${re.contextPath}/plugin/tools/' //此处路径请自行处理, 可以使用绝对路径
    }).extend({
        show: 'show'
    });


    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form, layer = layui.layer;

        //自定义验证规则
        form.verify({
            title: [/^.{1,}$/, "不能为空"]
        });


        $('#close').click(function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);

        });
        //监听提交
        form.on('submit(add)', function (data) {
            data.field.id =${blacklist.id};
            data.field.username = $("#userName").val();
            data.field.realName = $("#realName").val();
            data.field.ip = $("#ip").val();

            layerAjax('updateBlacklist', data.field, 'blacklislist');
            return false;
        });
        form.render();
    });
</script>
</body>

</html>
