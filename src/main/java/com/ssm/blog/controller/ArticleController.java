package com.ssm.blog.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.Article;
import com.ssm.blog.entity.Tag;
import com.ssm.blog.service.ArticleService;


@Controller
@RequestMapping(value="/article")
public class ArticleController {
	
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	@ResponseBody
	public ResultSet add(@RequestBody Article article){
		System.out.println(article.getMarkdownContent());
		long time = new Date().getTime();
		article.setArticleId(time);
		article.setSaveTime(new Date());
		article.setPublishTime(new Date());
		article.setTitle("Java的深入浅出"+Math.random());
		System.out.println(article.getTags().size());
		
		Map<String, Object> articleMap = new HashMap<String, Object>();		
		articleMap.put("article", article);
		articleMap.put("tags", article.getTags());
		
		ResultSet resultSet;
		try {
			articleService.save(article);
			resultSet = new ResultSet(true,200,article);
		} catch (Exception e) {
			resultSet = new ResultSet(false, 500, "新增报错！！");
		}
		return resultSet;
	}
}
