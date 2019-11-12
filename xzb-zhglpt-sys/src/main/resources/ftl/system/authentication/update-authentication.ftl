<#--Created by IntelliJ IDEA.
User:
Date: 2017/12/18
Time: 10:05
To change this template use File | Settings | File Templates.-->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">

<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
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
        <div style="width:100%;overflow: auto;min-height: 800px;">
            <div class="layui-form-item">
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
                    <legend style="font-size:16px;">权利内容</legend>
                </fieldset>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">权力名称</label>
                <div class="layui-input-block">
                    <input type="text" name="title" id="rightName" lay-verify="rightName"
                           value="${authentication.rightName}"
                           placeholder="请输入标题" autocomplete="off" class="layui-input"
                    <#if detail>
            disabled
                    </#if>>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">权利编码</label>
                <div class="layui-input-block">
                    <input type="text" name="rightCode" id="rightCode" lay-verify="rightCode"
                           value="${authentication.rightCode}"
                           placeholder="请输入权利编码" autocomplete="off" class="layui-input"
                    <#if detail>
            disabled
                    </#if>>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">权利人名</label>
                <div class="layui-input-block">
                    <input type="text" name="userNames" id="userNames" lay-verify="userNames"
                           value="${authentication.userNames}"
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


    layui.use(['form', 'layer', 'upload', 'show'], function () {
        $ = layui.jquery;
        var form = layui.form, layer = layui.layer, upload = layui.upload, show = layui.show;


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
            title: [/^.{1,}$/, "不能为空"]
        });

        var files = new Array();
        upload.render({
            elem: '#uploadFile'
            , url: 'upload'
            , accept: 'file'
            , size: 20480
            , multiple: true
            , before: function (obj) {
                //$(".layui-upload-list").show();
                var fs = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function (index, file, result) {
                    //去除重复文件多上传问题
                    if (fs[index].name == file.name && fs[index].size == file.size) {
                        delete fs[index];
                    }

                    var tr = $(['<tr id="upload-' + index + '">'
                        , '<td>' + file.name + '</td>'
                        , '<td>' + (file.size / 1024).toFixed(1) + 'KB</td>'
                        , '<td>等待上传</td>'
                        , '<td>'
                        , '<a class="layui-btn layui-btn-xs demo-reload layui-hide">重传</a>'
                        , '<a class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</a>'
                        , '</td>'
                        , '</tr>'].join(''));

                    //单个重传
                    tr.find('.demo-reload').on('click', function () {
                        obj.upload(index, file);
                    });

                    //删除
                    tr.find('.demo-delete').on('click', function () {
                        delUpFile(new Array(files[index]));
                        delete fs[index]; //删除对应的文件
                        delete files[index]; //删除对象数组对象
                        tr.remove();
                        /*if($("#demoList tr").eq(0).html()==undefined){
                          $(".layui-upload-list").hide();
                        }*/
                    });

                    $("#demoList").append(tr);
                });
            }
            , done: function (res, index, upload) {
                if (res.flag) { //上传成功
                    files[index] = res.data;
                    var tr = $("#demoList").find('tr#upload-' + index)
                            , tds = tr.children();
                    tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                }
            }, error: function (index, upload) {
                var tr = $("#demoList").find('tr#upload-' + index)
                        , tds = tr.children();
                tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
            }
        });
        $('#close').click(function () {
            var list = mapToArray(files);
            if (list === undefined || list.length == 0) {
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            } else {
                layer.confirm('您以上传文件是否要离开吗?', {
                    btn: ['确定', '取消']
                }, function () {
                    delUpFile(list);
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                }, function () {

                });
            }
        });
        //监听提交
        form.on('submit(add)', function (data) {
            data.field.id =${authentication.id};
            data.field.rightName = $("#rightName").val();
            data.field.rightCode = $("#rightCode").val();
            var s = $("#userNames").val();
            data.field.userIds = s.substring(0, s.lastIndexOf(','));
            layerAjax('updateAuthentication', data.field, 'authenticationlist');
            return false;
        });
        form.render();
    });
</script>
</body>

</html>
