/*
	版权所有 2009-2019 荆门泽优软件有限公司
	保留所有权利
	官方网站：http://www.ncmem.com
	官方博客：http://www.cnblogs.com/xproer
	产品首页：http://www.ncmem.com/webapp/up2/index.aspx
	在线演示：http://www.ncmem.com/products/http-uploader/demo2/index.html
	开发文档：http://www.cnblogs.com/xproer/archive/2011/03/15/1984950.html
	升级日志：http://www.cnblogs.com/xproer/archive/2011/03/15/1985091.html
	示例下载：http://www.ncmem.com/download/up2/asp.net/up2.rar
	文档下载：http://www.ncmem.com/download/up2/up2-doc.rar
	联系邮箱：1085617561@qq.com
	联系QQ：1085617561
    版本：1.3
	更新记录：
		2009-11-05 创建
		2014-02-28 使用jquery优化代码并增强兼容性。
        2018-08-30 优化样式，
*/

var HttpUploaderErrorCode = {
	  "0": "发送数据错误"
	, "1": "接收数据错误"
	, "2": "域名未授权"
	, "3": "公司未授权"
	, "4": "访问本地文件错误"
    //md5
	, "200": "无打打开文件"
	, "201": "文件大小为0"
};

function HttpUploaderMgr()
{
    var _this = this;
	//http://www.ncmem.com/
	this.Domain = "http://" + document.location.host;
	
	this.Config = {
		"EncodeType"		: "gb2312"//UTF-8,GB2312。文件名称编码方式，与web.config-requestEncoding配置对应
		, "Version"			: "2,5,54,51373"
		, "Company"			: "荆门泽优软件有限公司"
		, "License"			: ""
		, "Debug"			: false//调试开关
        , "Droper"			: true//拖拽组件(ie)
		, "LogFile"			: "C:\\log.txt"//日志文件路径
		, "FileFilter"		: "*"//文件类型。所有类型：*。自定义类型：jpg,png,gif,bmp
	    //字节计算器：http://www.beesky.com/newsite/bit_byte.htm
	    //超过10MB建议选择HttpUploader6：http://www.ncmem.com/webplug/http-uploader6/index.asp
		, "FileSizeLimit"	: 10485760//允许上传的文件大小，默认10MB
		, "AllowMultiSelect": true//多选开关。true:开启多选。false:关闭多选
		, "CryptoType"      : "md5"//文件校验方式：md5,crc,sha1
		, "InitDir"			: "D:\\"//初始路径。示例：D:\\Soft
		, "Compress"		: ""//是否开启压缩。值：zip,gzip
		, "AppPath"			: ""//网站虚拟目录名称。子文件夹 web
		, "FileFieldName"	: "file"//文件字段名称
		, "Cookie"	        : ""//cookie
        , "Authenticate"    : {type:"ntlm",name:"",pass:""}//域环境信息
		, "PostUrl"			: "http://localhost:8080/up2/upload.jsp"
	    //x86
        , ie: {
            drop: { clsid: "4D2454F8-EB25-465f-B867-C2A3E9F3D4B4", name: "Xproer.HttpDroper2" }
            , part: { clsid: "6F3EB4AF-FC9C-4570-A686-88B4B427C6FE", name: "Xproer.HttpPartition2" }
            , path: "http://www.ncmem.com/download/up2/up2.cab"
        }
	    //x64
        , ie64: {
            drop: { clsid: "C9388115-887C-4d64-B175-F8F1AA5437BF", name: "Xproer.HttpDroper2x64" }
            , part: { clsid: "3AFFCB6D-55ED-4ada-A1EC-D7D87BA29E51", name: "Xproer.HttpPartition2x64" }
            , path: "http://www.ncmem.com/download/up2/up64.cab"
        }
        , firefox: { name: "", type: "application/npHttpUp2", path: "http://www.ncmem.com/download/up2/up2.xpi" }
        , chrome: { name: "npHttpUp2", type: "application/npHttpUp2", path: "http://www.ncmem.com/download/up2/up2.crx" }
        , edge: { protocol: "up2", port: 9300, visible: false }
        , exe: { path: "http://www.ncmem.com/download/up2/up2.exe" }
	};
	
	//附加参数
	this.Fields = {
		 "uname": "test"
		,"upass": "123456"
    };
    this.event = {
        "post_complete": function (url) { },
        "queue_complete": function (url) { },
        "add_file": function () { }
    };

    this.websocketInited = false;
	this.filesMap = new Object();//文件对象,(id,json),(id,json)
	this.Droper = null;
    this.filesUI = null;//上传列表面板
    this.ieParter = null;
	this.parter = null;//
	this.tmpFile = null;
    this.tmpSpliter = null;
    this.btnSetup = null;
    this.toolBar = null;//jquery object
	this.setupBar = null;
	this.setupBarExe = null;
	this.nat_loaded = false;
	
	this.postAll = function () { this.app.queuePost(); };
	this.part_files = function (ret)
	{
	    if (ret.files == null) return;
	    for (var i = 0, l = ret.files.length; i < l; ++i)
	    {
	        var f = ret.files[i];
	        this.addFileLoc(f);
	        //jQuery.extend(f, this.Fields);//附加字段
	        //jQuery.extend(f, { name: "test" });
	        //this.browser.updateFile(f);//增加扩展信息
	    }
	};
	this.drag_enter = function(arg){}
	this.drag_leave = function(arg){}
	this.drop_files = function (ret)
	{
	    this.part_files(ret);
	};
	this.post_complete = function (ret)
	{
	    var f = this.filesMap[ret.id];
	    f.postComplete(ret);
		//服务器返回信息
	    //alert(ret.res);
	    f.remove();
	    delete f;
	    this.filesMap[ret.id] = null;
	};
	this.post_error = function (ret)
	{
	    if (ret.value == "12")
	    {
	        this.setupTip();
	        return;
	    }
	    if (ret.value == "2")
	    {
	        alert(HttpUploaderErrorCode[ret.value]);
	        return;
	    }
	    var f = this.filesMap[ret.id];
	    f.postError(ret);
	};
	this.post_process = function (ret)
	{
	    var f = this.filesMap[ret.id];
	    f.postProcess(ret);
	};
	this.queue_complete = function (ret)
    {
        this.event.queue_complete();
	};
	this.plugin_loaded = function (arg)
	{
	    this.nat_loaded = true;
	    this.toolBar.empty();
	    this.toolBar.replaceWith(this.uiToolBarBk);
	    //this.toolBar.show();
	};
	this.load_complete = function (json) {
        if (this.websocketInited) return;
        this.websocketInited = true;

        this.btnSetup.hide();
	    var needUpdate = true;
	    if (typeof (json.version) != "undefined") {
	        if (json.version == this.Config.Version) {
	            needUpdate = false;
	        }
	    }
	    if (needUpdate) this.update_notice();
	    //else { this.btnSetup.hide(); }
	};
	this.load_complete_edge = function (json) {
	    this.edge_load = true;
	    //this.btnSetup.hide();
	    _this.app.init();
    };
    this.socket_close = function () {
        while (_this.QueuePost.length > 0) {
            _this.filesMap[_this.QueuePost[0]].postError(null);
        }
        _this.QueuePost.length = 0;
    };
	this.recvMessage = function (str)
	{
	    var ret = JSON.parse(str);
        if      (ret.name == "part_files") _this.part_files(ret);
        else if (ret.name == "drag_enter") _this.drag_enter(ret);
        else if (ret.name == "drag_leave") _this.drag_leave(ret);
        else if (ret.name == "drop_files") _this.drop_files(ret);
        else if (ret.name == "post_complete") _this.post_complete(ret);
        else if (ret.name == "post_process") _this.post_process(ret);
        else if (ret.name == "post_error") _this.post_error(ret);
        else if (ret.name == "queue_complete") _this.queue_complete(ret);
        else if (ret.name == "plugin_loaded") _this.plugin_loaded(ret);
        else if (ret.name == "load_complete") { _this.load_complete(ret); }
        else if (ret.name == "load_complete_edge") { _this.load_complete_edge(ret); }
	};
    
	var browserName = navigator.userAgent.toLowerCase();
	this.ie = browserName.indexOf("msie") > 0;
    //IE11
	this.ie = this.ie ? this.ie : browserName.search(/(msie\s|trident.*rv:)([\w.]+)/) != -1;
	this.firefox = browserName.indexOf("firefox") > 0;
	this.chrome = browserName.indexOf("chrome") > 0;
	this.chrome45 = false;
	this.edge_load = false;
	this.chrVer = navigator.appVersion.match(/Chrome\/(\d+)/);
	this.ffVer = navigator.userAgent.match(/Firefox\/(\d+)/);
	this.edge = navigator.userAgent.indexOf("Edge") > 0;
    this.edgeApp = new WebServer(this);
    this.edgeApp.ent.on_close = function () { _this.socket_close(); };
	this.app = up2_app;
	this.app.edgeApp = this.edgeApp;
	this.app.Config = this.Config;
	this.app.ins = this;
	if (this.edge) { this.ie = this.firefox = this.chrome = this.chrome45 = false; }

    //浏览器环境检查
	if (_this.ie)
	{
	    //Win64
	    if (window.navigator.platform == "Win64")
	    {
	        jQuery.extend(this.Config.ie, this.Config.ie64);
	    }
	}
	else if (_this.firefox)
	{
	    if (!this.app.checkFF() || parseInt(this.ffVer[1]) >= 50)//仍然支持npapi
	    {
	        this.edge = true;
	        this.app.postMessage = this.app.postMessageEdge;
	        this.edgeApp.run = this.edgeApp.runChr;
	    }
	} //Chrome
	else if (_this.chrome)
	{
	    this.app.check = this.app.checkFF;
	    jQuery.extend(this.Config.firefox, this.Config.chrome);
	    //44+版本使用Native Message
	    if (parseInt(this.chrVer[1]) >= 44) {
	        _this.firefox = true;
	        if (!this.app.checkFF())//仍然支持npapi
	        {
	            this.edge = true;
	            this.app.postMessage = this.app.postMessageEdge;
	            this.edgeApp.run = this.edgeApp.runChr;
	        }
	    }
	}
	else if (this.edge)
	{
	    this.app.postMessage = this.app.postMessageEdge;
	}

    //升级通知
	this.update_notice = function () {
	    //this.btnSetup.text("升级控件");
	    //this.btnSetup.css("color", "red");
	    //this.btnSetup.show();
    };

    //安全检查，在用户关闭网页时自动停止所有上传任务。
    this.SafeCheck = function (event) {
        $(window).bind("beforeunload", function (event) {
            if (_this.QueuePost.length > 0) {
                event.returnValue = "您还有程序正在运行，确定关闭？";
            }
        });

        $(window).bind("unload", function () {
            if (this.edge) _this.edgeApp.close();
            if (_this.QueuePost.length > 0) {
                _this.StopAll();
            }
        });
    };

	this.GetHtml = function ()
	{
	    //npapi
	    var acx = '<embed name="ffParter" type="' + this.Config.firefox.type + '" pluginspage="' + this.Config.firefox.path + '" width="1" height="1"/>';
	    if (this.chrome45) acx = "";
	    if (this.ie)
	    {
            //加载拖拽控件
            if (this.Config.Droper) {
                acx = '<object name="ieDroper" classid="clsid:' + this.Config.ie.drop.clsid + '"';
                acx += ' codebase="' + this.Config.ie.path + '#version=' + this.Config["Version"] + '" width="192" height="192" >';
                acx += '</object>';
            }
	        //文件夹选择控件
	        acx += '<object name="ieParter" classid="clsid:' + this.Config.ie.part.clsid + '"';
	        acx += ' codebase="' + this.Config.ie.path + '#version=' + this.Config["Version"] + '" width="1" height="1" ></object>';
	    }
	    if (this.edge) acx = "";

        //文件模板
        acx += '<div class="file-item" id="tmpFile" name="fileItem">\
                    <div class="img-box"><img src="js/file.png"/></div>\
					<div class="area-l">\
						<div class="file-head">\
						    <div name="fileName" class="name">HttpUploader程序开发.pdf</div>\
						    <div name="percent" class="percent">(35%)</div>\
						    <div name="fileSize" class="size" child="1">1000.23MB</div>\
                        </div>\
						<div class="process-border"><div name="process" class="process"></div></div>\
						<div name="msg" class="msg top-space">15.3MB 20KB/S 10:02:00</div>\
					</div>\
					<div class="area-r">\
                        <span class="btn-box" name="cancel" title="取消"><img src="js/stop.png"/><div>取消</div></span>\
                        <span class="btn-box hide" name="post" title="继续"><img src="js/post.png"/><div>继续</div></span>\
						<span class="btn-box hide" name="stop" title="停止"><img src="js/stop.png"/><div>停止</div></span>\
						<span class="btn-box hide" name="del" title="删除"><img src="js/del.png"/><div>删除</div></span>\
					</div>';
        acx += '</div>';
	    //分隔线
		acx += '<div class="file-line" name="lineSplite"></div>';
        //上传列表
        acx += '<div class="files-panel" name="post_panel">\
					<div name="post_head" class="toolbar">\
						<span class="btn" name="btnAddFiles">选择多个文件</span>\
						<span class="btn" name="btnAddFolder">选择文件夹</span>\
						<span class="btn" name="btnPasteFile">粘贴文件</span>\
						<span class="btn" name="btnSetup">安装控件</span>\
					</div>\
					<div class="content" name="post_content">\
						<div name="post_body" class="file-post-view"></div>\
					</div>\
					<div class="footer" name="post_footer">\
						<span class="btn-footer" name="btnClear">清除已完成文件</a>\
					</div>\
				</div>';
	    return acx;
	};

	this.setupTip = function ()
	{
	    this.toolBar.html('<a href="'+this.Config["ExePath"]+'">请安装控件</a>').css("cursor", "pointer")
	};

    //在外部调用。
	this.loadAuto = function ()
	{
	    var html = this.GetHtml();
	    var ui = $(document.body).append(html);
	    this.InitUI(ui);
	};

	this.loadTo = function (oid)
	{
	    var html = this.GetHtml();
	    var ui = $("#" + oid).append(html);	    
	    this.InitUI(ui);
	};

	this.InitUI = function (ui/*jquery object*/)
    {
        var filesLoc  = ui.find('li[name="filesLoc"]');
	    var droper    = ui.find('object[name="objDroper"]').get(0);
	    this.ieParter = ui.find('object[name="ieParter"]').get(0);
	    this.parter   = ui.find('embed[name="ffParter"]').get(0);
	    this.Droper   = droper;

        var post_panel = ui.find("div[name='post_panel']");
        var post_body  = ui.find("div[name='post_body']");
        var post_head  = ui.find('div[name="post_head"]');
        var post_foot  = ui.find('div[name="post_footer"]');
        post_body.height(post_panel.height() - post_head.height() - post_foot.outerHeight());

	    this.filesUI    = post_body;
	    this.tmpFile    = ui.find('div[name="fileItem"]');
        this.tmpFolder  = ui.find('div[name="folderItem"]');
        this.tmpSpliter = ui.find('div[name="lineSplite"]');
	    this.pnlHeader  = ui.find('div[name="pnlHeader"]');
        this.btnSetup   = ui.find('span[name="btnSetup"]').click(function () {
            window.open(_this.Config.exe.path);
        });//("href",this.Config.exe.path);
	    //drag files

        ui.find('span[class="btn"]').each(function ()
        {
            $(this).hover(function () {
                $(this).addClass("btn-hover");
            }, function () {
                $(this).removeClass("btn-hover");
            });
        });

        //添加多个文件
        ui.find('span[name="btnAddFiles"]').click(function () { _this.app.openFile(); });
        //添加文件夹
        ui.find('span[name="btnAddFolder"]').click(function () { _this.app.openFolder(); });
        //粘贴文件
        ui.find('span[name="btnPasteFile"]').click(function () { _this.app.pasteFile(); });
        //清空已完成文件
        ui.find('span[name="btnClear"]').click(function () { _this.ClearComplete(); })
            .hover(function () {
                $(this).addClass("btn-footer-hover");
            }, function () {
                $(this).removeClass("btn-footer-hover");
            });

	    $(function () {
	        if (!_this.edge) {
	            if (_this.ie) {
	                _this.parter = _this.ieParter;
	                if (null != _this.Droper) _this.Droper.StateChanged = _this.recvMessage;
	            }
	            _this.parter.StateChanged = _this.recvMessage;
	        }

	        if (_this.edge) {
                _this.edgeApp.connect();
	        }
	        else {
	            _this.app.init();
	        }
	    });
	};

	this.addFileLoc = function (f)
	{
	    //本地文件名称存在
	    //if (this.Exist(filePath)) return;
	    //此类型为过滤类型
	    //if (this.NeedFilter(filePath)) return;

	    var uper = new HttpUploader(f,this);
	    this.filesMap[f.id] = uper;
	    var ui = this.tmpFile.clone(true);
	    ui.css("display", "block");
	    this.filesUI.append(ui);//添加到文件列表

	    var line = this.tmpSpliter.clone();
	    line.css("display", "block");
	    this.filesUI.append(line);

	    var uiName      = ui.find("div[name='fileName']");
	    var uiSize      = ui.find("div[name='fileSize']")
	    var divProcess  = ui.find("div[name='process']");
	    var divMsg      = ui.find("div[name='msg']");
	    var btnCancel   = ui.find("span[name='cancel']");
	    var btnDel      = ui.find("span[name='del']");
		var btnPost 	= ui.find("span[name='post']");
		var btnStop 	= ui.find("span[name='stop']");
	    var divPercent  = ui.find("div[name='percent']");
	    var ui_eles = { msg: divMsg, percent: divPercent, process: divProcess, btn: {cancel:btnCancel,del:btnDel},panel:ui,spliter:line};

	    uper.ui = ui_eles;

	    uiName.text(f.name).attr("title", f.name);
	    uiSize.text(f.size);
	    divMsg.text("");
	    divPercent.text("(0%)");
	    btnCancel.click(function ()
	    {
	        var obj = $(this);
	        switch (obj.text())
	        {
	            case "暂停":
	            case "停止":
	                uper.stop();
	                break;
	            case "取消":
	                {
	                    uper.stop();
	                    uper.remove();
	                }
	                break;
	            case "续传":
	            case "重试":
	                //uper.post();
	                break;
	        }
	    });
	    btnDel.click(function () { uper.Delete(); });

        uper.ready(); //准备
        this.event.add_file(uper);
	};
}
