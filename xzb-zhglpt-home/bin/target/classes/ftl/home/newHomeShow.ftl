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
        html, body {
            height: 100%;
            width: 100%;
        }

        table th {
            background-color: #00A0B5;
            color: #ffffff;
        }

        .layadmin-backlog-body {
            display: block;
            padding: 10px 15px;
            background-color: #f2f2f2;
            color: #999;
            border-radius: 2px;
            transition: all .3s;
            -webkit-transition: all .3s;
        }

        .layadmin-backlog-body p cite {
            font-style: normal;
            font-size: 25px;
            font-weight: 300;
            color: #009688;
        }

        .layadmin-carousel .layui-col-space10 {
            margin: 0;
        }

        .layadmin-backlog-body h3 {
            padding-bottom: 10px;
            font-size: 12px;
        }

        #layadmin-shortcut {
            text-align: center;
        }

        #layadmin-shortcut i {
            display: inline-block;
            width: 100%;
            height: 90%;
            line-height: 80px;
            text-align: center;
            border-radius: 2px;
            font-size: 30px;
            color: #333;
            transition: all .3s;
            -webkit-transition: all .3s;
        }

        .ulcc li {
            float: left;
            width: 40%;
        }

        #layadmin-shortcut cite {
            position: relative;
            top: 2px;
            display: block;
            color: #666;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            font-size: 14px;
        }
    </style>
</head>
<body style="background-color:#f2f2f2;">
<div class="layui-row">
    <div class="layui-col-md5" style="margin-right: 1%;width: 49%;margin-top: 1%;">
        <div class="layui-card">
            <div class="layui-card-header"><font color="#00A0B5" size="2">网办系统</font>
                <button class="layui-btn layui-btn-xs" style="float: right;position: relative;top: 25%;">进入</button>
            </div>
            <div class="layui-card-body" style="height: 150px;overflow: auto;">
                <div carousel-item="">

                </div>
            </div>
        </div>
    </div>

    <div class="layui-col-md5" style="background-color: #ffffff;width: 49%;margin-right: 1%;margin-top: 1%;">
        <div class="layui-card">
            <div class="layui-card-header"><font color="#00A0B5" size="2">OA系统</font>
                <button class="layui-btn layui-btn-xs" style="float: right;position: relative;top: 25%;"
                        onclick="verification('sayOA')">
                    进入
                </button>
            </div>
            <div class="layui-card-body" style="height: 150px;">
                <div id="main5" style="height:100%;width: 100%"></div>
            </div>
        </div>
    </div>

    <div class="layui-col-md5" style="background-color: #ffffff;width: 49%;margin-right: 1%;margin-top: 1%;">
        <div class="layui-card">
            <div class="layui-card-header"><font color="#00A0B5" size="2">廉政风险防控系统</font>
                <button class="layui-btn layui-btn-xs" style="float: right;position: relative;top: 25%;">进入</button>
            </div>
            <div class="layui-card-body" style="height: 150px;">
                <div id="main5" style="height:100%;width: 100%"></div>
            </div>
        </div>
    </div>

    <div class="layui-col-md5" style="background-color: #ffffff;width: 49%;margin-top: 1%;">
        <div class="layui-card">
            <div class="layui-card-header"><font color="#00A0B5" size="2">信息发布</font>
                <button class="layui-btn layui-btn-xs" style="float: right;position: relative;top: 25%;"
                        onclick="toPublish();">进入
                </button>
            </div>
            <div class="layui-card-body" style="height:150px;">
                <#if (result.data.noticeInfos?size>0)>

                    <table class="layui-table" lay-skin="nob">
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
                                <td>
                                    ${noticeInfo.title}
                                </td>
                                <td>
                                    ${noticeInfo.importantType}
                                </td>
                                <td>
                                    ${noticeInfo.publishTime?string('yyyy-MM-dd HH:mm:ss')}
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
                window.open(data.data);
            }, error: function (data) {
                alert('发生错误请联系管理员！')
            }
        });
    }
</script>
</html>
