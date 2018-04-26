package com.ssm.blog.dao;

import java.util.List;
import java.util.Map;

import com.ssm.blog.utils.Page;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.ssm.blog.entity.Article;

@Repository
public interface ArticleDao {
	/*
	* 新增文章
	*
	* */
	void add(@Param("article") Article article);

	/*
	* 获取文章列表
	*
	* */
	List<Article> list(@Param("offsetCount") int offsetCount,@Param("pageSize") int pageSize,@Param("searchParam") String searchParam);

	/*
	* 获取文章
	*
	* */
	Article get(@Param("articleId") Long articleId);

	/*
	* 获取总数量
	*
	* */
	int getTotalCount(@Param("searchParam") String searchParam);

	/*
	* 判断是否已经存在相同的文章title
	*
	* */
	int ifExistTitle(@Param("title") String title);
}
