(function ($) {
    //把jQuery系列化表单转换为JSON,扩展方法
    $.fn.serializeJSON = function () {
        var obj = {};
        //获取表单序列化数组
        var arr = this.serializeArray();
        
        $(arr).each(function (index,el) {
            //存在不止一个相同属性的数据时
            if (obj[el['name']] !== undefined){
                //判断属性值是否为数组
                if ($.isArray(obj[el['name']])){
                    obj[el['name']].push(el['value']);
                }else {
                    //是第一个值时，以数组形式接收第二个值
                    obj[el['name']] = [obj[el['name']],el['value']];
                }
            }else {
                obj[el['name']] = el['value'];
            }
        });
        return obj;
    }
})(jQuery)