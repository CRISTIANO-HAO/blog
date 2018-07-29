package com.ssm.blog.controller;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.Article;
import com.ssm.blog.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping(value = "/")
public class ArticleController {

    @Autowired
    private ArticleService articleService;

    /*
    * 文章总列表
    * */
    @RequestMapping(value = "article/list",method = RequestMethod.POST)
    @ResponseBody
    public ResultSet getArticleByPage(@RequestParam(value = "pageIndex",required = false,defaultValue = "0") Integer pageIndex, @RequestParam(value = "pageSize",required = false,defaultValue = "10") Integer pageSize){
        ResultSet resultSet = null;
        try {
            List<Article> articleList = articleService.getArticleByPage(pageIndex,pageSize);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),articleList);
        }catch (Exception e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }

    /*
    * 文章专栏列表
    * */
    @ResponseBody
    @RequestMapping(value = "article/column/{column}",method = RequestMethod.POST)
    public ResultSet getColumnArticleByPage(@PathVariable(value = "column") String column,@RequestParam(value = "pageIndex",required = false,defaultValue = "0") Integer pageIndex,@RequestParam(value = "pageSize",required = false,defaultValue = "10") Integer pageSize){
        ResultSet resultSet = null;

        try {
            List<Article> articleList = articleService.getColumnArticleByPage(column,pageIndex,pageSize);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),articleList);
        }catch (Exception e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }

        return resultSet;
    }

    /*
    * 文章搜索列表
    * */
    @ResponseBody
    @RequestMapping(value = "article/search/{keyword}",method = RequestMethod.POST)
    public ResultSet searchArticleByPage(@PathVariable(value = "keyword") String keyword,@RequestParam(value = "pageIndex",required = false,defaultValue = "0") Integer pageIndex,@RequestParam(value = "pageSize",required = false,defaultValue = "10") Integer pageSize){
        ResultSet resultSet = null;

        try {
            List<Article> articleList = articleService.searchArticleByPage(keyword,pageIndex,pageSize);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),articleList);
        }catch (Exception e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }

        return resultSet;
    }

    /*
    * 文章详情
    * */
    @RequestMapping(value = "article/{articleId}",method = RequestMethod.GET)
    public String getArticleById(@PathVariable("articleId") Long articleId, Model model){
        Article article = articleService.getArticleById(articleId);
        model.addAttribute("article",article);
        return "front/article";
    }

    /*
    * 文章分类列表
    * */
    @ResponseBody
    @RequestMapping(value = "article/category/{category}",method = RequestMethod.POST)
    public ResultSet getCategoryArticleByPage(@PathVariable("category") String category,@RequestParam(value = "pageIndex",required = false,defaultValue = "0") Integer pageIndex,@RequestParam(value = "pageSize",required = false,defaultValue = "10") Integer pageSize){
        ResultSet resultSet = null;

        try {
            List<Article> articleList = articleService.getCategoryArticleByPage(category,pageIndex,pageSize);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),articleList);
        }catch (Exception e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }

        return resultSet;
    }

    /*
     * 文章归档列表
     * */
    @ResponseBody
    @RequestMapping(value = "article/archives/{timerange}",method = RequestMethod.POST)
    public ResultSet getArchivesArticleByPage(@PathVariable("timerange") String timerange,@RequestParam(value = "pageIndex",required = false,defaultValue = "0") Integer pageIndex,@RequestParam(value = "pageSize",required = false,defaultValue = "10") Integer pageSize){
        ResultSet resultSet = null;

        try {
            List<Article> articleList = articleService.getArchivesArticleByPage(timerange,pageIndex,pageSize);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),articleList);
        }catch (Exception e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }

        return resultSet;
    }
}
