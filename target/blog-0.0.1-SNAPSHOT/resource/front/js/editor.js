function editor(selector) {
    /*
    * 初始化评论区富文本编辑器
    *
    * */
    var E = window.wangEditor;
    var editor = new E(selector);
    //配置编辑区域的 z-index
    editor.customConfig.zIndex = 100;
    // 自定义菜单配置
    editor.customConfig.menus = [
        'emoticon',  // 表情
        'code',  // 插入代码
        'quote',  // 引用
        'link',  // 插入链接
        'undo',  // 撤销
        'redo',  // 重复
        'bold',  // 粗体
        'italic',  // 斜体
        'underline',  // 下划线
        'strikeThrough',  // 删除线
        'foreColor',  // 文字颜色
    ];
    // 表情面板可以有多个 tab ，因此要配置成一个数组。数组每个元素代表一个 tab 的配置
    editor.customConfig.emotions = [
        {
            // tab 的标题
            title: '默认',
            // type -> 'emoji' / 'image'
            type: 'image',
            // content -> 数组
            content: [
                {
                    alt: '[坏笑]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/4d/2018new_huaixiao_org.png'
                },
                {
                    alt: '[馋嘴]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/fa/2018new_chanzui_thumb.png'
                },
                {
                    alt: '[笑哭]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/4a/2018new_xiaoku_org.png'
                },
                {
                    alt: '[拜拜]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/fd/2018new_baibai_thumb.png'
                },
                {
                    alt: '[左哼哼]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/43/2018new_zuohengheng_org.png'
                },
                {
                    alt: '[右哼哼]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c1/2018new_youhengheng_org.png'
                },
                {
                    alt: '[怒骂]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/87/2018new_zhouma_org.png'
                },
                {
                    alt: '[顶]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ae/2018new_ding_org.png'
                },
                {
                    alt: '[微笑]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e3/2018new_weixioa02_org.png'
                },
                {
                    alt: '[舔屏]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/3e/2018new_tianping_org.png'
                },
                {
                    alt: '[偷笑]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/71/2018new_touxiao_org.png'
                },
                {
                    alt: '[亲亲]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/2c/2018new_qinqin_org.png'
                },
                {
                    alt: '[太开心]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/1e/2018new_taikaixin_org.png'
                },
                {
                    alt: '[挤眼]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/43/2018new_jiyan_org.png'
                },
                {
                    alt: '[衰]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a2/2018new_shuai_org.png'
                },
                {
                    alt: '[可怜]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/96/2018new_kelian_org.png'
                },
                {
                    alt: '[汗]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/28/2018new_han_org.png'
                },
                {
                    alt: '[花心]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9d/2018new_huaxin_org.png'
                },
                {
                    alt: '[可爱]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/09/2018new_keai_org.png'
                },
                {
                    alt: '[思考]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/30/2018new_sikao_org.png'
                },
                {
                    alt: '[钱]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/a2/2018new_qian_org.png'
                },
                {
                    alt: '[生病]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/3b/2018new_shengbing_org.png'
                },
                {
                    alt: '[困]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/3c/2018new_kun_org.png'
                },
                {
                    alt: '[互粉]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/86/2018new_hufen02_org.png'
                },
                {
                    alt: '[睡]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e2/2018new_shuijiao_org.png'
                },
                {
                    alt: '[问号]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/2a/2018new_wenhao_org.png'
                },
                {
                    alt: '[害羞]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c1/2018new_haixiu_org.png'
                },
                {
                    alt: '[挖鼻屎]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/9a/2018new_wabi_thumb.png'
                },
                {
                    alt: '[悲伤]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/ee/2018new_beishang_org.png'
                },
                {
                    alt: '[哈哈]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/8f/2018new_haha_org.png'
                },
                {
                    alt: '[抓狂]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/17/2018new_zhuakuang_org.png'
                },
                {
                    alt: '[打脸]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/cb/2018new_dalian_org.png'
                },
                {
                    alt: '[傻眼]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/dd/2018new_shayan_org.png'
                },
                {
                    alt: '[晕]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/07/2018new_yun_org.png'
                },
                {
                    alt: '[哼]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/7c/2018new_heng_org.png'
                },
                {
                    alt: '[泪]',
                    src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/6e/2018new_leimu_org.png'
                }
            ]
        },
        {
            // tab 的标题
            title: 'emoji',
            // type -> 'emoji' / 'image'
            type: 'emoji',
            // content -> 数组
            content: ['😀', '😃', '😄', '😁', '😆']
        }
    ]
    editor.create();
    return editor;
};