
var arr = [{
    id: 1,
    pid: 0,
    value: "a"
}, {
    id: 2,
    pid: 0,
    value: "b"
}, {
    id: 3,
    pid: 0,
    value: "c"
}, {
    id: 4,
    pid: 1,
    value: "aa"
}, {
    id: 5,
    pid: 1,
    value: "aa"
}, {
    id: 6,
    pid: 4,
    value: "aaa"
}, {
    id: 7,
    pid: 5,
    value: "aaa"
}, {
    id: 13,
    pid: 7,
    value: "aaaa"
}, {
    id: 14,
    pid: 7,
    value: "aaaa"
}, {
    id: 15,
    pid: 13,
    value: "aaaaa"
}, {
    id: 16,
    pid: 14,
    value: "aaaaa"
}, {
    id: 17,
    pid: 15,
    value: "aaaaaa"
}, {
    id: 8,
    pid: 2,
    value: "bb"
}, {
    id: 9,
    pid: 2,
    value: "bb"
}, {
    id: 10,
    pid: 3,
    value: "cc"
}, {
    id: 11,
    pid: 3,
    value: "cc"
}, {
    id: 12,
    pid: 11,
    value: "ccc"
}
];

var result = [];
function iteration(arr,result) {
    if (result.length === 0 ){
        for (var i = 0; i < arr.length; i++){
            if (arr[i]["pid"] === 0){
                result.push(arr[i]);
            }
        }
        for (var i = 0; i < result.length; i++){
            result[i]["children"] = [];
            for (var j = 0; j < arr.length; j++){
                if(arr[j]["pid"] === result[i]["id"]){
                    result[i]["children"].push(arr[j]);
                }
            }
            if (result[i]["children"].length > 0){
                iteration(arr,result[i]["children"]);
            }
        }
    }else {
        for (var i = 0; i < result.length; i++){
            result[i]["children"] = [];
            for (var j = 0; j < arr.length; j++){
                if(arr[j]["pid"] === result[i]["id"]){
                    result[i]["children"].push(arr[j]);
                }
            }
            if (result[i]["children"].length > 0){
                iteration(arr,result[i]["children"]);
            }
        }
    }
    return result;
}

arr = iteration(arr,result);
console.log(arr);


function addStr(obj) {
    var str = "";
    var replyStr = {strItem : "",odd:1} ;
    str += '<div class="comment-item">'
        + '<div class="user-profile">'
        + '<a>'
        + '<img src="<%=basePath %>resource/back/img/visitor.jpg">'
        + '</a>'
        + '</div>'
        + '<div class="comment-main">'
        + '<div class="comment-msg clear">'
        + '<div class="agree-disagree right">'
        + '<i class="fa fa-thumbs-up">(10)</i>'
        + '<i class="fa fa-thumbs-down">(0)</i>'
        + '<span class="reply-comment">回复</span>'
        + '</div>'
        + '<div class="user-msg">'
        + '<a class="user-name" href="/admin">早起不吃虫</a>'
        + '<span class="comment-time">2018-05-01 18:17:30</span>'
        + '</div>'
        + '</div>'
        + '<div class="comment-content">'
        + '<p>'+ obj["value"]+'</p>'
        + '</div>';
    replyStr = replyHtml(obj["children"],replyStr);
    str += replyStr.strItem;
    str += "</div></div>";
    return str;
}
function replyHtml(arr,replyStr) {
    for (var i = 0;i < arr.length; i++){
        replyStr.strItem += (replyStr.odd % 2 === 0 ? '<div class="reply-application evenClass">\n' : '<div class="reply-application">\n') +
            '                        <div class="comment-msg clear">\n' +
            '                            <div class="agree-disagree right">\n' +
            '                                <i class="fa fa-thumbs-up">(10)</i>\n' +
            '                                <i class="fa fa-thumbs-down">(0)</i>\n' +
            '                                <span class="reply-comment">回复</span>\n' +
            '                            </div>\n' +
            '                            <div class="user-msg">\n' +
            '                                <a class="user-name" href="/admin">早起不吃虫</a>\n' +
            '                                <span class="comment-time">2018-05-01 18:17:30</span>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                        <div class="comment-content">\n' +
            '                            <p>'+ arr[i]["value"]+'</p>\n' +
            '                        </div>';
        if (arr[i]["children"].length > 0){
            replyStr.odd ++;
            replyHtml(arr[i]["children"],replyStr);
            replyStr.strItem += "</div>";
        }else {
            replyStr.strItem += "</div>";
        }
    }
    return replyStr;
}
var str = "";
arr.forEach(function (value, index) {
    str += addStr(value);
})
//console.log(str)
document.getElementById("commentTree").innerHTML = str;
