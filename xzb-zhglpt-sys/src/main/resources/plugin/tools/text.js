layui.define(function (exports) {
    var obj = {
        into: function (id, data) {
            var $this = $(id);
            var input = $("<label class='layui-input' for='" + $this.attr('id') + "'/>");
            var div = $("<div/>");
            $this.parent().append(input.prepend($this).prepend(div));
            $this.css({width: "99%", border: "0", position: "5px", margin: "6px 2px 6px 2px"});

            $.each(data, function (index, val) {
                obj.add(div, data, $this, input, val);
            });

            obj.intoHeight(input, $this, div);

            $this.keydown(function (event) {
                if (event.keyCode === 13) {
                    if ($(this).val() !== undefined && $(this).val() !== '') {
                        data.push($(this).val());
                        obj.add(div, data, $this, input, $(this).val());
                        obj.intoHeight(input, $this, div);
                        $(this).val('');
                    }
                }
            });

        },
        intoHeight: function (input, $this, div) {
            if (div.html() !== '') {
                var height = $this.outerHeight(true) + div.outerHeight(true);
                input.css("height", height);
                $this.parent('.layui-input').parent('.layui-input-block').prev('.layui-form-label').css({
                    "height": height + 'px'
                })
            } else {
                input.removeAttr("style");
                $this.parent('.layui-input').parent('.layui-input-block').prev('.layui-form-label').removeAttr("style");
            }
        },
        add: function (div, data, $this, input, val) {
            div.append($("<div class='layui-btn-group' style='position:5px;margin:6px 2px 6px 2px'/>").append($("<div class='layui-btn layui-btn-xs'/>").html(val)).append($("<div class='layui-btn layui-btn-xs' style='border-left:0;'/>").html("X").click(function () {
                delete data[$.inArray(val, data)];
                $(this).parent().remove();
                obj.intoHeight(input, $this, div);
            })));
        }
    };

    exports('text', obj);
});