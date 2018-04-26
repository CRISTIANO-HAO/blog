package com.ssm.blog.service.impl;

import com.ssm.blog.dao.CategoryDao;
import com.ssm.blog.entity.Category;
import com.ssm.blog.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryDao categoryDao;

    @Override
    public List<Category> list() {
        List<Category> categories = categoryDao.list();
        return categories;
    }
}
