package com.ssm.blog.service.impl;

import com.ssm.blog.dao.ArticleCategoryDao;
import com.ssm.blog.dao.ArticleColumnDao;
import com.ssm.blog.dao.TagDao;
import com.ssm.blog.dto.Archive;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.blog.dao.ArticleDao;
import com.ssm.blog.entity.Article;
import com.ssm.blog.service.ArticleService;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class ArticleServiceImpl implements ArticleService{
	@Autowired
	private ArticleDao articleDao;
	@Autowired
    private TagDao tagDao;
	@Autowired
    private ArticleCategoryDao articleCategoryDao;
	@Autowired
    private ArticleColumnDao articleColumnDao;

	@Override
	public Article getArticleById(Long articleId) {
		Article article = articleDao.getArticleById(articleId);
		return article;
	}

	@Override
	@Transactional
	public void addArticle(Article article) {
		articleDao.addArticle(article);
		articleCategoryDao.addArticleAndCategoryId(article.getCategories(),article.getArticleId());
		articleColumnDao.addArticleAndColumnId(article.getColumns(),article.getArticleId());
		tagDao.addTag(article.getTags(),article.getArticleId());
	}

	@Override
	public List<Article> list(int offsetCount,int pageSize, String searchParam) {
		List<Article> articleList = articleDao.list(offsetCount,pageSize,searchParam);
		return articleList;
	}

	@Override
	public int getTotalCount(String searchParam,Integer status) {
		int totalCount = articleDao.getTotalCount(searchParam,status);
		return totalCount;
	}

    @Override
    public boolean ifExistTitle(String title) {
    	//没有找到相同标题的文章，返回false
	    boolean ifExistTitle = articleDao.ifExistTitle(title) > 0 ? true : false;
        return ifExistTitle;
    }

	@Override
    @Transactional
	public void update(Article article) {
		//更新标签
		tagDao.deleteByArticleId(article.getArticleId());
		tagDao.addTag(article.getTags(),article.getArticleId());
        //更新分类
        articleCategoryDao.deleteByArticleId(article.getArticleId());
        //防止空数组报错
		if (article.getCategories().size() > 0){
            articleCategoryDao.addArticleAndCategoryId(article.getCategories(),article.getArticleId());
        }
		//更新专栏
        articleColumnDao.deleteByArticleId(article.getArticleId());
        //防止空数组报错
        if (article.getColumns().size() > 0){
            articleColumnDao.addArticleAndColumnId(article.getColumns(),article.getArticleId());
        }
		articleDao.update(article);
	}

	@Override
	public List<Article> getArticleByPage(Integer pageIndex, Integer pageSize) {
		List<Article> articleList = articleDao.getArticleByPage(pageIndex,pageSize);
		return articleList;
	}

	@Override
	public List<Article> getColumnArticleByPage(String column, Integer pageIndex, Integer pageSize) {
		List<Article> articleList = articleDao.getColumnArticleByPage(column,pageIndex,pageSize);
		return articleList;
	}

	@Override
	public List<Article> searchArticleByPage(String keyword, Integer pageIndex, Integer pageSize) {
		List<Article> articleList = articleDao.searchArticleByPage(keyword,pageIndex,pageSize);
		return articleList;
	}

	@Override
	public List<Article> getCategoryArticleByPage(String category, Integer pageIndex, Integer pageSize) {
		List<Article> articleList = articleDao.getCategoryArticleByPage(category,pageIndex,pageSize);
		return articleList;
	}

	@Override
	public List getArticleArchives() {
		List<Archive> archives = articleDao.getArticleArchives();
		return archives;
	}

    @Override
    public List<Article> getArchivesArticleByPage(String timerange, Integer pageIndex, Integer pageSize) {
        List<Article> articleList = articleDao.getArchivesArticleByPage(timerange,pageIndex,pageSize);
        return articleList;
    }

	@Override
	public List<Article> getAdminArticleByPage(Integer offsetCount, Integer pageSize, String searchParam, Integer status) {
		List<Article> articleList = articleDao.getAdminArticleByPage(offsetCount, pageSize, searchParam, status);
		return articleList;
	}

	@Override
    @Transactional
	public void deleteArticleById(Long articleId) {
		articleDao.deleteArticleById(articleId);
		articleCategoryDao.deleteByArticleId(articleId);
		articleColumnDao.deleteByArticleId(articleId);
		tagDao.deleteByArticleId(articleId);
	}

	@Override
	public boolean hasPublishTime(long articleId) {
        Date publishTime = articleDao.hasPublishTime(articleId);
		return (publishTime != null);
	}

}
