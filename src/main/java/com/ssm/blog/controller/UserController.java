package com.ssm.blog.controller;

import com.ssm.blog.dto.ResultEnum;
import com.ssm.blog.dto.ResultSet;
import com.ssm.blog.entity.User;
import com.ssm.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/info",method = RequestMethod.GET)
    @ResponseBody
    public ResultSet getUserInfo(@RequestParam(required = true) String username){
        ResultSet resultSet = null;
        try {
            List<User> userList = userService.getUserByName(username);
            resultSet = new ResultSet(true, ResultEnum.SUCCESS.getStatusCode(),userList.get(0));
        }catch (Exception e){
            resultSet = new ResultSet(true, ResultEnum.ERROR.getStatusCode(),"获取用户信息失败！");
        }
        return resultSet;
    }
}
