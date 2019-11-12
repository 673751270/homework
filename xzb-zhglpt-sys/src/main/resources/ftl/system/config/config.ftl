<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>系统配置</title>
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
<body style="background-color:#f2f2f2;">
<div class="layui-row">
    <div class="layui-col-md3">
        <div style="padding: 5px;">
            <div class="layui-card">
                <div class="layui-card-header"><i class="layui-icon" style="color:#00A0B5 "></i>
                    <font size="2"
                          color="#00A0B5">密码复杂度</font>
                </div>
                <div class="layui-card-body" style="color:#00A0B5">
                    <table class="layui-table overflow" lay-skin="">
                        <tbody>
                        <#list complexitys as complexity>
                            <tr>
                                <td>
                                    ${complexity.name}
                                </td>
                                <td>
                                    ${complexity.msg}
                                </td>
                                <td>
                                    <#if complexity.isUse==2>
                                        已使用
                                    <#else >
                                        未使用
                                    </#if>
                                </td>
                                <td>
                                    <button <#if complexity.isUse!=1> class="layui-btn-xs layui-btn layui-btn-danger"
                                        disabled
                                    <#else>
                                        class="layui-btn-xs layui-btn"
                                        onclick="application('${complexity.id}')"
                                    </#if> >应用
                                    </button>
                                </td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-col-md3">
        <div style="padding: 5px;">
            <div class="layui-card">
                <div class="layui-card-header"><i class="layui-icon" style="color:#00A0B5 "></i>
                    <font size="2"
                          color="#00A0B5">登录配置</font>
                </div>
                <div class="layui-card-body layui-form layui-form-pane" style="color:#00A0B5">
                    <div class="layui-form-item">
                        <label for="" class="layui-form-label">
                            <span class="x-red">*</span>错误次数
                        </label>
                        <div class="layui-input-block">
                            <input type="text" id="lockingNumber" name="lockingNumber" lay-verify="lockingNumber"
                                   autocomplete="off" class="layui-input" value="${locking.lockingNumber}">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label for="" class="layui-form-label">
                            <span class="x-red">*</span>锁定时间
                        </label>
                        <div class="layui-input-block">
                            <input type="text" id="lockingMinute" name="lockingMinute" lay-verify="lockingMinute"
                                   autocomplete="off" class="layui-input" value="${locking.lockingMinute}">
                        </div>
                    </div>
                    <div class="layui-form-item" style="text-align: right;">
                        <button class="layui-btn layui-btn-primary" lay-filter="saveConfig" lay-submit="">保存</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    layui.use(['form', 'layer'], function () {
        $ = layui.jquery;
        var form = layui.form
            , layer = layui.layer;


        form.on('submit(saveConfig)', function (data) {
            layerAjax('saveConfig', data.field);
            return false;
        });
    });

    function application(id) {
        layerAjax('complexityApplication', {id: id});
        /*var tab = parent.layui.tab;
        tab.refresh(tab.getId());*/
    }
</script>
</html>