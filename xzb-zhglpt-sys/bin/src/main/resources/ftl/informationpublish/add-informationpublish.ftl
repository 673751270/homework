<#--Created by IntelliJ IDEA.
User: Administrator
Date: 2017/12/7
Time: 12:40
To change this template use File | Settings | File Templates.-->

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>添加信息发布</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
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
                    <legend style="font-size:16px;">信息发布内容</legend>
                </fieldset>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">信息标题</label>
                <div class="layui-input-block">
                    <input type="text" name="title" id="title" lay-verify="title" placeholder="请输入标题" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-row">

                <div class="layui-inline layui-col-md6">
                    <label class="layui-form-label" style="overflow: auto">发布信息类型</label>
                    <div class="layui-input-inline layui-col-md10">
                    <select name="informationType" id="informationType" lay-filter="informationType" lay-verify="required" lay-search>
                        <option selected></option>
                        <#list informationTypes as ift>
                            <option value="${ift.code}" >${ift.dvalue}</option>
                        </#list>
                    </select>
                    </div>
                </div>

                <div class="layui-inline layui-col-md6">
                    <label class="layui-form-label">重要程度</label>
                    <div class="layui-input-inline layui-col-md10">
                    <select name="importantType" id="importantType" lay-filter="importantType">
                        <#list importantTypes as it>
                            <option value="${it.code}" <#if it_index=0>selected</#if>>${it.dvalue}</option>
                        </#list>
                    </select>
                    </div>
                </div>
            </div>


            <div class="layui-form-item">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend style="font-size:16px;">附件上传</legend>
                </fieldset>
                <div class="layui-input-inline">
                    <div class="layui-upload-drag" id="uploadFile" style="margin-left: 1px;">
                        <i style="font-size:30px;" class="layui-icon"></i>
                        <p style="font-size: 10px">点击上传，或将文件拖拽到此处</p>
                    </div>
                </div>
            </div>

            <div class="layui-upload-list" style="display:none;">
                <table class="layui-table" style="margin:0;">
                    <thead>
                    <tr><th>文件名</th>
                        <th>大小</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr></thead>
                    <tbody id="demoList"></tbody>
                </table>
            </div>
            <div style="height:50px;"></div>
        </div>
        <div style="width: 100%;height: 55px;background-color: white;border-top:1px solid #e6e6e6;
  position: fixed;bottom: 0px;margin-left:-20px;">
            <div class="layui-form-item" style=" float: right;margin-right: 30px;margin-top: 8px" id="buttons">

                <button  class="layui-btn layui-btn-normal"  lay-filter="add" lay-submit="" id="add">
                    保存
                </button>
                <button  class="layui-btn layui-btn-primary" id="close">
                    取消
                </button>
            </div>
        </div>
    </div>
</div>
<body>
<script>
    layui.use(['form','layer','upload'], function(){
        $ = layui.jquery;
        var form = layui.form
            ,layer = layui.layer,
            upload = layui.upload;


        //自定义验证规则
        form.verify({
            title: [/^.{1,}$/, "不能为空"]
        });

        var files= new Array();
        upload.render({
            elem: '#uploadFile'
            ,url: 'upload'
            ,accept:'file'
            ,size:20480
            ,multiple:true
            ,before: function(obj){
                $(".layui-upload-list").show();
                var fs = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function(index, file, result){
                    //去除重复文件多上传问题
                    if(fs[index].name==file.name && fs[index].size==file.size){
                        delete fs[index];
                    }

                    var tr = $(['<tr id="upload-'+ index +'">'
                        ,'<td>'+ file.name +'</td>'
                        ,'<td>'+ (file.size/1024).toFixed(1) +'KB</td>'
                        ,'<td>等待上传</td>'
                        ,'<td>'
                        ,'<a class="layui-btn layui-btn-xs demo-reload layui-hide">重传</a>'
                        ,'<a class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</a>'
                        ,'</td>'
                        ,'</tr>'].join(''));

                    //单个重传
                    tr.find('.demo-reload').on('click', function(){
                        obj.upload(index, file);
                    });

                    //删除
                    tr.find('.demo-delete').on('click', function(){
                        delUpFile(new Array(files[index]));
                        delete fs[index]; //删除对应的文件
                        delete files[index]; //删除对象数组对象
                        tr.remove();
                        if($("#demoList tr").eq(0).html()==undefined){
                            $(".layui-upload-list").hide();
                        }
                    });

                    $("#demoList").append(tr);
                });
            }
            ,done: function(res, index, upload){
                if(res.flag){ //上传成功
                    files[index]=res.data;
                    var tr = $("#demoList").find('tr#upload-'+ index)
                        ,tds = tr.children();
                    tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                }
            },error: function(index, upload){
                var tr = $("#demoList").find('tr#upload-'+ index)
                    ,tds = tr.children();
                tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
            }
        });
        $('#close').click(function(){
            var list= mapToArray(files);
            if(list === undefined || list.length == 0){
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            }else{
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
        form.on('submit(add)', function(data){
            data.field.list=JSON.stringify(mapToArray(files));
            layerAjax('addInformationPublish',data.field, 'informationpublishList');
            return false;
        });
        form.render();
    });
</script>
</body>

</html>
