package com.ssm.blog.service.impl;

import com.ssm.blog.dao.ArticleDao;
import com.ssm.blog.dao.CommentDao;
import com.ssm.blog.dao.UserDao;
import com.ssm.blog.entity.Article;
import com.ssm.blog.entity.Comment;
import com.ssm.blog.entity.User;
import com.ssm.blog.service.CommentService;
import com.ssm.blog.service.UserService;
import com.ssm.blog.utils.Email;
import com.ssm.blog.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentDao commentDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private ArticleDao articleDao;

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
        List<User> userList = userDao.findUserByEmail(comment.getEmail());
        Date time = comment.getPublishTime();
        //没有存在该用户，新增用户
        if (userList.size() == 0){
            User user = new User();
            user.setUsername(comment.getUsername());
            user.setEmail(comment.getEmail());
            user.setRegisterTime(time);
            user.setWebsite(comment.getWebsite());
            user.setUserId(time.getTime());
            userDao.addUser(user);
            //添加评论的用户id
            comment.setUserId(time.getTime());
        }else {
            //添加评论用户id，存在多条时，只取一条（不会存在多条）
            comment.setUserId(userList.get(0).getUserId());
            //更新评论表的用户名
            commentDao.updateUsername(userList.get(0).getUserId(),comment.getUsername());
            userDao.updateUsername(userList.get(0).getUserId(),comment.getUsername());
        }
        //添加评论到数据库
        commentDao.addComment(comment);

        //当评论不是根评论时，给父评论发送提醒邮件
        if (comment.getPid() != 0){
            Comment pComment = commentDao.getCommentById(comment.getPid());
            Article article = articleDao.getArticleById(comment.getArticleId());

            User pUser = null;
            if (pComment.getUserId() != null){
                pUser = userDao.getUserById(pComment.getUserId());
            }else {
                return;
            }
            //如果用户拒绝接收回复提醒邮件，直接返回
            if (pUser.getRefuseEmail()){
                return;
            }else {
                //邮件内容拼凑
                String emailContent = "";
                emailContent += "<h2>来自文章 -- 》》》"+ article.getTitle() +"</h>"
                        + "<p>" + comment.getContent() +"</p>"
                        + "<p>  -- 评论来自 -- " + comment.getUsername() +"</p>"
                        + "<div><button><a target='_blank' href='http://codedoges.com/article/" + article.getArticleId() +"#comment'>回复</a></button></div>";

                //发送回复提醒邮件
                try {
                    Email.sendSimpleEmail(emailContent,pUser.getEmail());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }else {
            Article article = articleDao.getArticleById(comment.getArticleId());
            //邮件内容拼凑
            String emailContent = "";
            emailContent += "<h2>来自文章 -- 》》》"+ article.getTitle() +"</h>"
                    + "<p>" + comment.getContent() +"</p>"
                    + "<p>  -- 评论来自 -- " + comment.getUsername() +"</p>"
                    + "<div><button><a target='_blank' href='http://codedoges.com/article/" + article.getArticleId() +"#comment'>回复</a></button></div>";

            //发送回复提醒邮件
            try {
                Email.sendSimpleEmail(emailContent,"2415156870@qq.com");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public List<com.ssm.blog.dto.Comment> getLatestComments() {
        List<com.ssm.blog.dto.Comment> commentList = commentDao.getLatestComments();
        if (commentList.size() > 0){
            for (int i = 0; i < commentList.size(); i++) {
                String content = commentList.get(i).getContent();
                //把HTML转换为纯文本
                commentList.get(i).setContent(Utils.HtmlToString(content));
                commentList.set(i,commentList.get(i));
            }
        }
        return commentList;
    }

}