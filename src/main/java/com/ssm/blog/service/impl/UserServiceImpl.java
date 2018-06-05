package com.ssm.blog.service.impl;

import com.ssm.blog.dao.UserDao;
import com.ssm.blog.entity.User;
import com.ssm.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public List<User> findUserByEmail(String email) {
        List<User> userList = userDao.findUserByEmail(email);
        return userList;
    }

    @Override
    public void addUser(User user) {
        userDao.addUser(user);
    }
}
