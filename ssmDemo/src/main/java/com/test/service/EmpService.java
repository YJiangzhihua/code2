package com.test.service;

import com.test.dao.UserMapper;
import com.test.entity.User;
import com.test.entity.UserExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EmpService {
    @Autowired
    UserMapper userMapper;


    public List<User> selectall() {
        return userMapper.selectByExampleWithDept(null);
    }

    public int addDept(User user) {
        return userMapper.insertSelective(user);
    }

    public boolean selectUname(String name) {
        UserExample userExample=new UserExample();
        UserExample.Criteria criteria = userExample.createCriteria();
        criteria.andUNameEqualTo(name);
        List<User> list = userMapper.selectByExample(userExample);

        return list.isEmpty();
    }

    public User update_emp(Integer id) {
        return userMapper.selectByPrimaryKey(id);
    }


    public void updateuser(User user) {
       userMapper.updateByPrimaryKeySelective(user);
    }

    public void deleById(Integer id) {
        userMapper.deleteByPrimaryKey(id);
    }
}
