package com.ssm.blog.controller.admin;

import java.sql.Timestamp;
import java.util.*;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.entity.Category;
import com.ssm.blog.entity.Column;
import com.ssm.blog.service.CategoryService;
import com.ssm.blog.service.ColumnService;
import com.ssm.blog.utils.Page;
import org.apache.shiro.authz.annotation.RequiresRoles;
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
    * 获取文章相关信息
    * */
    @RequestMapping(value = "/asset",method = RequestMethod.GET)
    @ResponseBody
    public ResultSet getArticleAsset(){
        ResultSet resultSet = null;
        HashMap hashMap = new HashMap();
        try {
            List<Category> categories = categoryService.list();
            List<Column> columns = columnService.list();
            hashMap.put("categories",categories);
            hashMap.put("columns",columns);
            resultSet = new ResultSet(true,ResultEnum.SUCCESS.getStatusCode(),hashMap);
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
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
        if (article.getStatus() == 0 || article.getStatus() == null){
            article.setSaveTime(new Timestamp(timeAsId));
            //默认为草稿状态；
            article.setStatus(0);
        }else {
            article.setSaveTime(new Timestamp(timeAsId));
            article.setPublishTime(new Timestamp(timeAsId));
        }

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
    @RequiresRoles("admin")
    @RequestMapping(value = "/page",method = RequestMethod.POST)
    @ResponseBody
    public ResultSet getArticleByPage(@RequestParam(value = "status",required = false,defaultValue = "") Integer status,@RequestParam(value = "pageIndex",required = false,defaultValue = "1") Integer pageIndex, @RequestParam(value = "pageSize",required = false,defaultValue = "8") Integer pageSize, @RequestParam(value = "searchParam", required = false,defaultValue = "") String searchParam){
        if (status == null || "".equals(status)){
            status = null;
        }
        //获取查询的总数目
        int totalCount = articleService.getTotalCount(searchParam,status);
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

    @RequestMapping(value = "/update",method = RequestMethod.POST)
    @ResponseBody
    public ResultSet update(@RequestBody Article article){
        Long timeStamp = new Date().getTime();
        if (article.getStatus() == 0){
            article.setSaveTime(new Timestamp(timeStamp));
        }else {
            article.setSaveTime(new Timestamp(timeStamp));
            if (!articleService.hasPublishTime(article.getArticleId())){
                article.setPublishTime(new Timestamp(timeStamp));
            }
        }

        ResultSet resultSet;

        try {
            articleService.update(article);
            resultSet = new ResultSet(true,ResultEnum.SUCCESS.getStatusCode(),ResultEnum.SUCCESS.getComment());
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }

    @RequestMapping(value = "/get",method = RequestMethod.GET)
    @ResponseBody
    public ResultSet getArticleById(@RequestParam("articleId") Long articleId){
        ResultSet resultSet = null;

        try {
            Article article = articleService.getArticleById(articleId);
            resultSet = new ResultSet(true,ResultEnum.SUCCESS.getStatusCode(),article);
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }

    @RequestMapping(value = "/delete",method = RequestMethod.GET)
    @ResponseBody
    public ResultSet deleteArticleById(@RequestParam("articleId") Long articleId){
        ResultSet resultSet = null;

        try {
            articleService.deleteArticleById(articleId);
            resultSet = new ResultSet(true,ResultEnum.SUCCESS.getStatusCode(),ResultEnum.SUCCESS.getComment());
        }catch (Exception e){
            resultSet = new ResultSet(false,ResultEnum.ERROR.getStatusCode(),ResultEnum.ERROR.getComment());
        }
        return resultSet;
    }
}
