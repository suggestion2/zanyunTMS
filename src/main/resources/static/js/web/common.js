// 轮播图
$(document).ready( function() {
	if($('.slick-carousel').length > 0) {
		$('.recent-works.slick-carousel .portfolio-container').slick({
			dots: true,
			slidesToShow: 3,
			cssEase: 'ease-in',
			prevArrow: '<button type="button" data-role="none" class="btn slick-prev">Previous</button>',
			nextArrow: '<button type="button" data-role="none" class="btn slick-next">Next</button>',
			responsive: [
				{
					breakpoint: 993,
					settings: {
						slidesToShow: 2
					}
				},
				{
					breakpoint: 481,
					settings: {
						slidesToShow: 1
					}
				}
			]
		});

		$('.testimonial.slick-carousel .testimonial-container').slick({
			speed: 500,
			fade: true,
			prevArrow: '<button type="button" data-role="none" class="btn slick-prev">Previous</button>',
			nextArrow: '<button type="button" data-role="none" class="btn slick-next">Next</button>',
		});

		$('#carousel-hero .carousel-inner').slick({
			speed: 800,
			dots: true,
			fade: true,
			autoplay: true,
			autoplaySpeed: 3000,
			prevArrow: '<button type="button" data-role="none" class="carousel-control left slick-prev">Previous</button>',
			nextArrow: '<button type="button" data-role="none" class="carousel-control right slick-next">Next</button>',
		});
	}
});

// 内容最小高度

function resizeWin() {
    $(window).resize(function() {
        content();
    });
    content();
    function content() {
        var winH=$(window).height();
        var footerH=$('footer').height();
        var navH=$('.navbar').height();
        var conH=winH-footerH-navH;
        if($(".main_section").height()<conH){
            $(".main_section").css({'min-height':conH});
        }
    }
}

$(document).ready( function() {
    // 根据路由菜单悬停
    var url=window.location.pathname;
    var type=url.split('/')[1];
    if(type=='notices'){
        type='news';
    }else if(type==''){
        type='index';
    }
    $(".nav li[data-url='"+type +"']").addClass('active');

    //判断内容高度
    resizeWin();

    //获取登录信息
    $.ajax({
        url:'/api/current/loginStatus',
        type:'GET',
        async:false,
        dataType:'json',
        success:function (json) {
            if(json.response!='fail'){
                $('.special-menu-item .resLogBtn').hide();
                $('.enterCenter').attr('data-type',json.response);
                $('.enterCenter').show();
            }else{
                $('.special-menu-item .resLogBtn').show();
                $('.enterCenter').hide();
            }
        }
    });
    //进入会员中心
    $('.enterCenter').on('click',function () {
        var type=$(this).attr('data-type');
        tools.navigate('/'+type+'/center');
    });


});
// 退出登录
function logout() {
    $.ajax({
        url:'/api/logout',
        type:'GET',
        async:false,
        dataType:'json',
        success:function (json) {}
    });
    tools.navigate('/');
}

