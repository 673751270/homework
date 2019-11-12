layui.define(function (exports) {
    var obj = {
        into: function (id, title, w, h, _id, type, data, is) {
            var $this = $(_id);
            var _type = type;
            var $id = id;
            $this.attr('readonly', 'readonly');
            $this.after($("<label class='layui-input' for='" + $this.attr('id') + "'/>").hide().append($("<div/>")));
            check.into(id, _id, type, data, is);
            $this.click(function () {
                obj.show(id, title, w, h);
            });
        },
        show: function (id, title, w, h) {
            var number = 1;
            if (title == null || title == '') {
                title = false;
            }
            ;
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
        into: function (id, _id, type, data, is) {
            var $this = $(_id);
            var _type = type;
            var $id = id;
            var $select = $this.next().children();
            var container = $("<div class='" + $id + "'/>");
            var row = $("<div class='layui-row'/>");
            var md12 = $("<div class='layui-col-md12' />");
            var btns = $("<div style='width: 100%;height: 56px;background-color: white;border-top:1px solid #e6e6e6;\n" +
                "  position: sticky;bottom: 1px;'/>");
            var add = $("<button class='layui-btn layui-btn-normal'/>").html("增加");
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

            if (_type == 'checkbox') {
                container.prepend(row.append(md12.append($("<div class='layui-col-md6'/>").append(all).append(clear).append(fanxuan))));
                if (data != null) {
                    if (is) {
                        var tmp = '';
                        $.each(data.d, function (index, d) {
                            var div = $("<div class='layui-col-md12'/>");
                            var div2 = $("<div class='layui-col-md12'>");
                            if (d.value != undefined && d.name != undefined) {
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
                                if (u.checked == undefined) {
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
                                            if (i == $(this).attr('size')) {
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
                                            if (i == $(this).attr('size')) {
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
                                    if (tmp == '' || tmp.length < 0) {
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
                                if ($this.val().indexOf($(this).val()) != -1) {
                                    $(this).prop("checked", true);
                                    $("." + $id + " input:checkbox[flag='0']").each(function () {
                                        var i = 0;
                                        $("." + $id + " input:" + _type + "[typeId='" + $(this).val() + "']:checked").each(function () {
                                            i++;
                                        })
                                        if (i == $(this).attr('size')) {
                                            $(this).prop("checked", true);
                                        } else {
                                            $(this).prop("checked", false);
                                        }
                                    })
                                }
                            })
                        }
                        add.click(function () {
                            $select.empty();
                            var tmp = '';
                            $("." + $id + " input:" + _type + "[flag='1']:checked").each(function () {
                                tmp = tmp + $(this).val() + ",";
                                $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html($(this).attr("title")));
                            });
                            $this.val(tmp);
                            if (tmp == '' || tmp.length < 0) {
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
                            layer.close(layer.index);
                        });
                    } else {
                        var tmp = '';

                        $.each(data.d, function (index, d) {
                            var div = $("<div class='layui-col-md12'/>");
                            var div2 = $("<div class='layui-col-md12'>");
                            if (d.checked == undefined) {
                                div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<input type='" + _type + "' value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' />").click(function () {
                                    if ($(this).prop("checked")) {
                                        $(this).prop("checked", true);
                                    } else {
                                        $(this).prop("checked", false);
                                    }
                                })).append(d.name))));
                            } else {
                                div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<input type='" + _type + "' value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' checked='" + d.checked + "' />").click(function () {
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
                                if (tmp == '' || tmp.length < 0) {
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
                                if ($this.val().indexOf($(this).val()) != -1) {
                                    $(this).prop("checked", true);
                                }
                            })
                        }
                        add.click(function () {
                            $select.empty();
                            var tmp = '';
                            $("." + $id + " input:" + _type + "[flag='0']:checked").each(function () {
                                tmp = tmp + $(this).val() + ",";
                                $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html($(this).attr("title")));
                            });
                            $this.val(tmp);
                            if (tmp == '' || tmp.length < 0) {
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
                            layer.close(layer.index)
                        });
                    }
                }
            } else if (_type == 'radio') {
                container.prepend(row.append(md12.append($("<div class='layui-col-md6'/>"))));
                if (data != null) {
                    if (is) {
                        $.each(data.d, function (index, d) {
                            var div = $("<div class='layui-col-md12'/>");
                            var div2 = $("<div class='layui-col-md12'>");
                            div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<div value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' />")).append(d.name))));
                            if (d.u != null && d.u != undefined) {
                                $.each(d.u, function (index, u) {
                                    if (u.checked == undefined) {
                                        div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' name='radio' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' >").click(function () {
                                            if ($(this).prop("checked")) {
                                                $(this).prop("checked", true);
                                            } else {
                                                $(this).prop("checked", false);
                                            }
                                        })).append(u.name))));
                                    } else {
                                        div.append(div2.append($("<div class='layui-btn layui-btn-xs layui-col-md2 layui-btn-primary' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 20px;padding: 5px;'/>").append($("<input type='" + _type + "' name='radio' value='" + u.value + "' title='" + u.name + "' flag='1' typeId='" + u.typeId + "' checked='" + u.checked + "' >").click(function () {
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
                                        if (tmp == '' || tmp.length < 0) {
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
                                if ($this.val().indexOf($(this).val()) != -1) {
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
                            if (tmp == '' || tmp.length < 0) {
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
                            layer.close(layer.index)
                        });
                    } else {
                        $.each(data.d, function (index, d) {
                            var div = $("<div class='layui-col-md12'/>");
                            var div2 = $("<div class='layui-col-md12'>");
                            if (d.checked == undefined) {
                                div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<div value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' />")).append(d.name))));
                            } else {
                                div.append($("<div class='layui-col-md12'/>").append($("<div class='layui-btn layui-btn-xs layui-col-md2' style='margin: 5px;padding: 0;height: auto;width: auto;'/>").append($("<label class='layui-col-md12' style='font-size: 25px;padding: 5px;' />").append($("<div value='" + d.value + "' title='" + d.name + "' flag='0' size='" + d.size + "' checked='" + d.checked + "' />")).append(d.name))));

                                //$select.empty();
                                var tmp = d.value;
                                $select.append($("<div class='layui-btn layui-btn-xs' style='position:5px;margin:6px 2px 6px 2px'/>").html(d.name));
                                $this.val(tmp);
                                if (tmp == '' || tmp.length < 0) {
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
                        })
                    }
                }
            }
            close.click(function () {
                layer.close(layer.index);
            });
            container.append(btns.append($("<div class='layui-form-item' style='float:right;margin-right:30px;margin-top:8px' />").append(add).append(close)));
            $("body").after(container.hide());
        }
    };
    exports('show', obj);
});