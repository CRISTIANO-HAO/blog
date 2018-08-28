package com.ssm.blog.service;

import com.ssm.blog.entity.Comment;

import java.util.List;

public interface CommentService {

    List<Comment> getCommentsByArticleId(Long articleId);

    void addComment(Comment comment);

    List<com.ssm.blog.dto.Comment> getLatestComments();
}
