package com.ssm.blog.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sun.org.apache.bcel.internal.generic.NEW;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


/**
 * 映射后台管理首页
 *
 */
@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	@RequestMapping(value="",method = RequestMethod.GET)
	public String index(){
	    //return "index";
		return "forward:/admin/article/list/page/1";
	}

}
