/** kit_admin-v1.1.0 MIT License By http://kit/zhengjinfan.cn e-mail:zheng_jinfan@126.com */
;/**
 * Name:navbar.js
 * Author:Van
 * E-mail:zheng_jinfan@126.com
 * Website:http://kit.zhengjinfan.cn/
 * LICENSE:MIT
 */
var sendMail, receiveList, processQuery, agencyList, infoList
    , getOfficial, getFeedback, getTravel, getOffcalPost, getReception
    , getBLD, getCZ, getJGGZRY, getGNFWZXZR, getGNFWZXGZRY
    , getBLDZZ, getCZZZ, getGZRYZZ, getZXZRZZ, getZXGZRYZZ, getUseCar, getJoint, getCenterOffcial, getCenterOffcialPost
    , getCenterBusinessTrip;
layui.define(['layer', 'laytpl', 'element'], function (exports) {
    var $ = layui.jquery,
        layer = layui.layer,
        _modName = 'navbar',
        _win = $(window),
        _doc = $(document),
        laytpl = layui.laytpl,
        element = layui.element;

    var navbar = {
        v: '1.0.4',
        config: {
            data: undefined, //静态数据
            remote: {
                url: undefined, //接口地址
                type: 'GET', //请求方式
                jsonp: false //跨域
            },
            cached: false, //是否缓存
            elem: undefined, //容器
            filter: 'kitNavbar' //过滤器名称
        },
        set: function (options) {
            var that = this;
            that.config.data = undefined;
            $.extend(true, that.config, options);
            return that;
        },
        /**
         * 是否已设置了elem
         */
        hasElem: function () {
            var that = this,
                _config = that.config;
            if (_config.elem === undefined && _doc.find('ul[kit-navbar]').length === 0 && $(_config.elem)) {
                layui.hint().error('Navbar error:请配置Navbar容器.');
                return false;
            }
            return true;
        },
        /**
         * 获取容器的jq对象
         */
        getElem: function () {
            var _config = this.config;
            return (_config.elem !== undefined && $(_config.elem).length > 0) ? $(_config.elem) : _doc.find('ul[kit-navbar]');
        },
        /**
         * 绑定特定a标签的点击事件
         */
        bind: function (callback, params) {
            var that = this,
                _config = that.config;
            var defaults = {
                target: undefined,
                showTips: true
            };
            $.extend(true, defaults, params);
            var _target = defaults.target === undefined ? _doc : $(defaults.target);
            // if (!that.hasElem())
            //     return that;
            // var _elem = that.getElem();
            _target.find('a[kit-target]').each(function () {
                var _that = $(this),
                    tipsId = undefined;
                if (defaults.showTips) {
                    _that.hover(function () {
                        tipsId = layer.tips($(this).children('span').text(), this);
                    }, function () {
                        if (tipsId)
                            layer.close(tipsId);
                    });
                }

                var tmp = (new Function('return ' + _that.data('options') + ';'))();

                switch (tmp.id) {
                    case '2b40f587f7ea4fd8941696aae4b90501':
                        sendMail = tmp;
                        break;
                    case '421ead92ee7d4e368e55c543380a98b4':
                        receiveList = tmp;
                        break;
                    case '3ca065b538924f198ab49ee6d992e311':
                        processQuery = tmp;
                        break;
                    case 'ae501643a9b34e0ab9f8020ba4029fd4':
                        agencyList = tmp;
                        break;
                    case 'f2b0c77ee76e47f288757900259ced18':
                        infoList = tmp;
                        break;
                    case 'b5e3f0360d554034b050653bb370b799':
                        getOfficial = tmp;
                        break;
                    case '0dbf4ea9c34443ce823076a45904a5b6':
                        getFeedback = tmp;
                        break;
                    case '7d0312d691264048b854781c7944e9bd':
                        getTravel = tmp;
                        break;
                    case 'b273f5c10ad04890ae26d42d62f67715':
                        getOffcalPost = tmp;
                        break;
                    case '04bdc3538cac420e9c59150e731e30d3':
                        getReception = tmp;
                        break;
                    case '10d4018283ec459fb33d382dbfe6b4b9':
                        getBLD = tmp;
                        break;
                    case 'b9097cdd2f844aefb21dee5b81da0aee':
                        getCZ = tmp;
                        break;
                    case 'd6e4f3daad594e0d984454a96a8aeee1':
                        getJGGZRY = tmp;
                        break;
                    case 'b576259547e948009b67e5033edbecbe':
                        getGNFWZXZR = tmp;
                        break;
                    case '57ff20e9e59e42c58168bc498dfaf0b3':
                        getGNFWZXGZRY = tmp;
                        break;
                    case 'b26a0dd9d3f846cb80e33e4691b5c611':
                        getBLDZZ = tmp;
                        break;
                    case 'd5294c9d7da4445ba31146ff6325e075':
                        getCZZZ = tmp;
                        break;
                    case '0dcf86f50a514fed9879b48c2e3871f4':
                        getGZRYZZ = tmp;
                        break;
                    case '9158e97ae7b048998eade5e6df4b5183':
                        getZXZRZZ = tmp;
                        break;
                    case '973702b20d4145369d2355c6a4da428e':
                        getZXGZRYZZ = tmp;
                        break;
                    case 'e8a05f49f31d4516b283b012c89b7eca':
                        getUseCar = tmp;
                        break;
                    case 'a86572999bc04e7ba691cf30ba7f9eb3':
                        getJoint = tmp;
                        break;
                    case '35e25af445614be0bc874071da19ff17':
                        getMeetPlan = tmp;
                        break;
                    case 'd0c83cbfe79f4d5086fb7fd0813e7535':
                        getCenterOffcial = tmp;
                        break;
                    case 'fb377b8827084b049637d36f6b1ee464':
                        getCenterOffcialPost = tmp;
                        break;
                    case 'e245820e1815408a996504f338d86df5':
                        getCenterBusinessTrip = tmp;
                        break;
                    default:
                        break;
                }

                _that.off('click').on('click', function () {
                    var options = _that.data('options');
                    var data;
                    if (options !== undefined) {
                        try {
                            data = new Function('return ' + options)();
                        } catch (e) {
                            layui.hint().error('Navbar 组件a[data-options]配置项存在语法错误：' + options)
                        }
                    } else {
                        data = {
                            icon: _that.data('icon'),
                            id: _that.data('id'),
                            title: _that.data('title'),
                            url: _that.data('url'),
                        };
                    }
                    typeof callback === 'function' && callback(data);
                });
            });
            $('.kit-side-fold').off('click').on('click', function () {
                var _side = _doc.find('div.kit-side');
                if (_side.hasClass('kit-sided')) {
                    _side.removeClass('kit-sided');
                    _doc.find('div.layui-body').removeClass('kit-body-folded');
                    _doc.find('div.layui-footer').removeClass('kit-footer-folded');
                } else {
                    _side.addClass('kit-sided');
                    _doc.find('div.layui-body').addClass('kit-body-folded');
                    _doc.find('div.layui-footer').addClass('kit-footer-folded');
                }
            });
            return that;
        },
        /**
         * 渲染navbar
         */
        render: function (callback) {
            var that = this,
                _config = that.config, //配置
                _remote = _config.remote, //远程参数配置
                _tpl = [
                    '{{# layui.each(d,function(index, item){ }}',
                    '{{# if(item.spread){ }}',
                    '<li class="layui-nav-item layui-nav-itemed">',
                    '{{# }else{ }}',
                    '<li class="layui-nav-item">',
                    '{{# } }}',
                    '{{# var hasChildren = item.children!==undefined && item.children.length>0; }}',
                    '{{# if(hasChildren){ }}',
                    '<a href="javascript:;">',
                    '{{# if (item.icon.indexOf("fa-") !== -1) { }}',
                    '<i class="fa {{item.icon}}" aria-hidden="true"></i>',
                    '{{# } else { }}',
                    '<i class="layui-icon">{{item.icon}}</i>',
                    '{{# } }}',
                    '<span> {{item.title}}</span>',
                    '</a>',
                    '{{# var children = item.children; }}',
                    '<dl class="layui-nav-child">',
                    '{{# layui.each(children,function(childIndex, child){ }}',
                    '<dd>',
                    '<a href="javascript:;" kit-target data-options="{url:\'{{child.url}}\',icon:\'{{child.icon}}\',title:\'{{child.title}}\',id:\'{{child.id}}\'}">',
                    '{{# if (child.icon.indexOf("fa-") !== -1) { }}',
                    '<i class="fa {{child.icon}}" aria-hidden="true"></i>',
                    '{{# } else { }}',
                    '<i class="layui-icon">{{child.icon}}</i>',
                    '{{# } }}',
                    '<span> {{child.title}}</span>',
                    '</a>',
                    '</dd>',
                    '{{# }); }}',
                    '</dl>',
                    '{{# }else{ }}',
                    '<a href="javascript:;" kit-target data-options="{url:\'{{item.url}}\',icon:\'{{item.icon}}\',title:\'{{item.title}}\',id:\'{{item.id}}\'}">',
                    '{{# if (item.icon.indexOf("fa-") !== -1) { }}',
                    '<i class="fa {{item.icon}}" aria-hidden="true"></i>',
                    '{{# } else { }}',
                    '<i class="layui-icon">{{item.icon}}</i>',
                    '{{# } }}',
                    '<span> {{item.title}}</span>',
                    '</a>',
                    '{{# } }}',
                    '</li>',
                    '{{# }); }}',
                ], //模板
                _data = [];
            var navbarLoadIndex = layer.load(2);
            if (!that.hasElem())
                return that;
            var _elem = that.getElem();
            //本地数据优先
            if (_config.data !== undefined && _config.data.length > 0) {
                _data = _config.data;
            } else {
                var dataType = _remote.jsonp ? 'jsonp' : 'json';
                var options = {
                    url: _remote.url,
                    type: _remote.type,
                    error: function (xhr, status, thrown) {
                        layui.hint().error('Navbar error:AJAX请求出错.' + thrown);
                        navbarLoadIndex && layer.close(navbarLoadIndex);
                    },
                    success: function (res) {
                        _data = res;
                    }
                };
                $.extend(true, options, _remote.jsonp ? {
                    dataType: 'jsonp',
                    jsonp: 'callback',
                    jsonpCallback: 'jsonpCallback'
                } : {
                    dataType: 'json'
                });
                $.support.cors = true;
                $.ajax(options);
            }
            var tIndex = setInterval(function () {
                if (_data.length > 0) {
                    clearInterval(tIndex);
                    //渲染模板
                    laytpl(_tpl.join('')).render(_data, function (html) {
                        _elem.html(html);
                        element.init();
                        //绑定a标签的点击事件
                        that.bind(function (data) {
                            typeof callback === 'function' && callback(data);
                        });
                        //关闭等待层
                        navbarLoadIndex && layer.close(navbarLoadIndex);
                    });
                }
            }, 50);
            return that;
        }
    };
    exports('navbar', navbar);
});