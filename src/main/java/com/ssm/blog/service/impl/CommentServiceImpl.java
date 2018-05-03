package com.ssm.blog.service.impl;

import com.ssm.blog.dao.CommentDao;
import com.ssm.blog.entity.Comment;
import com.ssm.blog.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentDao commentDao;

    @Override
    @Transactional
    public List<Comment> getCommentsByArticleId(Long articleId) {
        List<Comment> comments = commentDao.getCommentsByArticleId(articleId);
        return comments;
    }
}
