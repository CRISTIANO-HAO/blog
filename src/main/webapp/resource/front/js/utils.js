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
})(jQuery)