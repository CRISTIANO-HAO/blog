;(function ($) {
    var utils = function () {};
    utils.prototype = {
        construtor : utils,
        timeFormat:function (timeStamp,fmt) {
            var date = new Date(timeStamp);
            if (!fmt){
                fmt = "yyyy-MM-dd hh:mm:ss";
            }
            var o = {
                "y+": date.getFullYear(), //年份
                "M+": date.getMonth() + 1, //月份
                "d+": date.getDate(), //日
                "h+": date.getHours(), //小时
                "m+": date.getMinutes(), //分
                "s+": date.getSeconds(), //秒
                "q+": Math.floor((date.getMonth() + 3) / 3), //季度
                "S":  date.getMilliseconds() //毫秒
            };

            for (key in o){
                if (new RegExp("("+key+")").test(fmt)){
                    if (key === "y+"){
                        fmt = fmt.replace(new RegExp("(" + key + ")"),o[key].toString().slice(4 - RegExp.$1.length))
                    }else {
                        fmt = fmt.replace(new RegExp("(" + key + ")"),o[key].toString().length === 2 ? o[key] : "0"+o[key])
                    }
                }
            }

            return fmt;
        }
    }
    $.extend({utils: function () {
            return new utils();
        }});
})(jQuery);

var utils = {};
utils.cookie = {
    cookiesObj:{},
    refreshCookies: function () {
        var cookies = document.cookie.split("; ");//这里有个空格
        var cookiesObj = {};
        for (var i = 0;i < cookies.length;i++){
            var index = cookies[i].indexOf("=");
            var name = cookies[i].substring(0,index);
            var value = decodeURIComponent(cookies[i].substring(index + 1));
            cookiesObj[name] = value;
        }
        //存储已经遍历好的cookie对象
        this.cookiesObj = cookiesObj;
    },
    setCookie: function (key,value,expires) {
        var time = new Date().getTime();
        expires = time + (expires || 365)*24*60*60*1000;
        //cookie日期格式需转换UTC
        expires = new Date(expires).toUTCString();
        //cookies只支持ASCII字符，而且不能有逗号，分号；
        document.cookie = key + '=' + encodeURIComponent(value) + ';' + 'expires=' + expires + ";";
        //刷新cookie对象
        this.refreshCookies();
    },
    getCookie: function (key) {
        //判断是否已经存在cookie对象
        if(JSON.stringify(this.cookiesObj)!== "{}"){
            return this.cookiesObj[key] || '';
        }
        //刷新cookie对象
        this.refreshCookies();
        return this.cookiesObj[key] || '';
    }
}