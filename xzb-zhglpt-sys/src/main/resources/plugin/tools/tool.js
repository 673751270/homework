//通用
function popup(title, url, w, h, id) {
    if (title == null || title == '') {
        title = false;
    }
    if (url == null || url == '') {
        url = "error/404";
    }
    if (w == null || w == '') {
        w = ($(window).width() * 0.9);
    }
    if (h == null || h == '') {
        h = ($(window).height() - 50);
    }
    layer.open({
        id: id,
        type: 2,
        area: [w + 'px', h + 'px'],
        fix: false,
        maxmin: true,
        shadeClose: true,
        shade: 0.4,
        title: title,
        content: url
    });
}

function mapToArray(map) {
    var list = new Array();
    for (var key in map) {
        list.push(map[key]);
    }
    return list;
};


function viewProcess(url, processInstanceId) {
    layer.open({
        id: 'leave-image',
        type: 2,
        area: [(window.innerWidth - 200) + 'px', '200px'],
        fix: false,
        maxmin: true,
        shadeClose: false,
        shade: 0.4,
        title: '流程图',
        content: url + processInstanceId
    });
}

function delUpFile(list) {
    $.ajax({
        url: 'delUpFile',
        data: {list: JSON.stringify(list)},
        type: "post",
        traditional: true,
        success: function (data) {
            if (data.flag) {
                window.top.layer.msg(data.msg, {icon: 6, offset: 'rb', area: ['200px', '80px'], anim: 2});
            }
        }, error: function (e) {
            layer.alert("发生错误", {icon: 6}, function () {
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            });
        }
    });
}

function delLogical(list, fileId, b) {
    delete list[fileId];
    $(b).parent().parent().remove();
}

function delFile(filePath, fileId, id, b) {
    $.ajax({
        url: 'delFile',
        data: {filePath: filePath, fileId: fileId, id: id},
        type: "post",
        traditional: true,
        success: function (data) {
            if (data.flag) {
                window.top.layer.msg(data.msg, {icon: 6, offset: 'rb', area: ['200px', '80px'], anim: 2});
                $(b).parent().parent().remove();
            }
        }, error: function (e) {
            layer.alert("发生错误", {icon: 6}, function () {
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            });
        }
    });
}

/**
 * 父窗口弹出
 * @param url
 * @param data
 * @param tableId
 */
function postAjaxre(url, data, tableId) {
    $.ajax({
        url: url,
        type: "post",
        data: data,
        dataType: "json", traditional: true,
        success: function (data) {
            if (data.flag) {
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
                window.parent.layui.table.reload(tableId);
                window.top.layer.msg(data.msg, {icon: 6, offset: 'rb', area: ['120px', '80px'], anim: 2});
            } else {
                layer.msg(data.msg, {icon: 5, offset: 'rb', area: ['120px', '80px'], anim: 2});
            }
        }
    });
}

function layerAjax(url, data, tableId) {
    $.ajax({
        url: url,
        type: 'post',
        data: data,
        traditional: true,
        success: function (d) {
            if (d.flag) {
                if (tableId !== undefined && tableId !== '') {
                    var index = parent.layer.getFrameIndex(window.name);
                    //top.layui.index.close(index);
                    parent.layer.close(index);
                    window.parent.layui.table.reload(tableId);
                }
                window.top.layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['200px', '80px'], anim: 2});
            } else {
                layer.msg(d.msg, {icon: 5});
            }
        }, error: function (e) {
            layer.alert("发生错误", {icon: 6}, function () {
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            });
        }
    });
}

function saveText(url, data, text) {
    $.ajax({
        url: url,
        type: "post",
        data: data,
        success: function (d) {
            if (d.flag) {
                text.val(d.data);
                layer.closeAll();
            }
        }, error: function () {
            alert('error');
        }
    });
}

function post(url, data, tableId) {
    $.ajax({
        url: url,
        type: 'post',
        data: data,
        traditional: true,
        success: function (d) {
            if (d.flag) {
                if (tableId !== undefined && tableId !== '') {
                    layui.table.reload(tableId);
                }
                window.top.layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['200px', '80px'], anim: 2});
            } else {
                layer.msg(d.msg, {icon: 5});
            }
        }, error: function (e) {
            layer.alert("发生错误", {icon: 6}, function () {
                var index = layer.getFrameIndex(window.name);
                layer.close(index);
            });
        }
    });
}

