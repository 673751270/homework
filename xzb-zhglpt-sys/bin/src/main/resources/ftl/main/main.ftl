<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>广州市协作办公室综合管理平台</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <link href="" rel="stylesheet">
    <link rel="shortcut icon" href="${re.contextPath}/plugin/x-admin/images/bizhou.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/plugins/font-awesome/css/font-awesome.min.css" media="all"/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/build/css/app.css" media="all"/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/build/css/themes/default.css" media="all" id="skin" kit-skin/>
    <link rel="stylesheet" href="${re.contextPath}/plugin/layuitree/layui/css/layui.css">
    <link rel="stylesheet" href="${re.contextPath}/plugin/lenos/main.css"/>
    <script type="text/javascript" src="${re.contextPath}/plugin/jquery/jquery-3.2.1.min.js"></script>
    <script src="${re.contextPath}/plugin/plugins/layui/layui.js"></script>
    <script src="${re.contextPath}/plugin/tools/main.js"></script>
    <style>

        .kit-layout-admin .kit-sided {
            width: 50px !important;
            top: 50px !important;
        }
        <#--前端无聊美化ing-->
        .layui-footer {
            background-color: #2F4056;
        }

        .layui-side-scroll {
            border-right: 3px solid #009688;
        }

        .layui-body {
            bottom: 0px;
        }
    </style>
</head>

