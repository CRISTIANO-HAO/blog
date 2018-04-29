package com.ssm.blog.dao;

import com.ssm.blog.entity.Tag;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TagDao {

    void deleteByArticleId(@Param("articleId") Long articleId);

    void addTag(@Param("tags") List<Tag> tags, @Param("articleId") Long articleId);
}
