package com.ssm.blog.dao;

import com.ssm.blog.entity.Category;
import com.ssm.blog.entity.Column;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleColumnDao {

    void deleteByArticleId(@Param("articleId") Long articleId);

    void addArticleAndColumnId(@Param("columns") List<Column> columns, @Param("articleId") Long articleId);

}
