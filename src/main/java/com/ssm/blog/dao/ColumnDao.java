package com.ssm.blog.dao;

import com.ssm.blog.entity.Column;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColumnDao {
    List<Column> list();
}
