package com.ssm.blog.dao;

import com.ssm.blog.entity.Category;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleCategoryDao {

    void deleteByArticleId(@Param("articleId") Long articleId);

    void addArticleAndCategoryId (@Param("categories")List<Category> categories,@Param("articleId") Long articleId);

}