function tabAjax(url, data, obj, tab) {
    var i = layer.load(1, {
        shade: [0.5, '#000'] //0.1透明度的背景
    });
    $.ajax({
        url: url,
        type: 'post',
        data: data,
        traditional: true,
        success: function (d) {
            if (d.flag) {
                if (tab === undefined) {
                    tab = parent.layui.tab;
                }
                if (obj !== undefined) {
                    tab.close(tab.getId());
                    tab.close(obj.id);
                    tab.tabAdd(obj);
                }
                window.top.layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['200px', '80px'], anim: 2});
            } else {
                layer.msg(d.msg, {icon: 5});
            }
            layer.closeAll();
        }, error: function (e) {
            layer.alert("发生错误", {icon: 6}, function () {
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
                layer.closeAll();
            });
        }
    });
}


function eleClick(active, ele) {
    $(ele).on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });
}

function toolDelByFlag(id, flag, tableId) {
    var data = {id: id};
    if (flag != null) {
        data.flag = flag;
    }
    $.ajax({
        url: "del",
        type: "post",
        data: data,
        success: function (d) {
            if (d.flag) {
                window.layui.table.reload(tableId);
                window.top.layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['120px', '80px'], anim: 2});
            } else {
                window.top.layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['120px', '80px'], anim: 2});
            }
        }, error: function () {
            alert('error');
        }
    });
}

function del(id, tableId) {
    var data = {id: id};
    $.ajax({
        url: "del",
        type: "post",
        data: data,
        success: function (d) {
            if (d.flag) {
                window.layui.table.reload(tableId);
                window.top.layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['120px', '80px'], anim: 2});
            }
        }, error: function () {
            alert('error');
        }
    });
}

function toolChangeByFlag(id, list, flag, tableId) {
    var data = {id: id};
    if (flag != null) {
        data.flag = flag;
    }
    $.ajax({
        url: "change",
        type: "post",
        data: data,
        success: function (d) {
            if (d.flag) {
                window.layui.table.reload(tableId);
                window.top.layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['120px', '80px'], anim: 2});
            }
        }, error: function () {
            alert('error');
        }
    });
}

function getActiviti(type, id, t) {
    var GWCP = {'id': "1", 'name': "公务呈批流程", 'obj': parent.getOfficial},
        HYHDFK = {'id': "20", 'name': "会议活动反馈流程", 'obj': parent.getFeedback},
        HYHDJH = {'id': "3", 'name': "会议活动计划流程", 'obj': parent.getMeetPlan},
        YCSQ = {'id': "4", 'name': "用车申请流程", 'obj': parent.getUseCar},
        YGCC = {'id': "5", 'name': "因公出差流程", 'obj': parent.getTravel},
        FWCP = {'id': "6", 'name': "发文呈批流程", 'obj': parent.getOffcalPost},
        LHHWCP = {'id': "7", 'name': "联合行文呈批", 'obj': parent.getJoint},
        JDFACP = {'id': "2", 'name': "接待方案呈批流程", 'obj': parent.getReception}
        , BLDQJ = {'id': "8", 'name': "办领导请假流程", 'obj': parent.getBLD}
        , CZQJ = {'id': "9", 'name': "处长请假流程", 'obj': parent.getCZ}
        , JGGZRY = {'id': "10", 'name': "机关工作人员请假流程", 'obj': parent.getJGGZRY}
        , GNHZFWZXZRQJ = {'id': "11", 'name': "国内合作服务中心主任请假流程", 'obj': parent.getGNFWZXZR}
        , GNHZFWZXGZRYQJ = {'id': "12", 'name': "国内合作服务中心工作人员请假流程", 'obj': parent.getGNFWZXGZRY}
        , BLDCGZZJY = {'id': "13", 'name': "办领导出国（境）证照借用流程", 'obj': parent.getBLDZZ}
        , CZCGZZJY = {'id': "14", 'name': "处长出国（境）证照借用流程", 'obj': parent.getCZZZ}
        , JGGZRYCGZZJY = {'id': "15", 'name': "机关工作人员出国（境）证照借用流程", 'obj': parent.getGZRYZZ}
        , GNHZFWZXZRCGZZJY = {'id': "16", 'name': "国内合作服务中心主任出国（境）证照借用流程", 'obj': parent.getZXZRZZ}
        , GNHZFWZXGZRYCGZZJY = {'id': "17", 'name': "国内合作服务中心工作人员出国（境）证照借用流程", 'obj': parent.getZXGZRYZZ}
        , ZXGWCP = {'id': "24", 'name': "中心公务呈批流程", 'obj': parent.getCenterOffcial},
        ZXFWCP = {'id': "21", 'name': "中心发文呈批流程", 'obj': parent.getCenterOffcialPost},
        ZXYGCCSP = {'id': "23", 'name': "中心因公出差审批流程", 'obj': parent.getCenterBusinessTrip},
        SWCY = {
            'id': "19", 'name': "收文呈阅流程", 'obj': {
                "id": "46a1acd756894225bd5c6dc136c75d07",
                "url": "launch/goReview",
                "icon": "",
                "title": "收文呈阅流程"
            }
        },
        SWCP = {
            'id': "18", 'name': "收文呈批流程", 'obj': {
                "id": "f1efc468776d4b438b0ce03533dd8f63",
                "url": "launch/goBatch",
                "icon": "",
                "title": "收文呈批流程"
            }
        };
    var obj;
    var tab = parent.layui.tab;
    switch (type) {
        case GWCP.id:
            obj = GWCP.obj;
            break;
        case HYHDFK.id:
            obj = HYHDFK.obj;
            break;
        case HYHDJH.id:
            obj = HYHDJH.obj;
            break;
        case YCSQ.id:
            obj = YCSQ.obj;
            break;
        case YGCC.id:
            obj = YGCC.obj;
            break;
        case FWCP.id:
            obj = FWCP.obj;
            break;
        case LHHWCP.id:
            obj = LHHWCP.obj;
            break;
        case JDFACP.id:
            obj = JDFACP.obj;
            break;
        case BLDQJ.id:
            obj = BLDQJ.obj;
            break;
        case CZQJ.id:
            obj = CZQJ.obj;
            break;
        case JGGZRY.id:
            obj = JGGZRY.obj;
            break;
        case GNHZFWZXZRQJ.id:
            obj = GNHZFWZXZRQJ.obj;
            break;
        case GNHZFWZXGZRYQJ.id:
            obj = GNHZFWZXGZRYQJ.obj;
            break;
        case BLDCGZZJY.id:
            obj = BLDCGZZJY.obj;
            break;
        case CZCGZZJY.id:
            obj = CZCGZZJY.obj;
            break;
        case JGGZRYCGZZJY.id:
            obj = JGGZRYCGZZJY.obj;
            break;
        case GNHZFWZXZRCGZZJY.id:
            obj = GNHZFWZXZRCGZZJY.obj;
            break;
        case GNHZFWZXGZRYCGZZJY.id:
            obj = GNHZFWZXGZRYCGZZJY.obj;
            break;
        case SWCY.id:
            obj = SWCY.obj;
            break;
        case SWCP.id:
            obj = SWCP.obj;
            break;
        case ZXGWCP.id:
            obj = ZXGWCP.obj;
            break;
        case ZXFWCP.id:
            obj = ZXFWCP.obj;
            break;
        case ZXYGCCSP.id:
            obj = ZXYGCCSP.obj;
            break;
        default:
            break;
    }
    if (obj !== undefined) {
        var tmp = {"id": obj.id, "url": obj.url, "icon": obj.icon, "title": obj.title};
        if (t !== 'undefined' && t !== '') {
            tmp.url = tmp.url + "?listId=" + id + "&type=" + t;
        } else {
            tmp.url = tmp.url + "?listId=" + id;
        }
        tab.close(tmp.id);
        tab.tabAdd(tmp);
    }
}

