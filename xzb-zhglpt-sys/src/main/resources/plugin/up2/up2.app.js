var up2_app = {
    ins: null
    ,edgeApp: null
    ,Config:null
    , checkFF: function ()
    {
        var mimetype = navigator.mimeTypes;
        if (typeof mimetype == "object" && mimetype.length)
        {
            for (var i = 0; i < mimetype.length; i++)
            {
                var enabled = mimetype[i].type == this.Config.firefox.type;
                if (!enabled) enabled = mimetype[i].type == this.Config.firefox.type.toLowerCase();
                if (enabled) return mimetype[i].enabledPlugin;
            }
        }
        else
        {
            mimetype = [this.Config.firefox.type];
        }
        if (mimetype)
        {
            return mimetype.enabledPlugin;
        }
        return false;
    }
	, Setup: function ()
	{
		//文件夹选择控件
		acx += '<object id="objHttpPartition" classid="clsid:' + this.Config.ie.part.clsid + '"';
        acx += ' codebase="' + this.Config.ie.path + '" width="1" height="1" ></object>';

		$("body").append(acx);
	}
    , init: function ()
    {
        var param = { name: "init", config: this.Config };
        this.postMessage(param);
    }
    , initNat: function ()
    {
        if (!this.chrome45) return;
        this.exitEvent();
        document.addEventListener('Uploader6EventCallBack', function (evt)
        {
            this.recvMessage(JSON.stringify(evt.detail));
        });
    }
    , initEdge: function ()
    {
        this.edgeApp.run();
    }
    , exit: function ()
    {
        var par = { name: 'exit' };
        var evt = document.createEvent("CustomEvent");
        evt.initCustomEvent(this.entID, true, false, par);
        document.dispatchEvent(evt);
    }
    , exitEvent: function ()
    {
        var obj = this;
        $(window).bind("beforeunload", function () { obj.exit(); });
    }
    , addFile: function (json)
    {
        var param = { name: "add_file", config: this.Config };
        jQuery.extend(param, json);
        this.postMessage(param);
    }
    , openFile: function ()
    {
        var param = { name: "open_file" };
        this.postMessage(param);
    }
    , openFolder: function ()
    {
        var param = { name: "open_folder" };
        this.postMessage(param);
    }
    , pasteFile: function ()
    {
        var param = { name: "paste_file"};
        this.postMessage(param);
    }
    , stopFile: function (f)
    {
        var param = jQuery.extend({},f,{ name: "stop_file"});
        this.postMessage(param);
    }
    , delFile: function (f) {
        var param = { name: "del_file", id: f.id};
        this.postMessage(param);
    }
    , queuePost: function () {
        var param = { name: "queue_post"};
        this.postMessage(param);}
    , stopQueue: function () {
        var param = { name: "stop_queue"};
        this.postMessage(param);
    }
    , postMessage:function(json)
    {
        try {
            this.ins.parter.postMessage(JSON.stringify(json));
        } catch (e) { }
    }
    , postMessageNat: function (par)
    {
        var evt = document.createEvent("CustomEvent");
        evt.initCustomEvent(this.entID, true, false, par);
        document.dispatchEvent(evt);
    }
    , postMessageEdge: function (par)
    {
        this.edgeApp.send(par);
    }
};
