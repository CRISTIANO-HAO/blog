package com.ssm.blog.service.impl;

import com.ssm.blog.dao.UserDao;
import com.ssm.blog.entity.User;
import com.ssm.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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

    @Override
    public String getRolesByUsername(String username) {
        String roles = userDao.getRolesByUsername(username);
        return roles;
    }

    @Override
    public List<User> getUserByName(String username) {
        List<User> userList = userDao.getUserByName(username);
        return userList;
    }

    @Override
    public void updateUsername(long userId, String username) {
        userDao.updateUsername(userId, username);
    }

    @Override
    public List<String> getRolesByName(String username){
        List<User> userList = userDao.getUserByName(username);
        List<String> rolesList = new ArrayList<String>();
        if (userList.size() > 0){
            rolesList.add(userList.get(0).getRoles());
        }
        return rolesList;
    }

    @Override
    public List<String> getPermissionByName(String username){
        return userDao.getPermissionByName(username);
    }
}
