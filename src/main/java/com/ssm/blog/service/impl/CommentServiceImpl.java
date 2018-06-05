package com.ssm.blog.service.impl;

import com.ssm.blog.dao.CommentDao;
import com.ssm.blog.entity.Comment;
import com.ssm.blog.entity.User;
import com.ssm.blog.service.CommentService;
import com.ssm.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentDao commentDao;
    @Autowired
    private UserService userService;

    @Override
    @Transactional
    public List<Comment> getCommentsByArticleId(Long articleId) {
        List<Comment> comments = commentDao.getCommentsByArticleId(articleId);
        return comments;
    }

    @Override
    @Transactional
    public void addComment(Comment comment) {
        //通过查找邮箱是否已经存在用户
        List<User> userList = userService.findUserByEmail(comment.getEmail());
        Date time = comment.getPublishTime();
        //没有存在该用户，新增用户
        if (userList.size() == 0){
            User user = new User();
            user.setUsername(comment.getUsername());
            user.setEmail(comment.getEmail());
            user.setRegisterTime(time);
            user.setWebsite(comment.getWebsite());
            user.setUserId(time.getTime());
            userService.addUser(user);
            //添加评论的用户id
            comment.setUserId(time.getTime());
        }else {
            //添加评论用户id，存在多条时，只取一条（不会存在多条）
            comment.setUserId(userList.get(0).getUserId());
        }
        commentDao.addComment(comment);
    }
}