package com.ssm.blog.controller.admin;

import java.sql.Timestamp;
import java.util.*;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.entity.Category;
import com.ssm.blog.entity.Column;
import com.ssm.blog.service.CategoryService;
import com.ssm.blog.service.ColumnService;
import com.ssm.blog.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.Article;
import com.ssm.blog.service.ArticleService;

@Controller("adminArticleController")
@RequestMapping(value = "/admin/article")
public class ArticleController {

    @Autowired
    private ArticleService articleService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ColumnService columnService;

    /*
    * 跳转添加博客页面
    *
    * */
    @RequestMapping(value = "/articleAdd")
    public String articleAdd(Model model){
        List<Category> categories = categoryService.list();
        List<Column> columns = columnService.list();
        model.addAttribute("categories",categories);
        model.addAttribute("columns",columns);
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
        //以时间戳为文章唯一Id
        article.setArticleId(timeAsId);
        article.setSaveTime(new Timestamp(timeAsId));
        //默认为草稿状态；
        article.setStatus(0);

        ResultSet resultSet;
        try {
            articleService.addArticle(article);
            resultSet = new ResultSet(true, 200, "新增成功！");
        } catch (Exception e) {
            resultSet = new ResultSet(false, 500, "新增报错！！");
        }
        return resultSet;
    }

    /*
    * 发布文章
    *
    * */
    @RequestMapping(value = "/publish",method = RequestMethod.POST)
    @ResponseBody
    public ResultSet publish(@RequestBody Article article){
        Long timeStamp = new Date().getTime();
        article.setSaveTime(new Timestamp(timeStamp));

        //设置文章状态为发布;当status为1时，则是取消发布状态为草稿状态
        if (article.getStatus() == 1){
            article.setStatus(0);
            article.setPublishTime(null);
        }else {
            article.setStatus(1);
            article.setPublishTime(new Timestamp(timeStamp));
        }
        ResultSet resultSet = null;
        try {
            articleService.update(article);
            resultSet = new ResultSet(true,ResultEnum.SUCCESS.getStatusCode(),ResultEnum.SUCCESS.getComment());
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
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
        ResultSet resultSet = null;
        List<Article> articleList = null;
        try {
            articleList = articleService.list(page.getOffsetCount(),page.getPageSize(),searchParam);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(), articleList);
        } catch (Exception e) {
            resultSet = new ResultSet(false, ResultEnum.ERROR.getStatusCode(), ResultEnum.ERROR.getComment());
        }

        model.addAttribute("articleList", articleList);
        model.addAttribute("page",page);
        model.addAttribute("searchParam",searchParam);
        return "back/index";
    }

    @RequestMapping(value = "/page/{pageIndex}",method = {RequestMethod.POST,RequestMethod.GET})
    @ResponseBody
    public ResultSet getArticlelist(@PathVariable(value = "pageIndex") Integer pageIndex, @RequestParam(value = "pageSize",required = false,defaultValue = "3") Integer pageSize, @RequestParam(value = "searchParam", required = false,defaultValue = "") String searchParam){
        //默认页数为第一页
        if (pageIndex == null){
            pageIndex = 1;
        }

        //获取查询的总数目
        int totalCount = articleService.getTotalCount(searchParam);
        //添加分页查询的信息
        Page page = new Page(pageIndex,pageSize,totalCount);
        //结果集对象
        ResultSet resultSet = null;
        List<Article> articleList = null;
        try {
            articleList = articleService.list(page.getOffsetCount(),page.getPageSize(),searchParam);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(), articleList);
        } catch (Exception e) {
            resultSet = new ResultSet(false, ResultEnum.ERROR.getStatusCode(), ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }

    @RequestMapping(value = "/page",method = RequestMethod.POST)
    @ResponseBody
    public ResultSet getArticleByPage(@RequestParam(value = "status",required = false,defaultValue = "") Integer status,@RequestParam(value = "pageIndex",required = false,defaultValue = "1") Integer pageIndex, @RequestParam(value = "pageSize",required = false,defaultValue = "8") Integer pageSize, @RequestParam(value = "searchParam", required = false,defaultValue = "") String searchParam){
        if (status == null || "".equals(status)){
            status = null;
        }
        //获取查询的总数目
        int totalCount = articleService.getTotalCount(searchParam);
        //添加分页查询的信息
        Page page = new Page(pageIndex,pageSize,totalCount);
        //结果集对象
        ResultSet resultSet = null;
        List<Article> articleList = null;
        HashMap hashMap = new HashMap();
        try {
            articleList = articleService.getAdminArticleByPage(page.getOffsetCount(),page.getPageSize(),searchParam,status);
            hashMap.put("articleList",articleList);
            hashMap.put("pageMsg",page);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(), hashMap);
        } catch (Exception e) {
            resultSet = new ResultSet(false, ResultEnum.ERROR.getStatusCode(), ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }

    /*
    * 文章修改详情页
    *
    * */
    @RequestMapping(value = "/edit/{articleId}",method = {RequestMethod.GET})
    public String editArticleById(Model model,@PathVariable(value = "articleId") Long articleId){
        Article article = articleService.getArticleById(articleId);
        List<Category> categories = categoryService.list();
        List<Column> columns = columnService.list();
        model.addAttribute("article",article);
        model.addAttribute("categories",categories);
        model.addAttribute("columns",columns);
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

    @RequestMapping(value = "/update/{articleId}",method = RequestMethod.POST)
    @ResponseBody
    public ResultSet update(@RequestBody Article article,@PathVariable Long articleId){
        Long timeStamp = new Date().getTime();
        article.setSaveTime(new Timestamp(timeStamp));
        ResultSet resultSet;

        try {
            articleService.update(article);
            resultSet = new ResultSet(true,ResultEnum.SUCCESS.getStatusCode(),ResultEnum.SUCCESS.getComment());
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }

    @RequestMapping(value = "get/{articleId}",method = RequestMethod.GET)
    public String getArticleById(Model model,@PathVariable("articleId") Long articleId){
        Article article = articleService.getArticleById(articleId);

        model.addAttribute("article",article);
        return "back/articleDetail";
    }
}