<body class="kit-theme">
<div class="layui-layout layui-layout-admin kit-layout-admin">
    <div class="layui-header">
        <div class="layui-logo" style="width:300px;font-size:18px"><b>广州市协作办公室综合管理系统</b></div>
        <div class="layui-logo kit-logo-mobile" style="padding-left:20px"></div>
        <div class="layui-hide-xs" style="margin-left:500px">
            <ul class="layui-nav layui-layout-left kit-nav" style="margin-left:120px">
            <#--  kit-target data-options="{url:'${re.contextPath}/menu/ceshi',icon:'&#xe658;',title:'系统管理',id:'966'}"-->
            <#--<li class="layui-nav-item"><a href="javascript:;"  onclick="changemenu(0)">系统管理</a></li>-->

            <#--  <li class="layui-nav-item"><a href="${re.contextPath}/main">场景首页</a></li>-->
                <#list menu as child>
                <#-- <li class="layui-nav-item" id="main_${child_index}"><a href="${re.contextPath}/menuMain?type=${child_index}&url=${child.url}&name=${child.name}" >${child.name}</a></li>-->
                   <li class="layui-nav-item" id="main_${child_index}"><a href="javascript:;"
                                                                          onclick="changemenu(${child_index})">${child.name}</a>
                   </li>
                </#list>


            <#--data-options="{url:'${re.contextPath}/menu/leftmenu',iconkit-targetr:'&#xe658;',title:'文章管理',id:'966'}"-->
            <#--<li class="layui-nav-item"><a href="${re.contextPath}/menu/leftmenu">文章管理</a>-->
            <#--</li>-->
            <#--<li class="layui-nav-item"><a href="javascript:;"onclick="changemenu(1)">测试管理</a>-->
            <#--</li>-->
            <#--<li class="layui-nav-item"><a href="${re.contextPath}/menu/menulist" target="test"/>框架测试</li>-->
            <#--&lt;#&ndash;<li class="layui-nav-item"><a href="javascript:;" id="pay"><i class="fa fa-gratipay" aria-hidden="true"></i> 捐赠我</a></li>&ndash;&gt;-->
            <#--<li class="layui-nav-item">-->
            </ul>
        </div>
        <ul class="layui-nav layui-layout-right kit-nav">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <i class="layui-icon">&#xe63f;</i> 皮肤</a>
                </a>
                <dl class="layui-nav-child skin">
                    <dd><a href="javascript:;" data-skin="default" style="color:#393D49;"><i
                            class="layui-icon">&#xe658;</i> 默认</a></dd>
                    <dd><a href="javascript:;" data-skin="orange" style="color:#ff6700;"><i
                            class="layui-icon">&#xe658;</i> 橘子橙</a></dd>
                    <dd><a href="javascript:;" data-skin="green" style="color:#00a65a;"><i
                            class="layui-icon">&#xe658;</i> 春天绿</a></dd>
                    <dd><a href="javascript:;" data-skin="pink" style="color:#FA6086;"><i
                            class="layui-icon">&#xe658;</i> 少女粉</a></dd>
                    <dd><a href="javascript:;" data-skin="blue.1" style="color:#00c0ef;"><i
                            class="layui-icon">&#xe658;</i> 天空蓝</a></dd>
                    <dd><a href="javascript:;" data-skin="red" style="color:#dd4b39;"><i class="layui-icon">&#xe658;</i>
                        枫叶红</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">
        <#assign currentUser = Session["curentUser"]>
                    <img src="${re.contextPath}/images/${currentUser.photo}"
                         class="layui-nav-img">${currentUser.username}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" id="info"><span>基本资料</span></a></dd>
                    <dd><a href="javascript:;" id="rePass">修改密码</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="out"><i class="fa fa-sign-out" aria-hidden="true"></i> 注销</a></li>
        </ul>
    </div>

    <#macro tree data start end>
        <#if (start=="start")>
    <div class="layui-side   layui-nav-tree layui-bg-black kit-side">
    <div class="layui-side-scroll">
    <div id="test" class="kit-side-fold"><i class="fa fa-navicon" aria-hidden="true"></i></div>
    <ul class="layui-nav layui-nav-tree" lay-filter="kitNavbar" kit-navbar>
        </#if>
        <#list data as child>
            <#if child.children?size gt 0>
                <#list  child.children as secondchild >
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">
                        <i aria-hidden="true" class="layui-icon">${secondchild.icon}</i>
                        <span> ${secondchild.name}</span>
                    </a>
                    <dl class="layui-nav-child">
                        <@tree data=secondchild.children start="" end=""/>
                    </dl>
                </li>
                </#list>
            <#else>
            <dd>
                <a href="javascript:;" kit-target
                   data-options="{url:'${child.url}',icon:'${child.icon}',title:'${child.name}',id:'${child.id}'}">
                    <i class="layui-icon">${child.icon}</i><span> ${child.name}</span>
                </a>
            </dd>
            </#if>
        </#list>
        <#if (end=="end")>
    </ul>
    </div>
    </div>
        </#if>
    </#macro>
    <div id="maincd">
        <div id="div1" style="display: block;"><@tree data=menu[0] start="start" end="end"/></div>
        <div id="div2" style="display:none;"><@tree data=menu[1] start="start" end="end"/></div>
        <div id="div3" style="display: none;"><@tree data=menu[2] start="start" end="end"/></div>
        <div id="div4" style="display: none;"><@tree data=menu[3] start="start" end="end"/></div>
        <div id="div5" style="display: none;"><@tree data=menu[4] start="start" end="end"/></div>
    </div>
    <form action="" method="post" id="openform">
        <div>
            <input type="hidden" name="type" id="type">
            <input type="hidden" name="name" id="name">
            <input type="hidden" name="url" id="url">
            <input type="hidden" name="cardType" id="cardType">
            <input type="hidden" name="cardValue" id="cardValue">
            <input type="hidden" name="tokendate" id="tokendate">

        </div>
    </form>
    <div class="layui-body" <#--style="border:1px solid red;padding-bottom:0;"--> id="container">
        <!-- 内容主体区域 -->

        <div style="padding: 15px;"><i class="layui-icon layui-anim layui-anim-rotate layui-anim-loop">&#xe63e;</i>
            请稍等...
        </div>
    </div>
    <script>
        $("#rePass").click(function () {
            addOpen('user-rePwd', '修改密码', 'user/goRePass?id=${curentUser.id}', 500, 350);
        })

        $("#info").click(function () {
            addOpen('user-info', '个人资料', 'user/updateUser?id=${curentUser.id}', 700, 520);
        })

        function addOpen(id, title, url, w, h) {
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
            layer.open({
                id: id,
                type: 2,
                area: [w + 'px', h + 'px'],
                fix: false,
                maxmin: true,
                shadeClose: true,
                shade: 0.4,
                title: title,
                content: url,
            });
        }


        $("#openform input").val('');
        $(".layui-body").removeAttr("style");
        $("#main_0").addClass("layui-this");

        function open4() {
            var diag = new Dialog();

            diag.Width = 300;

            diag.Height = 100;


            diag.Title = "内容页为html代码的窗口";

            diag.InnerHtml = '<div style="text-align:center;color:red;font-size:14px;">直接输出html，使用 <b>InnerHtml</b> 属性。</div>'

            diag.OKEvent = function () {
                diag.close();
            };//点击确定后调用的方法

            diag.show();

        }


        /*
        * 2019/1/7
        * 更换上部菜单栏*/
        function changemenu(type) {
            $("#maincd").show();
            $(".layui-body").removeAttr("style");
            if (type == 0) {
                $("#div5").hide();
                $("#div4").hide();
                $("#div3").hide();
                $("#div2").hide();
                $("#div1").show();
            }
            if (type == 1) {

                $("#div2").show();
                $("#div1").hide();
                $("#div3").hide();
                $("#div4").hide();
                $("#div5").hide();


            }
            if (type == 2) {

                $("#div1").hide();
                $("#div2").hide();
                $("#div3").show();
                $("#div4").hide();
                $("#div5").hide();
            }
            if (type == 3) {

                $("#div1").hide();
                $("#div2").hide();
                $("#div3").hide();
                $("#div4").show();
                $("#div5").hide();
            }
            if (type == 4) {

                $("#div1").hide();
                $("#div2").hide();
                $("#div3").hide();
                $("#div4").hide();
                $("#div5").show();
            }
        }

        function shouye() {
            $("#maincd").hide();
            $(".layui-body").css({'left': '0px'});
            $(".layui-body").empty();
            $('.layui-body').append('<iframe src="${re.contextPath}/home/showHomeModel" style="width:100%;height:100%;"></iframe>');
            /* $.ajax({
                type: "POST",
                url: '${re.contextPath}/home/showHomeModel',
    			data:{},
    			success:function(data){
    				$('.layui-body').html(data);
    			}
    		}); */
        }
    </script>
</body>
</html>
