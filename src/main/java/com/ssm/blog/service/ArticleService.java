package com.ssm.blog.service;

import java.util.List;
import java.util.Map;

import com.ssm.blog.dto.Archive;
import com.ssm.blog.entity.Article;
import com.ssm.blog.utils.Page;

public interface ArticleService {

	void addArticle(Article article);

	Article getArticleById(Long articleId);

	List<Article> list(int offsetCount,int pageSize,String searchParam);

	int getTotalCount(String searchParam,Integer status);

	boolean ifExistTitle(String title);

	void update(Article article);

	List<Article> getArticleByPage(Integer pageIndex, Integer pageSize);

    List<Article> getColumnArticleByPage(String column, Integer pageIndex, Integer pageSize);

    List<Article> searchArticleByPage(String keyword, Integer pageIndex, Integer pageSize);

    List<Article> getCategoryArticleByPage(String category, Integer pageIndex, Integer pageSize);

    List<Archive> getArticleArchives();

	List<Article> getArchivesArticleByPage(String timerange, Integer pageIndex, Integer pageSize);

	List<Article> getAdminArticleByPage(Integer offsetCount, Integer pageSize, String searchParam, Integer status);

    void deleteArticleById(Long articleId);

	boolean hasPublishTime(long articleId);
}