function addTab(obj) {
    var tab = parent.layui.tab;
    tab.close(obj.id);
    tab.tabAdd(obj);
}

function withdraw(url, id, tableId) {
    var data = {id: id};
    $.ajax({
        url: url,
        type: "post",
        data: data,
        success: function (d) {
            if (d.flag) {
                window.layui.table.reload(tableId);
                window.top.layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['120px', '80px'], anim: 2});
            }
        }, error: function () {
            alert('error');
        }
    });
}

function toolDel(id, list) {
    toolDelByFlag(id, list, null);
}

function addWindow(data) {
    if (data.title == null || data.title == '') {
        data.title = false;
    }
    ;
    if (data.url == null || data.url == '') {
        data.url = "error/404";
    }
    ;
    if (data.w == null || data.w == '') {
        data.w = ($(window).width() * 0.9);
    }
    ;
    if (data.h == null || data.h == '') {
        data.h = ($(window).height() - 50);
    }
    ;
    return layer.open(data);
}

function openDoc(id, number) {
    window.open('openDoc?id=' + id + '&number=' + number);
}

function checkSend() {
    if ($("#urgency").val() !== undefined && $("#urgency").val() !== "一般") {
        $(".isSend").each(function () {
            $(this).prop("checked", true);
        })
    } else {
        $(".isSend").each(function () {
            $(this).prop("checked", false);
        })
    }
}

function identify(filePath, bodyText) {
    $.ajax({
        url: "identify",
        type: "post",
        data: {filePath: filePath},
        traditional: true,
        success: function (d) {
            if (d.flag) {
                $(bodyText).val(d.data);
                window.top.layer.msg(d.msg, {icon: 6, offset: 'rb', area: ['200px', '80px'], anim: 2});
            } else {
                layer.msg(d.msg, {icon: 5});
            }
        }, error: function (e) {
            layer.alert("发生错误", {icon: 6}, function () {
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            });
        }
    });
}