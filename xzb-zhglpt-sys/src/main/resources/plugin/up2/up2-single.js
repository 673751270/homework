/*
	版权所有 2009-2018 荆门泽优软件有限公司
	保留所有权利
	官方网站：http://www.ncmem.com/
	产品首页：http://www.ncmem.com/webplug/http-uploader2/index.asp
	产品介绍：http://www.cnblogs.com/xproer/archive/2012/05/29/2523757.html
	开发文档-ASP：http://www.cnblogs.com/xproer/archive/2012/02/17/2355458.html
	开发文档-PHP：http://www.cnblogs.com/xproer/archive/2012/02/17/2355467.html
	开发文档-JSP：http://www.cnblogs.com/xproer/archive/2012/02/17/2355462.html
	开发文档-ASP.NET：http://www.cnblogs.com/xproer/archive/2012/02/17/2355469.html
	升级日志：http://www.cnblogs.com/xproer/archive/2012/02/17/2355449.html
	示例下载：http://www.ncmem.com/download/up2/asp.net/up2.rar
	文档下载：http://www.ncmem.com/download/up2/up2-doc.rar
	问题反馈：http://www.ncmem.com/bbs/showforum-19.aspx
	VC运行库：http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=29
	联系信箱：1085617561@qq.com
	联系QQ：1085617561
    版本：1.1
    更新记录：
	    2009-11-05 创建
        2015-08-01 优化
        2016-03-07 优化业务逻辑
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
    this.Config = {
          "EncodeType"      : "GB2312"
		, "Company"         : "荆门泽优软件有限公司"
		, "Version"         : "2,5,54,51373"
		, "License"         : ""
		, "Debug"           : false//调试开关
		, "LogFile"         : "C:\\log.txt"//日志文件路径
		, "FileFilter"      : "*"//文件类型。所有类型：*。自定义类型：jpg,bmp,png,gif,rar,zip,7z,doc
	    //字节计算器：http://www.beesky.com/newsite/bit_byte.htm
	    //超过10MB建议选择HttpUploader6：http://www.ncmem.com/webplug/http-uploader6/index.asp
		, "FileSizeLimit"   : "10485760"//自定义允许上传的文件大小，以字节为单位。0表示不限制。字节计算工具：http://www.beesky.com/newsite/bit_byte.htm
		, "AllowMultiSelect": false//多选开关。true:开启多选。false:关闭多选
		, "CryptoType"      : "md5"//文件校验方式：md5,crc,sha1
        , "InitDir"         : ""//初始化路径。示例：D:\\Soft
		, "Compress"		: ""//是否开启压缩。值：zip
		, "FileFieldName"	: "file"//文件字段名称
		, "Cookie"	        : ""//cookie
		, "PostUrl"         : "http://localhost:8080/up2/upload.jsp"
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
		, "upass": "test"
		, "uid": "0"
		, "fid": "0"
    };

    this.event = {
          postProcess: function (obj, speed, postedLength, percent, times) { }
	    , postComplete: function (obj) { }
        , postError: function (obj) { }
    };

    //http://www.ncmem.com/
    this.Domain = "http://" + document.location.host;
    this.ieParter = null;
    this.parter = null;//
    this.fileItem = null;//jquery object
    this.fileCur = null;//当前文件上传项
    this.uiPanel = null;//显示UI界面的DIV，jquery object
    this.nat_loaded = false;

    this.part_files = function (ret)
    {
        if (ret.files == null) return;
        var f = ret.files[0];
        this.addFileLoc(f);
        var fn = function () { _this.app.queuePost(); };
        setTimeout(fn, 500);
    };
    this.post_complete = function (ret)
    {
        this.fileCur.postComplete();
        this.event.postComplete(this.fileCur);
        this.fileCur = null;
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
            alert(HttpUploaderErrorCode[ret.code]);
            return;
        }
        var f = this.fileCur;
        f.postError(ret);
        this.event.postError(this.fileCur);
    };
    this.post_process = function (ret)
    {
        var f = this.fileCur;
        f.postProcess(ret);
    };
    this.queue_complete = function (ret)
    {
    };
    this.plugin_loaded = function (arg) { this.nat_loaded = true; };
    this.load_complete = function (json) {
        //this.btnSetup.hide();
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
    this.recvMessage = function (str)
    {
        var ret = JSON.parse(str);
        if (ret.name == "part_files") _this.part_files(ret);
        else if (ret.name == "post_complete") _this.post_complete(ret);
        else if (ret.name == "post_process") _this.post_process(ret);
        else if (ret.name == "post_error") _this.post_error(ret);
        else if (ret.name == "queue_complete") _this.queue_complete(ret);
        else if (ret.name == "plugin_loaded") _this.plugin_loaded(ret);
        else if (ret.name == "load_complete") { _this.load_complete(ret); }
        else if (ret.name == "load_complete_edge") { _this.load_complete_edge(ret); }
    };

    //检查版本 Win32/Win64/Firefox/Chrome
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
    else if (this.edge) {
        this.app.postMessage = this.app.postMessageEdge;
    }

    //文件上传面板。
    this.GetHtml = function ()
    {
        //加载拖拽控件
	    var acx = '<embed name="ffParter" type="' + this.Config.firefox.type + '" pluginspage="' + this.Config.firefox.path + '" width="1" height="1"/>';
        if (this.chrome45) acx = "";
        if (this.ie) {
            //文件上传控件
            acx = '<object name="ieParter" classid="clsid:' + this.Config.ie.part.clsid + '"';
            acx += ' codebase="' + this.Config.ie.path + '#version=' + this.Config["Version"] + '" width="1" height="1" ></object>';
        }

        //上传列表项ui
        acx += '<div class="UploaderItem" name="fileItem" id="UploaderTemplate">\
		            <div class="UploaderItemLeft">\
		                <div class="FileInfo">\
		                    <div name="fileName" class="FileName top-space">HttpUploader程序开发.pdf</div>\
		                    <div name="fileSize" class="FileSize" child="1">100.23MB</div>\
		                </div>\
		                <div class="ProcessBorder top-space"><div name="process" class="Process"></div></div>\
		                <div name="msg" class="PostInf top-space">已上传:15.3MB 速度:20KB/S 剩余时间:10:02:00</div>\
		            </div>\
		            <div class="UploaderItemRight">\
		                <div class="BtnInfo"><span name="btnCancel" class="Btn">取消</span>&nbsp;<span name="btnDel" class="Btn">删除</span></div>\
		                <div name="percent" class="ProcessNum">35%</div>\
		            </div>\
		        </div>';
        return acx;
    };

    this.setupTip = function ()
    {
        var dom = $(document.body).append('<a href="' + this.Config["ExePath"] + '">请安装控件</a>');
        dom.css("cursor", "pointer");
    };

    this.loadAuto = function ()
    {
        var html = this.GetHtml();
        var dom = $(document.body).append(html);
        this.initUI(dom);
    };

    //加载容器，上传面板，文件列表面板
    this.loadTo = function (oid)
    {
        var html = this.GetHtml();
        var dom = $("#" + oid).html(html);
        this.initUI(dom);
    };

    this.initUI = function (ui)
    {
        this.fileItem = ui.find('div[name="fileItem"]');
        this.ieParter = ui.find('object[name="ieParter"]').get(0);
        this.parter = ui.find('embed[name="ffParter"]').get(0);

        $(function () {
            if (!_this.edge) {
                if (_this.ie) {
                    _this.parter = _this.ieParter;
                }
                _this.parter.StateChanged = _this.recvMessage;
            }

            if (_this.edge) {
                _this.edgeApp.run();
            }
            else {
                _this.app.init();
            }
        });
    };

    //打开文件选择对话框
    this.OpenFile = function ()
    {
        _this.app.openFile();
    };

    //粘贴文件
    this.PateFile = function ()
    {
        _this.app.pasteFiles();
    };

    //oid,显示上传项的层ID
    this.postAuto = function (oid)
    {
        if (this.fileCur != null) return;
        this.uiPanel = $("#" + oid);
        this.OpenFile();
    };

    //oid,显示上传项的层ID
    this.openFolder = function (oid) {
        if (this.fileCur != null) return;
        this.uiPanel = $("#" + oid);
        _this.app.openFolder();
    };

    //上传文件
    this.postLoc = function (filePath, oid)
    {
        if (this.fileCur != null) return;
        this.uiPanel = $("#" + oid);
        this.app.addFile({ path: filePath });
    };
    this.addFileLoc = function (f)
    {
        var uper = new FileUploader(f, this);
        this.fileCur = uper;
        var ui = this.fileItem.clone(true);
        ui.css("display", "block");
        this.uiPanel.append(ui);

        var uiName      = ui.find("div[name='fileName']");
        var uiSize      = ui.find("div[name='fileSize']")
        var divProcess  = ui.find("div[name='process']");
        var divMsg      = ui.find("div[name='msg']");
        var btnCancel   = ui.find("span[name='btnCancel']");
        var btnDel      = ui.find("span[name='btnDel']");
        var divPercent  = ui.find("div[name='percent']");
        var ui_eles     = { msg: divMsg, percent: divPercent, process: divProcess, btn: { cancel: btnCancel, del: btnDel }, panel: ui};

        uper.ui = ui_eles;

        uiName.text(f.name).attr("title", f.name);
        uiSize.text(f.size);
        divMsg.text("");
        divPercent.text("0%");
        btnCancel.click(function ()
        {
            var obj = $(this);
            switch (obj.text())
            {
                case "暂停":
                case "停止":
                    uper.stop();
                    uper.remove();
                    break;
                case "取消":
                    {
                        uper.stop();
                        uper.remove();
                    }
                    break;
                case "续传":
                case "重试":
                    uper.Post();
                    break;
            }
        });
        btnCancel.hide();
        btnDel.click(function () { uper.remove(); _this.fileCur = null;});

        uper.ready(); //准备
    };
}

var HttpUploaderState = {
    Ready: 0,
    Posting: 1,
    Stop: 2,
    Error: 3,
    GetNewID: 4,
    Complete: 5,
    WaitContinueUpload: 6,
    None: 7,
    Waiting: 8
	, MD5Working: 9
};

//文件上传对象
function FileUploader(f, mgr)
{
    var _this = this;
    //this.pMsg;
    //this.pProcess;
    //this.pPercent;
    //this.pButton
    //this.div
    //this.split
    this.Manager = mgr; //上传管理器指针
    this.Config = mgr.Config;
    this.Fields = mgr.Fields;
    this.ActiveX = mgr.ActiveX;
    this.browser = mgr.browser;
    this.firefox = mgr.firefox;
    this.chrome = mgr.chrome;
    this.State = HttpUploaderState.None;
    this.fileLoc = f;
    this.ui = { msg: null, percent: null, process: null, btn: { cancel: null, del: null }, spliter: null, panel: null };

    //准备
    this.ready = function ()
    {
        this.ui.msg.text("正在上传队列中等待");
        this.State = HttpUploaderState.Ready;
    };

    this.stop = function ()
    {
        var inf = { name: "file_cancel", id: this.fileLoc.id };
        this.app.stop(inf);
    };

    //从上传列表中删除
    this.remove = function ()
    {
        //删除信息层
        this.ui.panel.remove();
    };

    this.postError = function (json)
    {
        this.ui.msg.text(HttpUploaderErrorCode[json.code]);
        this.ui.btn.cancel.text("重试");
        this.ui.percent.text("0%");
        this.ui.process.css("width", "0");
    };

    this.postComplete = function ()
    {
        this.ui.btn.cancel.text("").hide();
        this.ui.btn.del.hide();
        this.ui.process.css("width", "100%");
        this.ui.percent.text("100%");
        this.ui.msg.text("上传完成");
        this.State = HttpUploaderState.Complete;
    };

    this.postProcess = function (json)
    {
        var msg = "已上传:" + json.len + " 速度:" + json.speed + " 剩余时间:" + json.time;
        this.ui.msg.text(msg);
        this.ui.percent.text(json.percent);
        this.ui.process.css("width", json.percent);
    };
}