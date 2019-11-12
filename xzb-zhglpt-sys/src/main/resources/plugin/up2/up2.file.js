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
};

//文件上传对象
function HttpUploader(f, mgr) {
    var _this = this;
    this.Manager = mgr; //上传管理器指针
    this.app = mgr.app;
    this.State = HttpUploaderState.None;
    this.fileLoc = f;
    this.ui = { msg: null, percent: null, process: null, btn: { cancel: null, del: null }, spliter: null, panel: null };

    this.ready = function () {
        this.ui.msg.text("正在上传队列中等待");
    };

    this.stop = function () {
        var inf = { name: "file_cancel", id: this.fileLoc.id };
        this.app.postMessage(inf);
    };

    //从上传列表中删除
    this.remove = function () {
        //删除信息层
        this.ui.panel.remove();
        //删除分隔线
        this.ui.spliter.remove();
    };

    this.postError = function (json) {
        this.ui.msg.text(HttpUploaderErrorCode[json.code]);
        this.ui.btn.cancel.text("重试");
        this.ui.percent.text("(0%)");
        this.ui.process.css("width", "0");
    };

    this.postComplete = function (json) {
        this.ui.btn.cancel.text("").hide();
        this.ui.btn.del.hide();
        this.ui.process.css("width", "100%");
        this.ui.percent.text("(100%)");
        this.ui.msg.text("上传完成");
        this.State = HttpUploaderState.Complete;
        this.Manager.event.post_complete(json.res);
    };

    this.postProcess = function (json) {
        var msg = "已上传:" + json.len + " 速度:" + json.speed + " 剩余时间:" + json.time;
        this.ui.msg.text(msg);
        this.ui.percent.text("(" + json.percent + ")");
        this.ui.process.css("width", json.percent);
    };
}