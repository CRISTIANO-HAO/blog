package com.ssm.blog.dao;

import java.util.List;
import java.util.Map;

import com.ssm.blog.dto.Archive;
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
	void addArticle(@Param("article") Article article);

	/*
	* 获取文章列表
	*
	* */
	List<Article> list(@Param("offsetCount") int offsetCount,@Param("pageSize") int pageSize,@Param("searchParam") String searchParam);

	/*
	* 获取文章
	*
	* */
	Article getArticleById(@Param("articleId") Long articleId);

	/*
	* 获取总数量
	*
	* */
	int getTotalCount(@Param("searchParam") String searchParam, @Param("status") Integer status);

	/*
	* 判断是否已经存在相同的文章title
	*
	* */
	int ifExistTitle(@Param("title") String title);

	/*
	* 更新文章
	*
	* */
	void update(@Param("article") Article article);

	/*
	* 获取文章分页列表
	*
	* */
    List<Article> getArticleByPage(@Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);

    /*
    * 获取专栏文章
    *
    * */
    List<Article> getColumnArticleByPage(@Param("column") String column,@Param("pageIndex") Integer pageIndex,@Param("pageSize") Integer pageSize);

    /*
    * 获取搜索文章
    *
    * */
    List<Article> searchArticleByPage(@Param("keyword") String column,@Param("pageIndex") Integer pageIndex,@Param("pageSize") Integer pageSize);

    /*
    * 获取分类文章列表
    *
    * */
    List<Article> getCategoryArticleByPage(@Param("category") String category,@Param("pageIndex") Integer pageIndex,@Param("pageSize") Integer pageSize);

    /*
    * 获取文章归档信息
    *
    * */
    List<Archive> getArticleArchives();

    /*
    * 获取归档文章列表
    *
    * */
    List<Article> getArchivesArticleByPage(@Param("timerange") String timerange,@Param("pageIndex") Integer pageIndex,@Param("pageSize") Integer pageSize);

    /*
    * 获取所有文章的id列表
    *
    * */
    List<Article> getAllArticleIdList();

    /*
    * 获取后台文章管理列表
    *
    * */
    List<Article> getAdminArticleByPage(@Param("offsetCount") Integer offsetCount,@Param("pageSize") Integer pageSize,@Param("searchParam") String searchParam,@Param("status") Integer status);

    /*
    * 删除文章
    * */
    void deleteArticleById(@Param("articleId") Long articleId);
}
