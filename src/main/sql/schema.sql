/*文章表*/
DROP TABLE IF EXISTS `article`;
CREATE TABLE article (
	articleId bigint NOT NULL PRIMARY KEY ,
	saveTime TIMESTAMP NOT NULL,
	publishTime DATETIME,
	status INT NOT NULL DEFAULT '0',
	title VARCHAR(100) NOT NULL UNIQUE KEY,
	summaryContent VARCHAR(200),
	markdownContent TEXT,
	htmlContent TEXT
)ENGINE=InnoDB AUTO_INCREMENT = 100 DEFAULT CHARSET = utf8 COMMENT = '文章表';


/*分类表*/
DROP TABLE IF EXISTS `category`;
CREATE TABLE category (
	categoryId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	categoryName VARCHAR(20) NOT NULL UNIQUE KEY COMMENT '标签名'
)ENGINE=InnoDB DEFAULT CHARSET = utf8 COMMENT = '标签表';


/*文章标签中间表*/
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE article_category(
	category_id int NOT NULL,
	article_id bigint NOT NULL 
)ENGINE=InnoDB DEFAULT CHARSET = utf8 COMMENT = '文章标签中间表';
/*创建联合主键*/
ALTER TABLE article_category ADD CONSTRAINT article_category_pk PRIMARY KEY(category_id,article_id);
/*创建外键*/
ALTER TABLE `article_category` ADD CONSTRAINT `fk_article` FOREIGN KEY (`article_id`) REFERENCES `article` (`articleId`);
/*创建外键*/
ALTER TABLE `article_category` ADD CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`categoryId`);


/*标签表*/
DROP TABLE IF EXISTS `tag`;
CREATE TABLE tag(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  tagName VARCHAR(25) NOT NULL ,
  articleId BIGINT NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8 COMMENT = '标签表';


/*评论表*/
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`(
  id INT NOT NULL PRIMARY KEY ,
  pid INT NOT NULL DEFAULT '0',
  content TEXT,
  publishTime DATETIME NOT NULL ,
  agreeNum INT DEFAULT '0',
  disagreeNum INT DEFAULT '0',
  articleId BIGINT NOT NULL,
  userId BIGINT
)ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8 COMMENT = '评论表';

/*用户表*/
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`(
	userId BIGINT NOT NULL PRIMARY KEY ,
	username VARCHAR(25),
	email VARCHAR(25) NOT NULL ,
	userLink VARCHAR(100),
	registerTime TIMESTAMP NOT NULL
)ENGINE = InnoDB CHARSET = utf8 COMMENT = '用户表';



