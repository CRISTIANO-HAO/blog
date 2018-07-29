package com.ssm.blog.controller;

import com.ssm.blog.dto.Archive;
import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.Category;
import com.ssm.blog.entity.User;
import com.ssm.blog.service.ArticleService;
import com.ssm.blog.service.CategoryService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
	     return "forward:/index";
	}

    @RequestMapping("/index.html")
    public String indexHtml(Model model){
        return "forward:/index";
    }
	
	@RequestMapping("/index")
	public String indexSec(Model model){
        List<Category> categories = categoryService.list();
        List<Archive> archives = articleService.getArticleArchives();
        model.addAttribute("categories",categories);
        model.addAttribute("archives",archives);
		return "front/index";
	}

	@RequestMapping("/goToLogin")
	public String goToLogin(){
		return "front/login";
	}

    @RequestMapping(value = "/login",method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public ResultSet login(@RequestBody User user){
        Subject subject = SecurityUtils.getSubject();
        //Md5Hash md5Hash = new Md5Hash(user.getPassword(),user.getUsername(),5);
        UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(),user.getPassword());

        ResultSet resultSet = null;
        try {
            token.setRememberMe(user.getRememberMe());
            subject.login(token);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),"登陆成功");
        }catch (AuthenticationException e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),"账号或者密码错误！");
        }
        return resultSet;
    }
}
