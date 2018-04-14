CREATE TABLE `user` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '用户ID',

`nickName` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',

`passWord` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',

`email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',

`company` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司',

`city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市',

`qq` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ',

`name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '姓名',

`address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

`updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',

`phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码',

`remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',

`headImageID` bigint NULL DEFAULT NULL COMMENT '头像ID',

`telPhone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备份电话号',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '用户表';



CREATE TABLE `chat_record` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '用户聊天历史记录ID',

`userID` bigint(32) NOT NULL COMMENT '用户ID',

`messages` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '消息内容',

`type` tinyint NULL DEFAULT NULL COMMENT '发送人 0用户 1客服人员',

`sendTime` datetime NULL DEFAULT NULL COMMENT '发送时间',

`messagesType` int(32) NULL DEFAULT NULL COMMENT '消息类型',

`servicePersonnelID` bigint(32) NOT NULL COMMENT '客服ID',

`publicImageID` bigint(32) NULL DEFAULT NULL COMMENT '图片ID',

`publicVoiceID` bigint(32) NULL DEFAULT NULL COMMENT '音频ID',

`publicVideoID` bigint(32) NULL DEFAULT NULL COMMENT '视频ID',

`publicFileID` bigint(32) NULL DEFAULT NULL COMMENT '文件表ID',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '聊天历史记录表';



CREATE TABLE `user_evaluation` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '用户评价ID',

`userID` bigint(32) NULL DEFAULT NULL COMMENT '用户ID',

`servicePersonnelID` bigint(32) NULL DEFAULT NULL COMMENT '客服外键ID',

`score` int(8) NULL DEFAULT NULL COMMENT '评分',

`content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '评价内容',

`dateTime` datetime NULL DEFAULT NULL COMMENT '时间',

`level` tinyint NULL DEFAULT NULL COMMENT '评级 0很不满意 1较不满意 2一般满意 3满意 4非常满意',

`workOrderID` bigint(32) NULL DEFAULT NULL COMMENT '工单ID',

`state` int(16) NULL DEFAULT NULL COMMENT '评价完成度 0未完成 1完成',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '用户评价表';



CREATE TABLE `user_letter` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '用户留言ID',

`userID` bigint(32) NULL DEFAULT NULL COMMENT '用户ID',

`servicePersonnelID` bigint(32) NULL DEFAULT NULL COMMENT '客服外键ID',

`content` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户留言内容',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '用户留言表';



CREATE TABLE `work` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '工单ID',

`userID` bigint(32) NOT NULL COMMENT '用户ID',

`slaType` tinyint NULL DEFAULT NULL COMMENT 'SLA级别 0无响应 1隔天响应 2 5*8小时响应 3 7*24小时响应 4及时响应',

`category` int(32) NULL DEFAULT NULL COMMENT '工单分类 一级 二级 三级 四级  五级',

`title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工单标题',

`problemDescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问题描述',

`priority` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '优先级',

`state` int(10) NULL DEFAULT NULL COMMENT '状态 1尚未处理 2受理中 3等待回复 4已解决 5已关闭',

`processingBeginTime` timestamp NULL DEFAULT NULL COMMENT '处理时效',

`processeEndTime` timestamp NULL DEFAULT NULL COMMENT '处理时效结束时间',

`creator` bigint NULL DEFAULT NULL COMMENT '创建人(客服ID)',

`serviceGroupID` bigint NULL DEFAULT NULL COMMENT '受理客服组',

`serviceID` bigint NULL DEFAULT NULL COMMENT '受理客服',

`
createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

`updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',

`workTemplateID` bigint(32) NULL DEFAULT NULL,

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '工单表';



CREATE TABLE `service_personnel` (

`ID` bigint(32) NOT NULL COMMENT '客服ID',

`email` bigint(255) NULL DEFAULT NULL COMMENT '客服邮箱',

`type` tinyint NULL DEFAULT NULL COMMENT '客服类型  0机器人客服 1人工客服 ',

`nickName` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '昵称',

`serviceGroupID` bigint(32) NULL DEFAULT NULL COMMENT '客服组ID',

`number` bigint(64) NULL DEFAULT NULL COMMENT '工号',

`QQ` bigint(32) NULL DEFAULT NULL COMMENT 'QQ',

`level` tinyint NULL DEFAULT NULL COMMENT '客服级别 0普通 1中级 2高级 ',

`personalKnowledgeID` bigint(32) NULL DEFAULT NULL COMMENT '个人知识库外键ID',

`userID` bigint(32) NULL DEFAULT NULL COMMENT '用户ID',

`sysUserID` bigint(32) NULL DEFAULT NULL COMMENT '登陆用户ID',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '客服表';



CREATE TABLE `technical` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '技能名称',

`desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '技能描述',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

`updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '技能表';



CREATE TABLE `service_technical_map` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '客服关系主键',

`servicePersonnelID` bigint(32) NULL DEFAULT NULL COMMENT '客服表ID',

`technicalID` bigint(32) NULL DEFAULT NULL COMMENT '技能ID',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '客服关系表';



CREATE TABLE `notice` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`number` bigint(64) NULL DEFAULT NULL COMMENT '公告编号',

`title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告主题',

`content` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公告内容',

`createTime` datetime NULL DEFAULT NULL COMMENT '发布时间',

`creatorID` bigint(32) NULL DEFAULT NULL COMMENT '创建人',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '公告通知表';



CREATE TABLE `service_check` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`serviceManagerID` bigint(32) NULL DEFAULT NULL COMMENT '客服经理ID',

`servicePersonnelID` bigint(32) NULL DEFAULT NULL COMMENT '客服表ID',

`score` int(8) NULL DEFAULT NULL COMMENT '分数',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '服务质检';



CREATE TABLE `work_template` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板名称',

`content` varchar(1024) NULL,

`type` tinyint(8) NULL DEFAULT NULL COMMENT '模板类型',

`remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板内容',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '工单模板';



CREATE TABLE `work_record` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`workID` bigint(32) NULL DEFAULT NULL COMMENT '工单ID',

`beginTime` timestamp NULL DEFAULT NULL COMMENT '首次响应时间',

`endTime` timestamp NULL DEFAULT NULL COMMENT '首次解决时间',

`operateType` tinyint NULL DEFAULT NULL COMMENT '操作类型',

`serviceID` bigint(32) NULL DEFAULT NULL COMMENT '相关客户 ',

`remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交流内容',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '工单记录表';



CREATE TABLE `public_voice` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '语音表ID',

`userQuestionID` bigint(32) NULL DEFAULT NULL COMMENT '用户问题ID',

`URL` varchar(1024) NULL DEFAULT NULL COMMENT '音频地址',

`HASH` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'hash码',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '音频表';



CREATE TABLE `public_image` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`URL` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

`HASH` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片hash码',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '图片表';



CREATE TABLE `public_video` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`URL` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'url地址',

`HASH` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片hash码',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '视频表';



CREATE TABLE `knowledge_question` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`personalKnowledgeID` bigint(32) NULL DEFAULT NULL COMMENT '个人知识库ID',

`name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '知识名称',

`serviceType` tinyint NULL DEFAULT NULL COMMENT '知识类型 1单轮  2多轮  3业务 ',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

`updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',

`validBeginTime` timestamp NULL DEFAULT NULL COMMENT '起始时间',

`validendTime` timestamp NULL DEFAULT NULL COMMENT '有效结束时间',

`isForeverValid` tinyint NULL DEFAULT 1 COMMENT '是否永久有效  0不是   1是',

`isStartUp` tinyint NULL DEFAULT 1 COMMENT '是否启用 0不启用  1启用',

`openLever` tinyint NULL COMMENT '开放级别 0外部开放 1内部开放 2保密 3绝密',

`replyType` tinyint NULL DEFAULT NULL COMMENT '回复类型 0寒暄  1常用 ....',

