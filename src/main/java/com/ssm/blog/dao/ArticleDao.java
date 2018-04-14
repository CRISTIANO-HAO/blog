package com.ssm.blog.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ssm.blog.entity.Article;

@Repository
public interface ArticleDao {
	
	void save(@Param("article") Article article);
}
