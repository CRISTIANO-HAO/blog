package com.ssm.blog.controller;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.User;
import com.ssm.blog.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/*
* 登陆
* */
@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public ResultSet login(@RequestBody User user){
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(),user.getPassword());

        ResultSet resultSet = null;
        try {
            subject.login(token);
            List<User> userList = userService.getUserByName(user.getUsername());
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),userList.get(0));
        }catch (AuthenticationException e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),"账号或者密码错误！");
        }
        return resultSet;
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    @ResponseBody
    public ResultSet logout(){
        Subject subject = SecurityUtils.getSubject();

        ResultSet resultSet = null;
        try {
            subject.logout();
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),"成功退出登陆！");
        }catch (Exception e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),"退出登陆失败！");
        }
        return resultSet;
    }
}
