package com.ssm.blog.dao;

import com.ssm.blog.entity.Comment;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentDao {

    List<Comment> getCommentsByArticleId(@Param("articleId") Long articleId);

    void addComment(@Param("comment") Comment comment);
}
