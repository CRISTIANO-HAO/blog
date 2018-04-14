package com.ssm.blog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 映射首页路径
 *
 */
@Controller
@RequestMapping("/")
public class IndexController {
	
	@RequestMapping("/")
	public String index(){
		return "front/index";
	}
	
	@RequestMapping("/index")
	public String indexSec(){
		String index = index();
		return index;
	}
}