PRIMARY KEY (`ID`, `isStartUp`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '知识问题 知识库';



CREATE TABLE `once_question` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`knowledgeQuestionID` bigint(32) NULL DEFAULT NULL COMMENT '知识库ID',

`standardQuestion` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '标准问法',

`standardAnswer` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '标准答案',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '单轮问题';



CREATE TABLE `question_method` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`Qmethod` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '问法',

`onceQuestionID` bigint(32) NULL DEFAULT NULL COMMENT '单轮问题ID',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '问法表';



CREATE TABLE `sensitive_word` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '敏感词  多个过滤词请用;隔开',

`enabled` int(10) NULL DEFAULT NULL COMMENT '是否启用 1是 2否',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

`updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '敏感词表';



CREATE TABLE `service_group` (

`ID` bigint(32) NOT NULL COMMENT 'ID',

`name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客服组名',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '客服组表';



CREATE TABLE `service_personnel_group_map` (

`ID` bigint(32) NOT NULL COMMENT 'ID',

`servicePersonnelID` bigint(32) NULL DEFAULT NULL COMMENT '客服表ID',

`serviceGroupID` bigint(32) NULL DEFAULT NULL COMMENT '客服组ID',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '客服与客服组关系表';



CREATE TABLE `notice_receiver` (

`ID` bigint(32) NOT NULL COMMENT 'ID',

`noticeID` bigint(32) NULL DEFAULT NULL COMMENT '公告ID',

`receiverID` bigint(32) NULL DEFAULT NULL COMMENT '接收人',

`serviceGroupID` bigint(32) NULL DEFAULT NULL COMMENT '组',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '公告接收表';



CREATE TABLE `public_file` (

`ID` bigint(32) NOT NULL COMMENT 'ID',

`URL` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'url',

`HASH` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'hash码',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci;



CREATE TABLE `key_word` (

`ID` bigint(32) NOT NULL COMMENT '关键字ID',

`name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键字名称',

`remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '关键字表';



CREATE TABLE `question_keyword_map` (

`ID` bigint(32) NOT NULL COMMENT 'ID',

`knowledgeQuestionID` bigint(32) NULL DEFAULT NULL COMMENT '知识库ID',

`keyWordID` bigint(32) NULL DEFAULT NULL COMMENT '关键字ID',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '关键字表与问题表关联表';



CREATE TABLE `sys_interface_log` (

`ID` bigint(32) NOT NULL COMMENT 'ID',

`action` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '动作',

`createTime` datetime NULL DEFAULT NULL COMMENT '日志时间',

`createTimeBegin` datetime NULL DEFAULT NULL COMMENT '日志开始时间',

`createTimeEnd` datetime NULL DEFAULT NULL COMMENT '日志结束时间',

`interfaceName` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员名称',

`interfaceType` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型',

`moduleName` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块名',

`sendID` int(11) NULL DEFAULT NULL COMMENT '操作员ID',

`sendIP` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员IP地址',

`receiveID` int(11) NULL DEFAULT NULL,

`receiveIP` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

AUTO_INCREMENT = 0

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;



CREATE TABLE `sys_interface_log_content` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT,

`logID` bigint(32) NOT NULL,

`content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,

PRIMARY KEY (`ID`) ,

INDEX `sys_interface_log_content_fk1` (`logID` ASC) USING BTREE

)

ENGINE = InnoDB

AUTO_INCREMENT = 1

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;



CREATE TABLE `sys_dict_head` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT,

`name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

AUTO_INCREMENT = 2

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;



CREATE TABLE `sys_dictionary` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',

`description` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',

`dictHeadID` bigint(20) NOT NULL COMMENT '字典字段',

`dictKey` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'KEY',

`dictValue` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值',

`updateTime` datetime NULL DEFAULT NULL COMMENT '更新时间',

PRIMARY KEY (`ID`) ,

INDEX `fk_sys_dictionary` (`dictHeadID` ASC) USING BTREE

)

ENGINE = InnoDB

AUTO_INCREMENT = 15

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;



CREATE TABLE `sys_operation_log` (

`ID` bigint(20) NOT NULL COMMENT 'ID',

`action` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '动作',

`createTime` datetime NULL DEFAULT NULL COMMENT '日志时间',

`createTimeBegin` datetime NULL DEFAULT NULL COMMENT '日志开始时间',

`createTimeEnd` datetime NULL DEFAULT NULL COMMENT '日志结束时间',

`moduleName` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模块名',

`operatorID` bigint(20) NULL DEFAULT NULL COMMENT '操作员ID',

`operatorIP` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员IP地址',

`operatorName` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作员名称',

`operatorType` smallint(1) NULL DEFAULT NULL COMMENT '操作类型:0为系统操作日志，1为业务操作日志',

PRIMARY KEY (`ID`) ,

INDEX `sys_operation_log_fk1` (`operatorID` ASC) USING BTREE

)

ENGINE = InnoDB

AUTO_INCREMENT = 0

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;



CREATE TABLE `sys_operation_log_content` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT,

`logID` bigint(32) NOT NULL,

`content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,

PRIMARY KEY (`ID`) ,

INDEX `sys_operation_log_content_fk1` (`logID` ASC) USING BTREE

)

ENGINE = InnoDB

AUTO_INCREMENT = 1

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;



CREATE TABLE `sys_user` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`loginName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录名',

`passWord` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',

`name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',

`address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',

`phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,

`email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'email',

`locked` smallint(1) NOT NULL COMMENT '是否锁定',

`manager` smallint(1) NOT NULL,

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

AUTO_INCREMENT = 6095768066935708

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

COMMENT = '登陆用户'

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;



CREATE TABLE `sys_relate` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT,

`objectID` bigint(32) NULL DEFAULT NULL COMMENT '被关联对象',

`relatedID` bigint(32) NULL DEFAULT NULL COMMENT '关联对象',

`typeID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联类型（0user_role,1orgin_role,2role_resource)',

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

AUTO_INCREMENT = 9442497269562209

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;



CREATE TABLE `sys_resource` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT,

`action` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'STRUCTS-ACTION',

`code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源代码',

`parentID` bigint(20) NULL DEFAULT NULL COMMENT '父ID',

`rank` int NULL DEFAULT NULL,

`noAuth` decimal(10,0) NULL DEFAULT NULL COMMENT '不用认证',

`name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

AUTO_INCREMENT = 28

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;



CREATE TABLE `sys_role` (

`ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',

`name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,

`remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,

PRIMARY KEY (`ID`) 

)

ENGINE = InnoDB

AUTO_INCREMENT = 8465755852133711

AVG_ROW_LENGTH = 0

DEFAULT CHARACTER SET = utf8

COLLATE = utf8_general_ci

KEY_BLOCK_SIZE = 0

MAX_ROWS = 0

MIN_ROWS = 0

ROW_FORMAT = Compact;





ALTER TABLE `chat_record` ADD CONSTRAINT `fk_user_history_user_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `user_evaluation` ADD CONSTRAINT `fk_user_evaluation_user_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `user_letter` ADD CONSTRAINT `fk_user_message_user_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `user_evaluation` ADD CONSTRAINT `fk_user_evaluation_service_1` FOREIGN KEY (`servicePersonnelID`) REFERENCES `service_personnel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `user_letter` ADD CONSTRAINT `fk_user_message_service_1` FOREIGN KEY (`servicePersonnelID`) REFERENCES `service_personnel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `service_technical_map` ADD CONSTRAINT `fk_service_relation_service_personnel_1` FOREIGN KEY (`servicePersonnelID`) REFERENCES `service_personnel` (`ID`);

ALTER TABLE `service_technical_map` ADD CONSTRAINT `fk_service_relation_technical_1` FOREIGN KEY (`technicalID`) REFERENCES `technical` (`ID`);

ALTER TABLE `service_personnel_group_map` ADD CONSTRAINT `fk_service_personnel_group_relation_service_group_1` FOREIGN KEY (`serviceGroupID`) REFERENCES `service_group` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `service_personnel_group_map` ADD CONSTRAINT `fk_service_personnel_group_relation_service_personnel_1` FOREIGN KEY (`servicePersonnelID`) REFERENCES `service_personnel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `service_check` ADD CONSTRAINT `fk_service_check_service_personnel_1` FOREIGN KEY (`serviceManagerID`) REFERENCES `service_personnel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `service_check` ADD CONSTRAINT `fk_service_check_service_personnel_2` FOREIGN KEY (`servicePersonnelID`) REFERENCES `service_personnel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `knowledge_question` ADD CONSTRAINT `fk_knowledge_question_once_question_1` FOREIGN KEY (`ID`) REFERENCES `once_question` (`knowledgeQuestionID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `once_question` ADD CONSTRAINT `fk_once_question_question_method_1` FOREIGN KEY (`ID`) REFERENCES `question_method` (`onceQuestionID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `notice` ADD CONSTRAINT `fk_notice_service_personnel_1` FOREIGN KEY (`creatorID`) REFERENCES `service_personnel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `service_personnel` ADD CONSTRAINT `fk_service_personnel_user_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `work` ADD CONSTRAINT `fk_work_work_record_1` FOREIGN KEY (`ID`) REFERENCES `work_record` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `work` ADD CONSTRAINT `fk_work_user_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `work_template` ADD CONSTRAINT `fk_work_template_work_1` FOREIGN KEY (`ID`) REFERENCES `work` (`workTemplateID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `work` ADD CONSTRAINT `fk_work_service_group_1` FOREIGN KEY (`serviceGroupID`) REFERENCES `service_group` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `work` ADD CONSTRAINT `fk_work_service_personnel` FOREIGN KEY (`serviceID`) REFERENCES `service_personnel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `knowledge_question` ADD CONSTRAINT `fk_knowledge_question_service_personnel_1` FOREIGN KEY (`personalKnowledgeID`) REFERENCES `service_personnel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `key_word` ADD CONSTRAINT `fk_key_word_question_keyword_map_1` FOREIGN KEY (`ID`) REFERENCES `question_keyword_map` (`keyWordID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `once_question` ADD CONSTRAINT `fk_once_question_question_keyword_map_1` FOREIGN KEY (`ID`) REFERENCES `question_keyword_map` (`knowledgeQuestionID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `notice_receiver` ADD CONSTRAINT `fk_notice_receiver_notice_receiver_1` FOREIGN KEY (`serviceGroupID`) REFERENCES `notice_receiver` (`serviceGroupID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `notice_receiver` ADD CONSTRAINT `fk_notice_receiver_service_personnel_1` FOREIGN KEY (`receiverID`) REFERENCES `service_personnel` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `notice_receiver` ADD CONSTRAINT `fk_notice_receiver_notice_1` FOREIGN KEY (`noticeID`) REFERENCES `notice` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `notice_receiver` ADD CONSTRAINT `fk_notice_receiver_service_group_1` FOREIGN KEY (`serviceGroupID`) REFERENCES `service_group` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `sys_interface_log_content` ADD CONSTRAINT `sys_interface_log_content_fk1` FOREIGN KEY (`logID`) REFERENCES `sys_interface_log` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `sys_dictionary` ADD CONSTRAINT `fk_sys_dictionary` FOREIGN KEY (`dictHeadID`) REFERENCES `sys_dict_head` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `sys_operation_log_content` ADD CONSTRAINT `sys_operation_log_content_fk1` FOREIGN KEY (`logID`) REFERENCES `sys_operation_log` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `sys_operation_log` ADD CONSTRAINT `fk_sys_operation_log_sys_user_1` FOREIGN KEY (`operatorID`) REFERENCES `sys_user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `service_personnel` ADD CONSTRAINT `fk_service_personnel_sys_user_1` FOREIGN KEY (`sysUserID`) REFERENCES `sys_user` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT;



