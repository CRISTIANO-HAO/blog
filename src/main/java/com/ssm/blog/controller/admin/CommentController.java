package com.ssm.blog.controller.admin;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.Comment;
import com.ssm.blog.service.CommentService;
import com.ssm.blog.utils.TreeNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("admin/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "/get/{articleId}",method = RequestMethod.GET)
    @ResponseBody
    public ResultSet getCommentByArticleId(@PathVariable(value = "articleId") Long articleId){
        ResultSet resultSet = null;

        try {
            List<Comment> comments = commentService.getCommentsByArticleId(articleId);
            TreeNode treeNode = new TreeNode();
            //转换成comment树，便于前端处理
            List commentList = treeNode.toTreeNode(comments);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),commentList);
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }
}
