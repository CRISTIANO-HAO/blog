package com.ssm.blog.controller;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.Comment;
import com.ssm.blog.entity.User;
import com.ssm.blog.service.CommentService;
import com.ssm.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@RequestMapping("/")
@Controller
public class CommentController {

    @Autowired
    private CommentService commentService;

    @RequestMapping(value = "comment/submit",method = RequestMethod.POST,consumes = "application/json")
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

}
