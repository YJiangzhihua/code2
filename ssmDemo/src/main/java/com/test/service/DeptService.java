package com.test.service;

import com.test.dao.DeptMapper;
import com.test.entity.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DeptService {
    @Autowired
    DeptMapper deptMapper;
    public List<Dept> findDept() {
        List<Dept> list = deptMapper.selectByExample(null);
        return list;
    }
}
