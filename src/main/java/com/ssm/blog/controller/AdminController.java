package com.ssm.blog.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sun.org.apache.bcel.internal.generic.NEW;


/**
 * 映射后台管理首页
 *
 */
@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	@RequestMapping(value="")
	public String index(){
		return "back/index";
	}

	@SuppressWarnings("deprecation")
	public static void main(String[] args) {
		System.out.println(new Date().getTime());
		SimpleDateFormat sFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(sFormat.format(new Date()));
	}
}
