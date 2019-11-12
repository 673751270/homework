layui.define(function (exports) {
        var obj = {
            into: function (id, title, w, h, _id, type, data, is, show) {
                var $this = $(_id);
                var _type = type;
                var $id = id;
                if (type !== 'click' && type !== 'upper' && type !== 'clickCheckbox' && type !== 'clickRadio' && type !== 'text' && type !== 'nextClick') {
                    $this.attr('readonly', 'readonly');
                    $this.after($("<label class='layui-input' for='" + $this.attr('id') + "'/>").hide().append($("<div/>")));
                }
                if (type === 'text') {
                    $this.attr('readonly', 'readonly');
                }
                check.into(id, _id, type, data, is, show === undefined ? true : false);
                $this.click(function () {
                    obj.show(id, title, w, h);
                });
            },
            show: function (id, title, w, h) {
                var number = 1;
                if (title == null || title === '') {
                    title = false;
                }
                if (w === null || w === '') {
                    w = ($(window).width() * 0.9);
                }
                if (h === null || h === '') {
                    h = ($(window).height() - 50);
                }
                layer.open({
                    id: id,
                    type: 1,
                    area: [w + 'px', h + 'px'],
                    fix: false,
                    maxmin: false,
                    shadeClose: true,
                    shade: 0.4,
                    title: title,
                    content: $("." + id),
                    cancel: function (index) {
                        layer.close(index);
                    },
                    end: function () {
                        $("." + id).hide();
                    }
                });
            }
        };
        var check = {
                into: function (id, _id, type, data, is, show) {
                    var $this = $(_id);
                    var _type = type;
                    var $id = id;
                    var show = show;
                    var $select = $this.next().children();
                    var container = $("<div class='" + $id + "' />");
                    var row = $("<div class='layui-row'/>");
                    var md12 = $("<div class='layui-col-md12' />");
                    var btns = $("<div style='width: 100%;height: 56px;background-color: white;border-top:1px solid #e6e6e6;\n" +
                        "  position: sticky;bottom: 1px;'/>");
                    var add = $("<button class='layui-btn layui-btn-normal'/>").html("保存");
                    var close = $("<button class='layui-btn layui-btn-primary'/>").html("取消");

                    var all = $("<div class='layui-col-md2 layui-btn layui-btn-xs layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;font-size: 20px'/>").append($("<span style='padding: 5px;' />").html("全选")).click(function () {
                        $("." + $id + " input:checkbox").each(function () {
                            $(this).prop("checked", true);
                        })
                    });
                    var clear = $("<div class='layui-col-md2 layui-btn layui-btn-xs layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;font-size: 20px'/>").append($("<span style='padding: 5px;' />").html("清空")).click(function () {
                        $("." + $id + " input:checkbox").each(function () {
                            $(this).prop("checked", false);
                        })
                    });
                    var fanxuan = $("<div class='layui-col-md2 layui-btn layui-btn-xs layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;font-size: 20px'/>").append($("<span style='padding: 5px;' />").html("反选")).click(function () {
                        $("." + $id + " input:checkbox").each(function () {
                            if ($(this).prop("checked")) {
                                $(this).prop("checked", false);
                            } else {
                                $(this).prop("checked", true);
                            }
                        })
                    });

                    if (_type === 'next') {
                        if (data !== null) {
                            container.prepend(row);
                            var selectDiv = $("<div class='layui-col-md12'/>");
                            var select = $("<select class='layui-input' style='margin: 5px 0px;'/>");
                            $.each(data.map, function (index, m) {
                                var div = $("<div class='layui-col-md12'/>");
                                var div2 = $("<div class='layui-col-md12'>");

                                select.append($("<option value='" + m.key.key + "'>").html(m.key.value));
                                $.each(m.value, function (index, value) {
                                    div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='radio' name='" + $id + "' value='" + value.value + "' title='" + value.name + "' flag='1' typeId='" + value.typeId + "' >").click(function () {
                                        if ($(this).prop("checked")) {
                                            $(this).prop("checked", true);
                                        } else {
                                            $(this).prop("checked", false);
                                        }

                                    })).append(value.name))));
                                });
                                row.append(div);
                            });
                            if ($this.attr('data-value') !== undefined && $this.attr('data-value') !== '') {
                                $this.hide();
                                $this.after($("<label style='margin-left: 10px;'/>").html($this.attr('data-value')));
                            }
                            container.prepend(row.prepend(md12.append(selectDiv.append($("<label class='layui-form-label' style='margin: 5px;padding-left: 0;padding-right: 0;'>").html("下一步流程")).append($("<div class='layui-col-md6'/>").append(select)))));
                            add.click(function () {
                                $select.empty();
                                var tmp = '';
                                $("." + $id + " input:radio[flag='1']:checked").each(function () {
                                    tmp = $(this).val();
                                    $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html($(this).attr("title")));
                                });
                                if (tmp !== undefined && tmp !== '') {
                                    $(this).attr("disabled", "disabled");
                                }
                                $this.val(tmp);
                                if ($this.attr('data-value') === undefined || $this.attr('data-value') === '') {
                                    if (tmp === '' || tmp.length < 0) {
                                        $this.show();
                                        $this.next().hide();
                                        $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                    } else {
                                        $this.hide();
                                        $this.next().show();
                                        var h = $select.height();
                                        if (h > 0) {
                                            h += 4;
                                            $select.parent().css("height", h + "px");
                                            $this.parent('.layui-input-block').prev('.layui-form-label').css({
                                                "height": h + "px",
                                                "line-height": (h - 20) + "px"
                                            });
                                        } else {
                                            $select.parent().attr('style', '');
                                            $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                        }
                                    }
                                }
                                layer.closeAll();
                                $("#next").trigger("click");
                            });
                            container.append(btns.append($("<div style='float:left;margin-left:15px;margin-top:8px' />").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 15px;padding: 5px;'/>").html("是否短信发送").append($("<input type='checkbox' id='isSend' class='isSend'/>"))))));
                        }
                    } else if (_type === 'text') {
                        if (data !== null) {
                            var textDiv = $("<div class='content' style='margin: 10px;'/>");
                            var text = $("<textarea class='layui-textarea' autocomplete='off' rows='6'/>");
                            var phraseSelect = $("<select class='layui-input'/>").change(function () {
                                if ($(this).find("option:selected").val() !== '') {
                                    text.val(text.val() + $(this).val());
                                }
                            });
                            phraseSelect.append($("<option value=''>").html("请选择"));
                            if (data.o.phrases !== undefined) {
                                $.each(data.o.phrases, function (index, value) {
                                    phraseSelect.append($("<option value='" + value.content + "'>").html(value.content));
                                });
                            }

                            var historySelect = $("<select class='layui-input'/>").change(function () {
                                if ($(this).find("option:selected").val() !== '') {
                                    text.val($(this).val());
                                }
                            });
                            historySelect.append($("<option value=''>").html("请选择"));
                            if (data.o.historyPhrases !== undefined) {
                                $.each(data.o.historyPhrases, function (index, value) {
                                    historySelect.append($("<option value='" + value.content + "'>").html(value.content));
                                });
                            }

                            container.append(row.append(textDiv.append($("<div class='layui-col-md12'/>")
                                .append(text)).append($("<div class='layui-col-md12'  style='padding-top: 10px;'/>")
                                .append($("<label class='layui-form-label'/>").html("常用短句："))
                                .append($("<div class='layui-input-block'>")
                                    .append(phraseSelect))).append($("<div class='layui-col-md12' style='padding-top: 10px;'/>")
                                .append($("<label class='layui-form-label'/>").html("历史意见："))
                                .append($("<div class='layui-input-block'>").append(historySelect)))));

                            add.click(function () {
                                layer.closeAll();
                                if (is) {
                                    saveText('saveText', {
                                        'val': text.val(),
                                        'oldVal': data.o.val,
                                        'type': 1,
                                        'listId': data.o.listId
                                    }, $this);
                                } else {
                                    saveText('saveText', {
                                        'val': text.val(),
                                        'oldVal': data.o.val,
                                        'type': 2,
                                        'listId': data.o.listId
                                    }, $this);
                                }
                            });
                        }
                    } else if (_type === 'nextClick') {
                        container.prepend(row);
                        if (data !== null) {
                            var selectDiv = $("<div class='layui-col-md12'/>");
                            var select = $("<select class='layui-input' style='margin: 5px 0px;'/>");
                            $.each(data.map, function (index, m) {
                                var div = $("<div class='layui-col-md12'/>");
                                var div2 = $("<div class='layui-col-md12'>");

                                select.append($("<option value='" + m.key.key + "'>").html(m.key.value));
                                $.each(m.value, function (index, value) {
                                    div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='radio' name='" + $id + "' value='" + value.value + "' title='" + value.name + "' flag='1' typeId='" + value.typeId + "' >").click(function () {
                                        if ($(this).prop("checked")) {
                                            $(this).prop("checked", true);
                                        } else {
                                            $(this).prop("checked", false);
                                        }

                                    })).append(value.name))));
                                });
                                row.append(div);
                            });
                            container.prepend(row.prepend(md12.append(selectDiv.append($("<label class='layui-form-label' style='margin: 5px;padding-left: 0;padding-right: 0;'>").html("下一步流程")).append($("<div class='layui-col-md6'/>").append(select)))));
                            add.click(function () {
                                var tmp = '';
                                $("." + $id + " input:radio[flag='1']:checked").each(function () {
                                    tmp = $(this).val();
                                });
                                if (tmp !== undefined && tmp !== '') {
                                    $(this).attr("disabled", "disabled");
                                    $this.attr("data-value", tmp);
                                    layer.closeAll();
                                    $this.trigger("click");
                                }
                            });
                            container.append(btns.append($("<div style='float:left;margin-left:15px;margin-top:8px' />").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 15px;padding: 5px;'/>").html("是否短信发送").append($("<input type='checkbox' id='isSend' class='isSend'/>"))))));
                        }
                    } else if (_type === 'upper') {
                        container.prepend(row);
                        if (data !== null) {
                            var selectDiv = $("<div class='layui-col-md12'/>");
                            var select = $("<select class='layui-input' style='margin: 5px 0px;'/>");
                            $.each(data.map, function (index, m) {
                                var div = $("<div class='layui-col-md12'/>");
                                var div2 = $("<div class='layui-col-md12'>");

                                div.hide();
                                select.append($("<option value='" + m.key.key + "'>").html(m.key.value));

                                $.each(m.value, function (index, value) {
                                    div.attr('id', m.key.key);
                                    div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='radio' name='" + $id + "' value='" + value.value + "' title='" + value.name + "' flag='1' >").click(function () {
                                        if ($(this).prop("checked")) {
                                            $(this).prop("checked", true);
                                        } else {
                                            $(this).prop("checked", false);
                                        }
                                    })).append(value.name))));
                                });
                                row.append(div);
                                if (select.find("option:selected").val() === m.key.key) {
                                    div.show();
                                }
                            });
                            container.prepend(row.prepend(md12.append(selectDiv.append($("<label class='layui-form-label' style='margin: 5px;padding-left: 0;padding-right: 0;'>").html("上一步流程")).append($("<div class='layui-col-md6'/>").append(select)))));
                            select.change(function () {
                                var $key = $(this);
                                $("." + $id + " select option").each(function () {
                                    if ($(this).prop("selected")) {
                                        $("#" + $key.val()).show();
                                    } else {
                                        $("#" + $(this).val()).hide();
                                    }
                                })
                            });
                            container.append(btns.append($("<div style='float:left;margin-left:15px;margin-top:8px' />").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 15px;padding: 5px;'/>").html("是否短信发送").append($("<input type='checkbox' id='isSend' class='isSend'/>"))))));
                            add.click(function () {
                                var tmp = '';
                                var selectValue = '';

                                $("." + $id + " select option:selected").each(function () {
                                    selectValue = $(this).val();
                                    $("#" + $(this).val() + " input:radio[flag='1']:checked").each(function () {
                                        tmp = $(this).val();
                                    });
                                });
                                if (tmp !== undefined && tmp !== '') {
                                    $(this).attr("disabled", "disabled");
                                    $this.attr("data-value", tmp);
                                    $this.attr("select-value", selectValue);
                                    layer.closeAll();
                                    $this.trigger("click");
                                }
                            });
                        }


                    } else if (_type === 'click') {
                        container.prepend(row.append(md12.append($("<div class='layui-col-md6'/>"))));
                        if (data !== null) {
                            $.each(data.d, function (index, d) {
                                var div = $("<div class='layui-col-md12'/>");
                                var div2 = $("<div class='layui-col-md12'>");
                                div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='radio' name='" + $id + "' value='" + d.value + "' title='" + d.name + "' flag='1' >").click(function () {
                                    if ($(this).prop("checked")) {
                                        $(this).prop("checked", true);
                                    } else {
                                        $(this).prop("checked", false);
                                    }
                                })).append(d.name))));
                                row.append(div);
                            });
                            container.append(btns.append($("<div style='float:left;margin-left:15px;margin-top:8px' />").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 15px;padding: 5px;'/>").html("是否短信发送").append($("<input type='checkbox' id='isSend' class='isSend'/>"))))));
                            add.click(function () {
                                var tmp = '';
                                $("." + $id + " input:radio[flag='1']:checked").each(function () {
                                    tmp = $(this).val();
                                });
                                if (tmp !== undefined && tmp !== '') {
                                    $(this).attr("disabled", "disabled");
                                    $this.attr("data-value", tmp);
                                    layer.closeAll();
                                    $this.trigger("click");
                                }
                            });
                        }
                    } else if (_type === 'clickCheckbox') {
                        container.prepend(row.append(md12.append($("<div class='layui-col-md6'/>").append(all).append(clear).append(fanxuan))));
                        if (data != null) {
                            _type = 'checkbox';
                            $.each(data.d, function (index, d) {
                                var div = $("<div class='layui-col-md12'/>");
                                var div2 = $("<div class='layui-col-md12'>");
                                if (d.value !== undefined && d.name !== undefined) {
                                    div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs  layui-col-md2' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<input type='" + _type + "' value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' />").click(function () {
                                        if ($(this).prop("checked")) {
                                            $(this).prop("checked", true);
                                            $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']").each(function () {
                                                $(this).prop("checked", true);
                                            })
                                        } else {
                                            $(this).prop("checked", false);
                                            $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']").each(function () {
                                                $(this).prop("checked", false);
                                            })
                                        }
                                    })).append(d.name))));
                                }
                                $.each(d.u, function (index, u) {
                                    if (u.checked === undefined) {
                                        div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label  class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' >").click(function () {
                                            if ($(this).prop("checked")) {
                                                $(this).prop("checked", true);
                                            } else {
                                                $(this).prop("checked", false);
                                            }
                                            $("." + $id + " input:" + _type + "[flag='0']").each(function () {
                                                var i = 0;
                                                $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']:checked").each(function () {
                                                    i++;
                                                })
                                                if (i === $(this).attr('size')) {
                                                    $(this).prop("checked", true);
                                                } else {
                                                    $(this).prop("checked", false);
                                                }
                                            })
                                        })).append(u.name))));
                                    } else {
                                        div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label  class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' checked='" + u.checked + "' >").click(function () {
                                            if ($(this).prop("checked")) {
                                                $(this).prop("checked", true);
                                            } else {
                                                $(this).prop("checked", false);
                                            }
                                            $("." + $id + " input:" + _type + "[flag='0']").each(function () {
                                                var i = 0;
                                                $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']:checked").each(function () {
                                                    i++;
                                                })
                                                if (i === $(this).attr('size')) {
                                                    $(this).prop("checked", true);
                                                } else {
                                                    $(this).prop("checked", false);
                                                }
                                            })
                                        })).append(u.name))));
                                    }
                                });
                                row.append(div);
                            });
                            container.append(btns.append($("<div style='float:left;margin-left:15px;margin-top:8px' />").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 15px;padding: 5px;'/>").html("是否短信发送").append($("<input type='checkbox' id='isSend' class='isSend'/>"))))));
                            add.click(function () {
                                var tmp = '';
                                $("." + $id + " input:" + _type + "[flag='1']:checked").each(function () {
                                    tmp = tmp + $(this).val() + ",";
                                });
                                if (tmp !== undefined && tmp !== '') {
                                    $(this).attr("disabled", "disabled");
                                    $this.attr("data-value", tmp);
                                    layer.closeAll();
                                    $this.trigger("click");
                                }
                            });
                        }
                    } else if (_type === 'clickRadio') {
                        container.prepend(row.append(md12.append($("<div class='layui-col-md6'/>"))));
                        if (data != null) {
                            _type = 'radio';
                            $.each(data.d, function (index, d) {
                                if (d.u.length > 0) {
                                    var div = $("<div class='layui-col-md12'/>");
                                    var div2 = $("<div class='layui-col-md12'>");
                                    if (d.value !== undefined && d.name !== undefined) {
                                        div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<div value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' />")).append(d.name))));
                                    }
                                    if (d.u !== null && d.u !== undefined) {
                                        $.each(d.u, function (index, u) {
                                            if (u.checked === undefined) {
                                                div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' name='" + $id + "' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' >").click(function () {
                                                    if ($(this).prop("checked")) {
                                                        $(this).prop("checked", true);
                                                    } else {
                                                        $(this).prop("checked", false);
                                                    }
                                                })).append(u.name))));
                                            } else {
                                                div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' name='" + $id + "' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' checked='" + u.checked + "' >").click(function () {
                                                    if ($(this).prop("checked")) {
                                                        $(this).prop("checked", true);
                                                    } else {
                                                        $(this).prop("checked", false);
                                                    }
                                                })).append(u.name))));
                                            }
                                        });
                                    }
                                    row.append(div);
                                }
                            })
                            container.append(btns.append($("<div style='float:left;margin-left:15px;margin-top:8px' />").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 15px;padding: 5px;'/>").html("是否短信发送").append($("<input type='checkbox' id='isSend' class='isSend'/>"))))));
                            add.click(function () {
                                var tmp = $("." + $id + " input:" + _type + "[flag='1']:checked").val();
                                if (tmp !== undefined && tmp !== '') {
                                    $(this).attr("disabled", "disabled");
                                    $this.attr("data-value", tmp);
                                    layer.closeAll();
                                    $this.trigger("click");
                                }
                            });
                        }
                    } else if (_type === 'checkbox') {
                        container.prepend(row.append(md12.append($("<div class='layui-col-md6'/>").append(all).append(clear).append(fanxuan))));
                        if (data != null) {
                            if (is) {
                                var tmp = '';
                                $.each(data.d, function (index, d) {
                                    var div = $("<div class='layui-col-md12'/>");
                                    var div2 = $("<div class='layui-col-md12'>");
                                    if (d.value !== undefined && d.name !== undefined) {
                                        div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs  layui-col-md2' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<input type='" + _type + "' value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' />").click(function () {
                                            if ($(this).prop("checked")) {
                                                $(this).prop("checked", true);
                                                $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']").each(function () {
                                                    $(this).prop("checked", true);
                                                })
                                            } else {
                                                $(this).prop("checked", false);
                                                $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']").each(function () {
                                                    $(this).prop("checked", false);
                                                })
                                            }
                                        })).append(d.name))));
                                    }
                                    $.each(d.u, function (index, u) {
                                        if (u.checked === undefined) {
                                            div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label  class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' >").click(function () {
                                                if ($(this).prop("checked")) {
                                                    $(this).prop("checked", true);
                                                } else {
                                                    $(this).prop("checked", false);
                                                }
                                                $("." + $id + " input:" + _type + "[flag='0']").each(function () {
                                                    var i = 0;
                                                    $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']:checked").each(function () {
                                                        i++;
                                                    })
                                                    if (i === $(this).attr('size')) {
                                                        $(this).prop("checked", true);
                                                    } else {
                                                        $(this).prop("checked", false);
                                                    }
                                                })
                                            })).append(u.name))));
                                        } else {
                                            div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label  class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' checked='" + u.checked + "' >").click(function () {
                                                if ($(this).prop("checked")) {
                                                    $(this).prop("checked", true);
                                                } else {
                                                    $(this).prop("checked", false);
                                                }
                                                $("." + $id + " input:" + _type + "[flag='0']").each(function () {
                                                    var i = 0;
                                                    $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']:checked").each(function () {
                                                        i++;
                                                    })
                                                    if (i === $(this).attr('size')) {
                                                        $(this).prop("checked", true);
                                                    } else {
                                                        $(this).prop("checked", false);
                                                    }
                                                })
                                            })).append(u.name))));


                                            //$select.empty();
                                            tmp = tmp + u.value + ",";
                                            $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html(u.name));
                                            $this.val(tmp);
                                            if (tmp === '' || tmp.length < 0) {
                                                $this.show();
                                                $this.next().hide();
                                                $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                            } else {
                                                $this.hide();
                                                $this.next().show();
                                                var h = $select.height();
                                                if (h > 0) {
                                                    h += 4;
                                                    $select.parent().css("height", h + "px");
                                                    $this.parent('.layui-input-block').prev('.layui-form-label').css({
                                                        "height": h + "px",
                                                        "line-height": (h - 20) + "px"
                                                    });
                                                } else {
                                                    $select.parent().attr('style', '');
                                                    $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                                }
                                            }
                                        }
                                    });
                                    row.append(div);
                                });

                                if ($this.val().length > 0) {
                                    $("." + $id + " input:" + _type + "[flag='1']").each(function () {
                                        if ($this.val().indexOf($(this).val()) !== -1) {
                                            $(this).prop("checked", true);
                                            $("." + $id + " input:checkbox[flag='0']").each(function () {
                                                var i = 0;
                                                $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']:checked").each(function () {
                                                    i++;
                                                })
                                                if (i === $(this).attr('size')) {
                                                    $(this).prop("checked", true);
                                                } else {
                                                    $(this).prop("checked", false);
                                                }
                                            })
                                        }
                                    })
                                }
                                add.click(function () {
                                    if (show) {
                                        $select.empty();
                                        var tmp = '';
                                        $("." + $id + " input:" + _type + "[flag='1']:checked").each(function () {
                                            tmp = tmp + $(this).val() + ",";
                                            $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html($(this).attr("title")));
                                        });
                                        $this.val(tmp);
                                        if (tmp === '' || tmp.length < 0) {
                                            $this.show();
                                            $this.next().hide();
                                            $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                        } else {
                                            $this.hide();
                                            $this.next().show();
                                            var h = $select.height();
                                            if (h > 0) {
                                                h += 4;
                                                $select.parent().css("height", h + "px");
                                                $this.parent('.layui-input-block').prev('.layui-form-label').css({
                                                    "height": h + "px",
                                                    "line-height": (h - 20) + "px"
                                                });
                                            } else {
                                                $select.parent().attr('style', '');
                                                $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                            }
                                        }
                                    } else {
                                        $select.empty();
                                        var tmp = '';
                                        $("." + $id + " input:" + _type + "[flag='1']:checked").each(function () {
                                            tmp = tmp + $(this).val() + ",";
                                        });
                                        $this.val(tmp);
                                    }
                                    layer.closeAll();
                                });
                            } else {
                                var tmp = '';

                                $.each(data.d, function (index, d) {
                                    var div = $("<div class='layui-col-md12'/>");
                                    var div2 = $("<div class='layui-col-md12'>");
                                    if (d.checked === undefined) {
                                        div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<input type='" + _type + "' value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' />").click(function () {
                                            if ($(this).prop("checked")) {
                                                $(this).prop("checked", true);
                                            } else {
                                                $(this).prop("checked", false);
                                            }
                                        })).append(d.name))));
                                    } else {
                                        div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<input type='" + _type + "' value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' checked='" + d.checked + "' />").click(function () {
                                            if ($(this).prop("checked")) {
                                                $(this).prop("checked", true);
                                            } else {
                                                $(this).prop("checked", false);
                                            }
                                        })).append(d.name))));

                                        //$select.empty();
                                        tmp = tmp + d.value + ",";
                                        $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html(d.name));
                                        $this.val(tmp);
                                        if (tmp === '' || tmp.length < 0) {
                                            $this.show();
                                            $this.next().hide();
                                            $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                        } else {
                                            $this.hide();
                                            $this.next().show();
                                            var h = $select.height();
                                            if (h > 0) {
                                                h += 4;
                                                $select.parent().css("height", h + "px");
                                                $this.parent('.layui-input-block').prev('.layui-form-label').css({
                                                    "height": h + "px",
                                                    "line-height": (h - 20) + "px"
                                                });
                                            } else {
                                                $select.parent().attr('style', '');
                                                $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                            }
                                        }
                                    }
                                    row.append(div);
                                });

                                if ($this.val().length > 0) {
                                    $("." + $id + " input:" + _type + "[flag='0']").each(function () {
                                        if ($this.val().indexOf($(this).val()) !== -1) {
                                            $(this).prop("checked", true);
                                        }
                                    })
                                }
                                add.click(function () {
                                    if (show) {
                                        $select.empty();
                                        var tmp = '';
                                        $("." + $id + " input:" + _type + "[flag='0']:checked").each(function () {
                                            tmp = tmp + $(this).val() + ",";
                                            $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html($(this).attr("title")));
                                        });
                                        $this.val(tmp);
                                        if (tmp === '' || tmp.length < 0) {
                                            $this.show();
                                            $this.next().hide();
                                            $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                        } else {
                                            $this.hide();
                                            $this.next().show();
                                            var h = $select.height();
                                            if (h > 0) {
                                                h += 4;
                                                $select.parent().css("height", h + "px");
                                                $this.parent('.layui-input-block').prev('.layui-form-label').css({
                                                    "height": h + "px",
                                                    "line-height": (h - 20) + "px"
                                                });
                                            } else {
                                                $select.parent().attr('style', '');
                                                $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                            }
                                        }
                                    } else {
                                        $select.empty();
                                        var tmp = '';
                                        $("." + $id + " input:" + _type + "[flag='0']:checked").each(function () {
                                            tmp = tmp + $(this).val() + ",";
                                        });
                                        $this.val(tmp);
                                    }


                                    layer.closeAll()
                                });
                            }
                        }
                    } else if (_type === 'radio') {
                        container.prepend(row.append(md12.append($("<div class='layui-col-md6'/>"))));
                        if (data != null) {
                            if (is) {
                                $.each(data.d, function (index, d) {
                                    var div = $("<div class='layui-col-md12'/>");
                                    var div2 = $("<div class='layui-col-md12'>");
                                    if (d.value !== undefined && d.name !== undefined) {
                                        div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<div value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' />")).append(d.name))));
                                    }
                                    if (d.u !== null && d.u !== undefined) {
                                        $.each(d.u, function (index, u) {
                                            if (u.checked === undefined) {
                                                div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' name='" + $id + "' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' >").click(function () {
                                                    if ($(this).prop("checked")) {
                                                        $(this).prop("checked", true);
                                                    } else {
                                                        $(this).prop("checked", false);
                                                    }
                                                })).append(u.name))));
                                            } else {
                                                div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' name='" + $id + "' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' checked='" + u.checked + "' >").click(function () {
                                                    if ($(this).prop("checked")) {
                                                        $(this).prop("checked", true);
                                                    } else {
                                                        $(this).prop("checked", false);
                                                    }
                                                })).append(u.name))));


                                                //$select.empty();
                                                var tmp = u.value;
                                                $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html(u.name));
                                                $this.val(tmp);
                                                if (tmp === '' || tmp.length < 0) {
                                                    $this.show();
                                                    $this.next().hide();
                                                    $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                                } else {
                                                    $this.hide();
                                                    $this.next().show();
                                                    var h = $select.height();
                                                    if (h > 0) {
                                                        h += 4;
                                                        $select.parent().css("height", h + "px");
                                                        $this.parent('.layui-input-block').prev('.layui-form-label').css({
                                                            "height": h + "px",
                                                            "line-height": (h - 20) + "px"
                                                        });
                                                    } else {
                                                        $select.parent().attr('style', '');
                                                        $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                                    }
                                                }
                                            }
                                        });
                                    }
                                    row.append(div);
                                })

                                if ($this.val().length > 0) {
                                    $("." + $id + " input:" + _type + "[flag='1']").each(function () {
                                        if ($this.val().indexOf($(this).val()) !== -1) {
                                            $(this).prop("checked", true);
                                        }
                                    })
                                }
                                add.click(function () {
                                    $select.empty();
                                    var tmp = '';
                                    $("." + $id + " input:" + _type + "[flag='1']:checked").each(function () {
                                        tmp = $(this).val();
                                        $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html($(this).attr("title")));
                                    });
                                    $this.val(tmp);
                                    if (tmp === '' || tmp.length < 0) {
                                        $this.show();
                                        $this.next().hide();
                                        $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                    } else {
                                        $this.hide();
                                        $this.next().show();
                                        var h = $select.height();
                                        if (h > 0) {
                                            h += 4;
                                            $select.parent().css("height", h + "px");
                                            $this.parent('.layui-input-block').prev('.layui-form-label').css({
                                                "height": h + "px",
                                                "line-height": (h - 20) + "px"
                                            });
                                        } else {
                                            $select.parent().attr('style', '');
                                            $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                        }
                                    }
                                    layer.closeAll()
                                });
                            } else {
                                $.each(data.d, function (index, d) {
                                    var div = $("<div class='layui-col-md12'/>");
                                    var div2 = $("<div class='layui-col-md12'>");
                                    if (d.checked === undefined) {
                                        div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<input type='" + _type + "' name='" + $id + "' value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' />")).append(d.name))));
                                    } else {
                                        div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<input type='" + _type + "' name='" + $id + "' value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' checked='" + d.checked + "' />")).append(d.name))));

                                        //$select.empty();
                                        var tmp = d.value;
                                        $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html(d.name));
                                        $this.val(tmp);
                                        if (tmp === '' || tmp.length < 0) {
                                            $this.show();
                                            $this.next().hide();
                                            $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                        } else {
                                            $this.hide();
                                            $this.next().show();
                                            var h = $select.height();
                                            if (h > 0) {
                                                h += 4;
                                                $select.parent().css("height", h + "px");
                                                $this.parent('.layui-input-block').prev('.layui-form-label').css({
                                                    "height": h + "px",
                                                    "line-height": (h - 20) + "px"
                                                });
                                            } else {
                                                $select.parent().attr('style', '');
                                                $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                            }
                                        }
                                    }

                                    if ($this.val().length > 0) {
                                        $("." + $id + " input:" + _type + "[flag='0']").each(function () {
                                            if ($this.val().indexOf($(this).val()) !== -1) {
                                                $(this).prop("checked", true);
                                            }
                                        })
                                    }

                                    add.click(function () {
                                        $select.empty();
                                        var tmp = '';
                                        $("." + $id + " input:" + _type + "[flag='0']:checked").each(function () {
                                            tmp = $(this).val();
                                            $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html($(this).attr("title")));
                                        });
                                        $this.val(tmp);
                                        if (tmp === '' || tmp.length < 0) {
                                            $this.show();
                                            $this.next().hide();
                                            $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                        } else {
                                            $this.hide();
                                            $this.next().show();
                                            var h = $select.height();
                                            if (h > 0) {
                                                h += 4;
                                                $select.parent().css("height", h + "px");
                                                $this.parent('.layui-input-block').prev('.layui-form-label').css({
                                                    "height": h + "px",
                                                    "line-height": (h - 20) + "px"
                                                });
                                            } else {
                                                $select.parent().attr('style', '');
                                                $this.parent('.layui-input-block').prev('.layui-form-label').attr('style', '');
                                            }
                                        }
                                        layer.closeAll()
                                    });

                                    row.append(div);
                                })
                            }
                        }
                    }
                    close.click(function () {
                        layer.closeAll()
                    });
                    container.append(btns.append($("<div style='float:right;margin-right:30px;margin-top:8px' />").append(add).append(close)));
                    $("body").after(container.hide());
                }
            }
        ;
        exports('show', obj);
    }
);