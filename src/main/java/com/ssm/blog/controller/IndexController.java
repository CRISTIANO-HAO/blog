package com.ssm.blog.controller;

import com.ssm.blog.dto.Archive;
import com.ssm.blog.entity.Category;
import com.ssm.blog.service.ArticleService;
import com.ssm.blog.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;


/**
 * 映射首页路径
 *
 */
@Controller
@RequestMapping("/")
public class IndexController {

	@Autowired
    private CategoryService categoryService;
	@Autowired
    private ArticleService articleService;
	
	@RequestMapping("/")
	public String index(Model model){
        List<Category> categories = categoryService.list();
        List<Archive> archives = articleService.getArticleArchives();
        model.addAttribute("categories",categories);
        model.addAttribute("archives",archives);
	    return "front/index";
	}
	
	@RequestMapping("/index")
	public String indexSec(Model model){
        List<Category> categories = categoryService.list();
        model.addAttribute("categories",categories);
		return "front/index";
	}
}
