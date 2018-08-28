package com.ssm.blog.controller;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.Comment;
import com.ssm.blog.entity.User;
import com.ssm.blog.service.CommentService;
import com.ssm.blog.service.UserService;
import com.ssm.blog.utils.TreeNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.Date;
import java.util.List;

@RequestMapping("/comment")
@Controller
public class CommentController {

    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "/submit",method = RequestMethod.POST,consumes = "application/json")
    @ResponseBody
    public ResultSet submitComment(@RequestBody Comment comment){
        //添加评论时间
        Date time = new Date();
        comment.setPublishTime(time);

        ResultSet resultSet = null;

        try {
            commentService.addComment(comment);
            resultSet = new ResultSet(true,ResultEnum.SUCCESS.getStatusCode(),ResultEnum.SUCCESS.getComment());
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }

    @RequestMapping(value = "/list/{articleId}",method = RequestMethod.GET)
    @ResponseBody
    public ResultSet getCommentByArticleId(@PathVariable(value = "articleId") Long articleId){
        ResultSet resultSet = null;

        try {
            List<Comment> comments = commentService.getCommentsByArticleId(articleId);
            TreeNode treeNode = new TreeNode();
            //转换成comment树，便于前端处理
            List commentList = treeNode.toTreeNode(comments);
            //数组倒序，根评论按照评论时间倒排
            Collections.reverse(commentList);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),commentList);
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }
}
