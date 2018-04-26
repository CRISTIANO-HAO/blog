package com.ssm.blog.dao;

import com.ssm.blog.entity.Category;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryDao {

    List<Category> list();
}
