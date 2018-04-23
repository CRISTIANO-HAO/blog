package com.ssm.blog.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.entity.Category;
import com.ssm.blog.service.CategoryService;
import com.ssm.blog.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.Article;
import com.ssm.blog.service.ArticleService;



@Controller
@RequestMapping(value = "/admin/article")
public class ArticleController {

    @Autowired
    private ArticleService articleService;
    @Autowired
    private CategoryService categoryService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public ResultSet add(@RequestBody Article article) {
        System.out.println(article.getMarkdownContent());
        long time = new Date().getTime();
        article.setArticleId(time);
        article.setSaveTime(new Date());
        article.setPublishTime(new Date());
        article.setTitle("Java的深入浅出" + Math.random());
        System.out.println(article.getCategories().size());

        Map<String, Object> articleMap = new HashMap<String, Object>();
        articleMap.put("article", article);
        articleMap.put("categorys", article.getCategories());

        ResultSet resultSet;
        try {
            articleService.save(article);
            resultSet = new ResultSet(true, 200, article);
        } catch (Exception e) {
            resultSet = new ResultSet(false, 500, "新增报错！！");
        }
        return resultSet;
    }

    /*
    * contentType = "application/x-www-form-urlencoded"时，@RequestParam / @RequestBody 跟 request.getParameter 可以接收参数，此时data为JSON对象；
    * contentType = "application/json"时， @RequestParam 跟 request.getParameter无法正常接收参数，因为tomcat不会读取请求体数据和进行相应的参数处理的，即不会解析表单数据来放到request parameter map中。；
    *
    * */
    @RequestMapping(value = "/list/page/{pageIndex}",method = {RequestMethod.POST,RequestMethod.GET})
    //@ResponseBody
    public String list(Model model, @PathVariable(value = "pageIndex") Integer pageIndex, @RequestParam(value = "pageSize",required = false,defaultValue = "3") Integer pageSize, @RequestParam(value = "searchParam", required = false,defaultValue = "") String searchParam){
	    //默认页数为第一页
        if (pageIndex == null){
	        pageIndex = 1;
        }

        //获取查询的总数目
        int totalCount = articleService.getTotalCount(searchParam);
        //添加分页查询的信息
        Page page = new Page(pageIndex,pageSize,totalCount);
        //结果集对象
        ResultSet resultSet;
        try {
            List<Article> articleList = articleService.list(page.getOffsetCount(),page.getPageSize(),searchParam);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(), articleList);
        } catch (Exception e) {
            resultSet = new ResultSet(false, ResultEnum.ERROR.getStatusCode(), ResultEnum.ERROR.getComment());
        }
        model.addAttribute("articleList",resultSet.getResult());
        model.addAttribute("page",page);
        model.addAttribute("searchParam",searchParam);
        return "back/index";
    }

    @RequestMapping(value = "/get/{articleId}",method = {RequestMethod.GET})
    public String getArticleById(Model model,@PathVariable(value = "articleId") Long articleId){
        Article article = articleService.getById(articleId);
        List<Category> categories = categoryService.list();
        model.addAttribute("article",article);
        model.addAttribute("categories",categories);
        return "back/articleEdit";
    }
}
