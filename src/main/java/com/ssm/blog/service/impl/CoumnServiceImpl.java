package com.ssm.blog.service.impl;

import com.ssm.blog.dao.ColumnDao;
import com.ssm.blog.entity.Column;
import com.ssm.blog.service.ColumnService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CoumnServiceImpl implements ColumnService {

    @Autowired
    private ColumnDao columnDao;

    @Override
    public List<Column> list() {
        List<Column> list = columnDao.list();
        return list;
    }
}
