package com.ssm.blog.dao;

import com.ssm.blog.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {
    List<User> findUserByEmail(@Param("email") String email);

    void addUser(@Param("user") User user);

    List<String> getPermissionByName(@Param("username") String username);

    List<User> getUserByName(@Param("username") String username);

    String getRolesByUsername(@Param("username") String username);

    void updateUsername(@Param("userId") long userId, @Param("username") String username);

    User getUserById(@Param("userId") Long userId);
}
