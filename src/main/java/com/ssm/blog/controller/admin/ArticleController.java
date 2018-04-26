package com.ssm.blog.controller.admin;

import java.sql.Timestamp;
import java.util.*;

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

    /*
    * 跳转添加博客页面
    *
    * */
    @RequestMapping(value = "/articleAdd")
    public String articleAdd(Model model){
        List<Category> categories = categoryService.list();
        model.addAttribute("categories",categories);
        return "back/articleAdd";
    }

    /*
    * 新增博客到数据库
    *
    * */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public ResultSet add(@RequestBody Article article) {

        long timeAsId = new Date().getTime();
        article.setArticleId(timeAsId);
        article.setSaveTime(new Timestamp(timeAsId));
        article.setPublishTime(new Date());

        Map<String, Object> articleMap = new HashMap<String, Object>();
        articleMap.put("article", article);
        articleMap.put("categorys", article.getCategories());
        articleMap.put("tags", article.getTags());

        ResultSet resultSet;
        try {
            articleService.add(article);
            resultSet = new ResultSet(true, 200, article);
        } catch (Exception e) {
            resultSet = new ResultSet(false, 500, "新增报错！！");
        }
        return resultSet;
    }

    /*
    * contentType = "application/x-www-form-urlencoded"时，@RequestParam / @RequestBody 跟 request.getParameter 可以接收参数，此时data为JSON对象；
    * contentType = "application/json"时， @RequestParam 跟 request.getParameter无法正常接收参数，因为tomcat不会读取请求体数据和进行相应的参数处理的，即不会解析表单数据来放到request parameter map中。；
    *contentType = "application/json"时, @RequestBody 可以接收实体模型数据，或者接收到整个非实体的JSON字符串；
    *
    * */
    /*
    * 文章列表分页
    *
    * */
    @RequestMapping(value = "/list/page/{pageIndex}",method = {RequestMethod.POST,RequestMethod.GET})
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

    /*
    * 文章详情
    *
    * */
    @RequestMapping(value = "/{articleId}",method = {RequestMethod.GET})
    public String getArticleById(Model model,@PathVariable(value = "articleId") Long articleId){
        Article article = articleService.getById(articleId);
        List<Category> categories = categoryService.list();
        model.addAttribute("article",article);
        model.addAttribute("categories",categories);
        return "back/articleEdit";
    }

    /*
    * 判断文章标题是否已经存在
    *
    * */
    @RequestMapping(value = "/title/ifexist",method = RequestMethod.POST)
    @ResponseBody
    public ResultSet ifExistTitle(String title){

        Map<String,Object> result  = new HashMap();
        ResultSet resultSet;

        try {
            boolean ifExist = articleService.ifExistTitle(title);
            result.put("ifExist",ifExist);
            resultSet = new ResultSet(true,ResultEnum.SUCCESS.getStatusCode(),result) ;
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment()) ;
        }
        return resultSet;
    }
}
