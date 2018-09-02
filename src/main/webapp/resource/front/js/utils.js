;(function ($) {
    var utils = function () {};
    utils.prototype = {
        construtor : utils,
        timeFormat:function (timeStamp,fmt) {
            var now = new Date().getTime();
            var interval = now - timeStamp
            //按照分钟显示
            if (interval < 60*60*1000){
                var min = Math.abs(Math.floor(interval/(60*1000)));
                return min > 1 ?  min + "分钟前" : "刚刚";
            }else if (interval < 24*60*60*1000){
                return Math.abs(Math.floor(interval/(60*60*1000)) || 1) + "小时前";
            }else if (interval < 30*24*60*60*1000){
                return Math.abs(Math.floor(interval/(24*60*60*1000)) || 1) + "天前";
            }

            //超过三天，按照正常格式显示
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
};

utils.backToTop = function (distance) {
    distance = distance || ((document.body.clientHeight || document.documentElement.clientHeight) + $("#backToTop").position().top );
    //自定义开关，避免频繁操作按钮位移
    var flag = true;
    //监听页面滚动事件
    $(window).scroll(function () {
        //当右侧分类栏的高出置顶按钮时
        if((distance + $("#header").height() - $(window).scrollTop() - $("#backToTop").position().top) < 0){
            if (flag){
                flag = false;
                $("#backToTop").animate({right:"1rem"});
            }
        }else {
            if (!flag){
                flag = true;
                $("#backToTop").animate({right:"-5rem"});
            }
        }
    })
};

/*
   * 回到顶部绑定事件
   * */
$("#backToTop").on("click",function () {
    var timer = null;
    var num = 0;
    clearInterval(timer);
    timer = setInterval(function () {
        var top = document.body.scrollTop || document.documentElement.scrollTop;
        if (top > 0){
            num ++;
            scrollTo(0,top - 5 * num)
        }else {
            clearInterval(timer);
        }
    },10)
});


/*
* 生成文章目录
* */
utils.renderCatalog = {
    init:function (root,container) {
        root = root || "body";
        root = document.getElementsByClassName(root)[0];
        var eleArr = Array.prototype.slice.call(root.querySelectorAll(["h1","h2","h3","h4","h5","h6"]));
        var catalogArr = [];
        var pointer = {index: 0, max: 6};
        var treeArr = this.renderTreeArr(eleArr, catalogArr, pointer);
        //渲染目录
        document.getElementById(container).innerHTML = this.renderTreeHtml(treeArr);
        //绑定目录跳转事件
        this.bindMoveEvent();
    },
    renderTreeArr:function (eleArr, catalogArr, pointer) {
        for (var i = pointer.index; i < eleArr.length; i++) {
            //获取h标签值
            var level = eleArr[i].nodeName.match(/[1-6]/)[0];
            if (level < pointer.max) {
                //重置最大值
                pointer.max = level;
            }
            //当标签层级最高时，放在数组第一层
            if (level === pointer.max) {
                var node = {
                    id: eleArr[i].id,
                    text: eleArr[i].innerText,
                    level: level,
                    child: []
                }
                catalogArr.push(node);
            } else {
                if (catalogArr.length > 0) {
                    //当标签层级不是最高时，从数组第一层的最后一个数据中找到该标签对应的位置
                    this.findCorrectLevel(catalogArr[catalogArr.length - 1]['child'], level, eleArr[i])
                }
            }
        }
        return catalogArr;
    },
    findCorrectLevel:function (childArr, level, ele) {
        if (childArr.length > 0) {
            //当该标签与子数组的层级一致时，添加进该层级
            if (childArr[0].level === level) {
                childArr.push({
                    id: ele.id,
                    text: ele.innerText,
                    level: level,
                    child: []
                });
            } else {
                //层级低与该层级时，迭代往下找到对应的层级为止；
                this.findCorrectLevel(childArr[childArr.length - 1]['child'], level, ele)
            }
        } else {
            //子数组为空时，直接添加进子数组
            childArr.push({
                id: ele.id,
                text: ele.innerText,
                level: level,
                child: []
            });
        }
    },
    renderTreeHtml:function (arr,layer) {
        var str = "";
        var self = this;
        //目录层级，用.进行拼凑
        layer = layer ? layer + "." : "";
        arr.forEach(function (item,index) {
            var title = layer + (index + 1) ;
            str += "<li toId='"+ item.id +"'><span><strong>" + title +"</strong>"+ item.text +"</span>";
            if (item.child.length > 0){
                //当该目录下有子目录，迭代生成子目录
                str += self.renderTreeHtml(item.child,title);
            }
            str += "</li>";
        });
        return "<ul>"+ str +"</ul>";
    },
    bindMoveEvent:function () {
        $("#catalog").on("click","li",function (ev) {
            ev.stopPropagation();
            var id = $(this).attr("toId");
            var endPosition = $("#" + id).position().top - 40;
            var timer = null;
            var step = 30;

            clearInterval(timer);
            timer = setInterval(function () {
                var top = document.body.scrollTop || document.documentElement.scrollTop;
                if (Math.abs(top - endPosition) > step){
                    if (endPosition > top){
                        scrollTo(0,top + step)
                    }else {
                        scrollTo(0,top - step)
                    }
                    step = step + 10;
                }else {
                    scrollTo(0,endPosition);
                    clearInterval(timer);
                }
            },10)
        })
    }
}