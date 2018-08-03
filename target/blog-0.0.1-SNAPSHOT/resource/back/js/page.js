(function (window) {
    var pagePagination = function (option) {
        var index = option['pageIndex'] ? Number(option['pageIndex']) : 1;
        var num = option['pageNum'] ? Number(option['pageNum']) : 1;
        var target = option['target'];
        var url = option['url'] || "";
        var searchParam = option["searchParam"] ? ("?searchParam=" + option['searchParam']) : "";
        //判断是类还是ID;
        if (target) {
            var isId = target.trim().slice(0, 1) === "#" ? true : false;
            target = target.slice(1);
        }
        if (isId) {
            target = document.getElementById(target);
        } else {
            target = document.getElementsByClassName(target);
        }
        var page = {
            renderPage: function (index, num, target, url, searchParam) {
                if (index > num) {
                    return;
                }
                var html = "";
                //上一页按钮
                if (index == 1) {
                    html += "<li><a>«</a></li>";
                } else {
                    html += "<li><a href=" + url + (index - 1) + searchParam + ">«</a></li>";
                }

                //当页数小于等于6时，按钮全部展示；
                if (num <= 6) {
                    for (var i = 1; i <= num; i++) {
                        html += "<li><a href=" + url + i + searchParam + ">" + i + "</a></li>";
                    }
                } else {
                    //当前页小于等于3时，前面全部展示
                    if (index <= 3) {
                        for (var i = 1; i <= index + 1; i++) {
                            html += "<li><a href=" + url + i + searchParam + ">" + i + "</a></li>";
                        }
                        html += "<li><a >...</a></li>";
                        html += "<li><a href=" + url + num + searchParam + ">" + num + "</a></li>";
                    } else if (index >= num - 2) {//当前页为后面三位时;
                        html += "<li><a href=" + url + 1 + searchParam + ">1</a></li>";
                        html += "<li><a >...</a></li>";
                        for (var i = index - 1; i <= num; i++) {
                            html += "<li><a href=" + url + i + searchParam + ">" + i + "</a></li>";
                        }
                    } else {//当前页处于中间位置；
                        html += "<li><a href=" + url + 1 + searchParam + ">1</a></li>";
                        html += "<li><a >...</a></li>";
                        for (var i = index - 1; i <= index + 1; i++) {
                            html += "<li><a href=" + url + i + searchParam + ">" + i + "</a></li>";
                        }
                        html += "<li><a >...</a></li>";
                        html += "<li><a href=" + url + num + searchParam + ">" + num + "</a></li>";
                    }
                }
                //下一页按钮
                if (index == num) {
                    html += "<li><a>»</a></li>";
                } else {
                    html += "<li><a href=" + url + (index + 1) + searchParam + ">»</a></li>";
                }
                target.innerHTML = "";
                target.innerHTML = html;
                //暂时不需要绑定事件
                //page.addEvent();
                //选中的页数
                page.addActiveClass(target,index);
            },
            addActiveClass: function (target,index) {
                var oli = target.getElementsByTagName("li");
                var len = oli.length;
                for (var i = 1; i< len;i++){
                    if (i == index){
                        oli[i].setAttribute("class","pageActive");
                        break;
                    }
                }
            },
            addEvent: function () {
                target.onclick = function (ev) {
                    var ev = ev || window.event;
                    var targetChild = ev.target || ev.srcElement;
                    indexTemp = targetChild.textContent.trim();
                    //四种点击情况的处理
                    if (indexTemp == "«") {
                        index--;
                    } else if (indexTemp == "»") {
                        index++;
                    } else if (indexTemp == "...") {
                        return;
                    } else {
                        //前面的数字已经被转换为字符串
                        index = Number(indexTemp);
                    }
                    //当index超出边界的时候，不做处理
                    if (index < 1 || index > num) {
                        return;
                    } else {
                        page.renderPage(index, num, target);
                    }
                }
            }
        }

        page.renderPage(index, num, target, url, searchParam);
    }
    return window.pagePagination = pagePagination;
})(window);