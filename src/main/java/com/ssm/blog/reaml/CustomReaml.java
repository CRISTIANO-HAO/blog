package com.ssm.blog.reaml;

import com.ssm.blog.service.UserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;


public class CustomReaml extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //从认证信息中获取用户名
        String username = (String) principalCollection.getPrimaryPrincipal();
        List<String> roles =  userService.getRolesByName(username);
       // List<String> permissions = userService.getPermissionByName(username);

        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();

        //simpleAuthorizationInfo.setStringPermissions(new HashSet<String>(permissions));
        simpleAuthorizationInfo.setRoles(new HashSet<String>(roles));
        return simpleAuthorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        //从认证信息中获取用户名
        String username = (String) authenticationToken.getPrincipal();
        //获取密码
        String password = userService.getUserByName(username).get(0).getPassword();

        if (password == null){
            return null;
        }
        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(username,password,"customReaml");
        simpleAuthenticationInfo.setCredentialsSalt(ByteSource.Util.bytes(username));
        return simpleAuthenticationInfo;
    }
}
