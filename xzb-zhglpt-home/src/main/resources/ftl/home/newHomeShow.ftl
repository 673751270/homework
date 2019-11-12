<#-- Created by IntelliJ IDEA.
 User: Administrator
 Date: 2017/12/6
 Time: 14:00
 To change this template use File | Settings | File Templates.
 切片管理-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>切片管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi"/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/layui/css/layui.css">
    <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/tools/tool.js"></script>
    <!--<script type="text/javascript" src="${re.contextPath}/plugin/common/js/echarts.js"></script>
    <script type="text/javascript" src="${re.contextPath}/ftl/section/layui/layui.js"
            charset="utf-8"></script>-->
    <script type="text/javascript" src="${re.contextPath}/plugin/layui/layui.all.js"
            charset="utf-8"></script>
    <style>
        tbody td {
            cursor: pointer;
        }

        .overflow {
            table-layout: fixed;
        }

        .overflow td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body style="background-color:#f2f2f2;">
<div class="layui-row">
    <div class="layui-col-md6">
        <div style="padding: 5px">
            <div class="layui-card">
                <div class="layui-card-header"><i class="layui-icon" style="color:#00A0B5 "></i><font color="#00A0B5"
                                                                                                       size="2">网办系统</font>
                    <div style="float: right">
                        <button class="layui-btn layui-btn-xs" onclick="verification('openWB')">进入</button>
                    </div>
                </div>
                <div class="layui-card-body" style="min-height:414px;">
                </div>
            </div>
        </div>
    </div>

    <div class="layui-col-md6">
        <div style="padding: 5px">
            <div class="layui-card">
                <div class="layui-card-header"><i class="layui-icon" style="color:#00A0B5 "></i><font color="#00A0B5"
                                                                                                       size="2">OA系统</font>
                    <div style="float: right">
                        <button class="layui-btn layui-btn-xs"
                                onclick="verification('openOA')">
                            进入
                        </button>
                    </div>
                </div>
                <div class="layui-card-body" style="color:#00A0B5;min-height:300px;">
                    您目前有<label style="font-weight:bold;color: red;">[${result.data.processesCount}]</label>项待办工作
                    <div>
                        <#if (result.data.processResults?size>0)>
                            <table class="layui-table overflow" lay-skin="nob">
                                <tbody>
                                <#list result.data.processResults as process>
                                    <tr onclick="getActiviti('${process.processTypeId}','${process.id}','${process.type}')">
                                        <td>
                                            ${process.serialNumber}
                                        </td>
                                        <td>
                                            <#if process.fwzh??>
                                                ${process.fwzh}
                                            <#else>
                                                无
                                            </#if>
                                        </td>
                                        <td>
                                            ${process.processType}
                                        </td>
                                        <td title="${process.processTitle }">
                                            <#if process.urgency=='特急' || process.urgency=='特提'>
                                            <span style="color:  #FF0000;">
                                <#elseif process.urgency=='加急'>
                                <span style="color:  #FFB800;">
                            <#else>
                                    <span style="color:  #00AA91;">
                                </#if>[${process.urgency}]&nbsp;${process.processTitle}</span>

                                        </td>
                                        <td>${process.upperName}
                                        </td>
                                        <td>
                                            <#if !process.cbState??>
                                                无
                                            <#else>
                                                <span style="color: #00AA91;">
                                                ${process.cbState}</span>
                                            </#if>
                                        </td>
                                    </tr>
                                </#list>
                                </tbody>
                            </table>
                        <#else >
                            <div style="text-align: center">
                                <i class="layui-icon layui-icon-404" style="font-size: 32px"></i>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-col-md6">
        <div style="padding: 5px">
            <div class="layui-card">
                <div class="layui-card-header"><i class="layui-icon" style="color:#00A0B5 "></i><font color="#00A0B5"
                                                                                                       size="2">廉政风险防控系统</font>
                    <div style="float: right">
                        <button class="layui-btn layui-btn-xs">进入</button>
                    </div>
                </div>
                <div class="layui-card-body" style="min-height:300px;">
                </div>
            </div>
        </div>
    </div>

    <div class="layui-col-md6">
        <div style="padding: 5px">
            <div class="layui-card">
                <div class="layui-card-header"><i class="layui-icon" style="color:#00A0B5 "></i><font color="#00A0B5"
                                                                                                       size="2">信息发布</font>
                    <div style="float: right">
                        <button class="layui-btn layui-btn-xs"
                                onclick="toPublish();">进入
                        </button>
                    </div>
                </div>
                <div class="layui-card-body" style="min-height:300px;">
                    <#if (result.data.noticeInfos?size>0)>

                        <table class="layui-table overflow" lay-skin="nob">
                            <tbody>
                            <#list result.data.noticeInfos as noticeInfo>
                                <tr onclick="layer.full(layer.open({
                                        type:2,
                                        title:'查看信息发布',
                                        area: [window.innerWidth/2+'px', window.innerHeight/2+'px'],
                                        shadeClose: true,
                                        anim: 2,
                                        content:'${re.contextPath}/informationpublish/updateInformationPublish?id=${noticeInfo.id}&detail=true'
                                        }))">
                                    <td title="${noticeInfo.title }">
                                        ${noticeInfo.title}
                                    </td>
                                    <td>
                                        ${noticeInfo.importantType}
                                    </td>
                                    <td>
                                        ${noticeInfo.publishTime?string('MM-dd')}
                                    </td>
                                </tr>
                            </#list>
                            </tbody>
                        </table>
                    <#else >
                        <div style="text-align: center">
                            <i class="layui-icon layui-icon-404" style="font-size: 32px"></i>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
    function toPublish() {
        window.location.href = "${re.contextPath}/informationpublish/showInformationPublish"
    }

    function verification(verifyUrl) {
        $.ajax({
            method: 'GET',
            url: verifyUrl,
            success: function (data) {
                if (data.flag) {
                    window.open(data.data);
                } else {
                    alert('认证失败,重新登录或联系管理员！')
                }
            }, error: function (data) {
                alert('发生错误请联系管理员！')
            }
        });
    }
</script>
</html>