//定义content类型
var APPLICATION_JSON = "application/json; charset=utf-8";
// 加载中的窗口索引
var loadingIndex = undefined;
var loading = 0;
// 默认时间插件配置
var timeConfig={
    language:  'zh',
    weekStart : 1,
    todayBtn : 1,
    clearBtn : 1,
    autoclose : 1,
    todayHighlight : 1,
    startView : 2,
    minView: "month",
    format: 'yyyy-mm-dd',
    forceParse : 0
};
// 常用工具
var tools={
    DLG_ICON : {
        SUCCESS: 1, ERROR: 2, WARN: 0, QUERY: 3
    },
    /**
     * 将值转为json。如果不是json，则输出原始内容。
     * @param str 要转为json的字符串
     */
    toJson: function (str) {
        try {
            // 不是字符串则直接返回
            if (tools.isString(str) === false) return str;
            // 如果不是json格式则返回原始字符串
            if (!str.trim().match(/^\{(.+:.+,*)+}$/)) return str;

            // decimal类型数据进行json parse的时候会丢失部分小数部位，例如3.00->3，3.500->3.5
            // 所以这边将数值类型的转换为字符串类型
            str=str.replace(/([^\\]":)(\d+(\.\d+)?)/g, "$1\"$2\"");
            return JSON.parse(str);
        } catch (e) {
            return str;
        }
    },
    /**
     * 判断给定的值是否为字符串
     * @param v
     * @returns {boolean}
     */
    isString:function  (v) {
        return typeof v === "string";
    },
    //是否是函数
    isFunction:function (v) {
        return $.isFunction(v);
    },

    /**
     * 显示"加载中"提示框
     */
    showLoading:function(){
        if (!loadingIndex) loadingIndex = layer.load();
        loading += 1;
    },
    /**
     * 关闭"加载中"提示框
     */
    closeLoading : function () {
        if (loadingIndex && loading === 1){
            layer.close(loadingIndex);
            loadingIndex = undefined;
        }
        loading -= 1;
    },
    /**
     * 信息框
     */
    msg : function (content, icon, timeout, callback) {
        // 如果ICON是函数，那么icon实际是回调。
        if ($.isFunction(icon)) {
            callback = icon;
            timeout = 1.5;
            icon = undefined;
        }
        else if ($.isFunction(timeout)) {
            callback = timeout;
            timeout = 1.5;
        }
        if (!timeout) timeout = 1.5;
        layer.msg(content, { icon: icon, time: timeout * 1000, shade: 0.3, shadeClose: true }, function () {
            if ($.isFunction(callback)) callback();
        });
    },
    /**
     * 确定框
     */
    confirm : function (content, title, icon, ok, cancel) {
        // 如果title是函数，则实际是callback
        if ($.isFunction(title)) {
            cancel = icon;
            ok = title;
            title = icon = undefined;
        }
        // 如果ICON是函数，那么icon实际是回调。
        else if ($.isFunction(icon)) {
            cancel = ok;
            ok = icon;
            icon = undefined;
        }
        layer.confirm(content, { title: title, icon: icon, closeBtn: 0 }, function (index) {
            if ($.isFunction(ok)) ok();
            layer.close(index);
        }, function (index) {
            var close = true;
            if ($.isFunction(cancel)) close = cancel();
            if (close !== false)layer.close(index);
        });
    },

    /**
     * 普通信息框。
     * @param content 信息内容
     * @param title 信息标题。如果这里传递函数，则表示回调函数。
     * @param icon 信息框图标。如果这里传递函数，则表示回调函数。
     * @param callback 点击确定后的回调函数
     */
    alert : function (content, title, icon, callback) {
        // 如果title是函数，则实际是callback
        if ($.isFunction(title)) {
            callback = title;
            title = "";
            icon = tools.DLG_ICON.SUCCESS;
        }
        // 如果ICON是函数，那么icon实际是回调。
        else if ($.isFunction(icon)) {
            callback = icon;
            icon = undefined;
        }
        layer.alert(content, { title: title, icon: icon }, function (index) {
            if ($.isFunction(callback)) callback();
            layer.close(index);
        });
    },

    ajax : function (options) {
        var url = options.url;
        // 没定义URL
        if (url === undefined) return;
        // 根据选项确认是否显示遮障
        if (options.showMask) tools.showLoading();

        $.ajax({
            type: options.type || "GET",      // 提交类型
            url: url,                           // 提交的URL
            data: options.data || {},           // 要提交的数据
            dataType: "html",                   // 响应的数据格式
            contentType: options.contentType || true,
            complete: function () {
                // 关闭加载中的提示
                if (options.showMask) tools.closeLoading();
            },
            success: function (response) {
                // 如果值是字符串，说明返回不是json，那么就不能按json进行处理了。
                if (tools.isString(response)) {
                    // 将值转化为json
                    response = tools.toJson(response);
                    if (tools.isFunction(options.success)) options.success(response);
                }
                else {
                    // 请求成功则直接处理回调
                    if (response.success === true) {
                        if (tools.isFunction(options.success)) options.success(response);
                    }
                    // 全局统一处理ajax的异常信息
                    else {
                        var error = response.error || { error: -1, message: "发生未知错误!" };
                        if(response.error.code==504){
                            /*tools.alert(error.message, undefined, tools.DLG_ICON.ERROR, function () {
                                if (tools.isFunction(options.fault)) options.fault(response);
                                // 未登录提示
                                tools.navigate("/logout");
                            });*/
                            alert("504错误");
                        }else{
                            /*tools.alert(error.message, undefined, tools.DLG_ICON.ERROR, function () {
                                if (tools.isFunction(options.fault)) options.fault(response);
                            });*/
                        }
                    }
                }
            },
            error: function (res) {
                if (tools.isFunction(options.fault)) options.fault();
                var resJson = tools.toJson(res.responseText);
                if(resJson.message==null){
                    tools.msg(resJson.fieldError.message)
                }else{
                    if(resJson.errorCode=='driverLoginRequired'||resJson.errorCode=='ownerLoginRequired'){
                        tools.msg(resJson.message,function () {
                            tools.navigate('/login')
                        })
                    }else{
                        tools.msg(resJson.message)
                    }
                }
                // 提示错误
            },
        });
    },
    ajaxPost : function (url, data, success, fault) {
        if (tools.isFunction(data)) {
            fault = success;
            success = data;
            data = undefined;
        }
        var options = {
            type: "POST",
            url: url,
            data: JSON.stringify(data),
            showMask: true,
            success: success,
            fault: fault,
            contentType: APPLICATION_JSON
        };
        tools.ajax(options);
    },
    ajaxPut:function (url, data, success, fault) {
        var options = {
            type: "PUT",
            url: url,
            data: JSON.stringify(data),
            showMask: true,
            success: success,
            fault: fault,
            contentType: APPLICATION_JSON
        };
        tools.ajax(options);
    },
    //导航当前页面到指定的URL
    navigate:function (url, params) {
        location.href=tools.addUrlParam(url, params);
    },
    //拼接URL和参数
    addUrlParam:function  (url, params) {
        if (!params) return url;
        if (url.indexOf("?") > 0) return url + "&" + $.param(params);
        return url + "?" + $.param(params);
    },
    // hash转json
    hashToJson:function(param){
        var qs = {};
        for (var i = 0; i < param.length; i++) {
            var pair = param[i].split("=");
            var name = pair[0];
            var value = decodeURIComponent(pair[1]);
            if (typeof qs[name] === "undefined") {
                qs[name] = value;
            }
            else {
                // 发现重复定义的参数，则值为数组
                var array = qs[name];
                if (Array.isArray(array) === false) array = [];
                array.push(value);
            }
        };
        return qs;
    },
    //拼接hash返回对象

    urlParam:function(){
        var vars = window.location.search.substring(1).split("&");
        var urlToJson=tools.hashToJson(vars);
        return urlToJson;
    },
    // 获取指定name的值
    getVal:function (name)
    {
        var tag = $(".item [name='" + name + "']");
        return $.trim(tag.val());
    },
    //获取一系列的name的值
    getQueryJson:function (names) {
        var parm={};
        var arr=names.split(',');
        for(var i in arr){
            if (!arr[i]) continue;
            var t = tools.getVal(arr[i]);
            if (t)
                parm[arr[i]] = t;
        }
        return parm;
    },
    //设定开始时间与结束时间
    timeStartEnd:function (startId,endId) {

        this.startId=startId;
        this.endId=endId;
        var self=this;

        $(this.startId).datetimepicker(timeConfig).on('hide',function (event) {
            event.preventDefault();
            event.stopPropagation();
            var startTime = event.date;
            $(self.endId).datetimepicker('setStartDate',startTime);
        });
        $(this.endId).datetimepicker(timeConfig).on('hide',function (event) {
            event.preventDefault();
            event.stopPropagation();
            var endTime = event.date;
            $(self.startId).datetimepicker('setEndDate',endTime);
        });
    },
    //发送验证码
    sendMsgCode:function (clickObj,url,type) {
        clickObj.on('click',function () {
            var curCount=120;
            var self=this;
            var phoneNum=tools.getVal('phone');
            if(clickObj.hasClass('disabled')){
                return false;
            }else{
                tools.ajaxPost(url,{phone:phoneNum,type:type},function (json) {
                    tools.msg('验证码已发送',function () {
                        sendCodeEffect(curCount,self);
                    });
                });
            }
        });
        function sendCodeEffect(curCount,that) {
            clearInterval(that.InterValObj);
            sendCode();
            function sendCode() {
                $(that).text("已发送"+curCount+"s").addClass('disabled');
                that.InterValObj=window.setInterval(SetRemainTime,1000);
            }
            //timer处理函数
            function SetRemainTime() {
                if(curCount==0){
                    window.clearInterval(that.InterValObj);
                    $(that).text("重新发送").removeClass('disabled');
                }else{
                    curCount--;
                    $(that).text("已发送"+curCount+"s");
                }
            }
        }
    },
};

/*广告位*/
/*
** 参数有：nodeLink,floatObj,x,y,main,space,locate
**1、必须的参数是：floatObj，y，locate,
**2、如果使用HTML结构的，则不需要nodeLink
**3、如果位置是固定的，则不需要main、space
**4、如果位置和页面上的主体有关，则不需要x
*/
var FloatAd = function(obj){
    var mainNode = $("." + obj.main)[0];
    if(obj.nodeLink && (typeof obj.nodeLink == "string")){
        var newFloatObj = document.createElement("div");
        newFloatObj.id = obj.floatObj;
        newFloatObj.style.position = "absolute";
        newFloatObj.style.zIndex = 10;
        newFloatObj.innerHTML = obj.nodeLink;
        document.body.appendChild(newFloatObj);
    }
    this.ad = document.getElementById(obj.floatObj);
    this.main = document.getElementById(obj.main)||mainNode;
    this.x = obj.x;
    this.y = obj.y;
    this.locate = obj.locate;
    this.space = obj.space;
    var that = this;
    this.play = function(){
        setInterval(function(){
            that.calculate();
        },10);
    };
};
FloatAd.prototype = {
    constructor : FloatAd,
    calculate : function(){
        var obj_x = this.x,
            obj_y = this.y,
            main_offsetLeft = document.documentElement.scrollLeft||document.body.scrollLeft,
            main_offsetTop = document.documentElement.scrollTop||document.body.scrollTop;
        if(this.main){
            if(this.locate == "left"){
                obj_x = this.main.offsetLeft - this.ad.offsetWidth - this.space;
            }else if(this.locate == "right"){
                obj_x = this.main.offsetLeft + this.main.offsetWidth + this.space;
            }
            if(this.ad.offsetLeft != main_offsetLeft + obj_x){
                var dx = (main_offsetLeft + obj_x - this.ad.offsetLeft)*0.08;
                dx = (dx > 0 ? 1 : -1)*Math.ceil(Math.abs(dx));
                this.ad.style.left = this.ad.offsetLeft + dx + "px";
            }
        }else{
            if(this.locate == "left"){
                this.ad.style.left = obj_x + "px";
            }else if(this.locate == "right"){
                this.ad.style.right = obj_x +"px";
            }
        }
        if(this.ad.offsetTop != main_offsetTop + obj_y){
            var dy = (main_offsetTop + obj_y - this.ad.offsetTop)*0.08;
            dy = (dy > 0 ? 1 : -1)*Math.ceil(Math.abs(dy));
            this.ad.style.top = this.ad.offsetTop + dy + "px";
        }
    }
}

