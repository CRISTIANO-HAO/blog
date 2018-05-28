package com.ssm.blog.controller;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.Article;
import com.ssm.blog.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = "/")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    @RequestMapping(value = "article/list",method = RequestMethod.POST)
    @ResponseBody
    public ResultSet getArticleByPage(@RequestParam(value = "pageIndex",required = false,defaultValue = "0") Integer pageIndex,@RequestParam(value = "pageSize",required = false,defaultValue = "10") Integer pageSize){
        ResultSet resultSet = null;
        try {
            List<Article> articleList = articleService.getArticleByPage(pageIndex,pageSize);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),articleList);
        }catch (Exception e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }
}
