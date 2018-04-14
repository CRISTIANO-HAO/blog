//文章表
DROP TABLE IF EXISTS `article`;
CREATE TABLE article (
	articleId bigint NOT NULL PRIMARY KEY,
	saveTime date NOT NULL,
	publishTime date NOT NULL,
	title VARCHAR(100) NOT NULL UNIQUE KEY,
	summaryContent VARCHAR(200),
	markdownContent TEXT,
	htmlContent TEXT
)ENGINE=InnoDB DEFAULT CHARSET = utf8 COMMENT = '文章表';


//标签表
DROP TABLE IF EXISTS `tag`;
CREATE TABLE tag (
	tagId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	tagName VARCHAR(20) NOT NULL UNIQUE KEY COMMENT '标签名'
)ENGINE=InnoDB DEFAULT CHARSET = utf8 COMMENT = '标签表';


//文章标签中间表
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE article_tag(
	tag_id int NOT NULL,
	article_id bigint NOT NULL 
)ENGINE=InnoDB DEFAULT CHARSET = utf8 COMMENT = '文章标签中间表';
//创建联合主键
ALTER TABLE article_tag ADD CONSTRAINT article_tag_pk PRIMARY KEY(tag_id,article_id);
//创建外键
ALTER TABLE `article_tag` ADD CONSTRAINT `fk_article` FOREIGN KEY (`article_id`) REFERENCES `article` (`articleId`);
//创建外键
ALTER TABLE `article_tag` ADD CONSTRAINT `fk_tag` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tagId`);



