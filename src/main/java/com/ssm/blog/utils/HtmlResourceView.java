package com.ssm.blog.utils;

import org.springframework.web.servlet.view.InternalResourceView;
import org.springframework.web.servlet.view.JstlView;

import java.io.File;
import java.util.Locale;

public class HtmlResourceView extends InternalResourceView {
    @Override
    public boolean checkResource(Locale locale) throws Exception {
        //获取classes文件夹的物理路径
        String url = this.getClass().getClassLoader().getResource("/").getPath();
        String fileUrl = url.substring(0,url.indexOf("/WEB-INF"));
        //拼凑jsp下文件的物理路径
        File file = new File(fileUrl + getUrl());
        return file.exists();// 判断该页面是否存在
    }
}
