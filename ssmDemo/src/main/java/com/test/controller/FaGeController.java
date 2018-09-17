package com.test.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.test.entity.Dept;
import com.test.entity.User;
import com.test.service.DeptService;
import com.test.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class FaGeController {
    @Autowired
    EmpService empService;

    @RequestMapping("/emp")
    public String select(@RequestParam(value = "pn",defaultValue = "1") Integer pagehelper, Model modle, HttpServletResponse response){
        PageHelper.startPage(pagehelper,10);
        List<User> selectall = empService.selectall();
        PageInfo pageInfo=new PageInfo(selectall,5);
        modle.addAttribute("haha",pageInfo);
      /*  modle.addAttribute("pageInfo",pageInfo);
        modle.addAttribute("pageInfo",pageInfo);*/
        response.setContentType("text/html;charset=UTF-8");

        return "emp";
    }

    @Autowired
    DeptService deptService;
    @RequestMapping("/dept")
    @ResponseBody
    public List<Dept> findDept(){
        List<Dept> list=deptService.findDept();
        return list;
    }


    @RequestMapping(value = "/saveAdd",method = RequestMethod.POST)
    @ResponseBody
    public void addEmp(User user){
        System.out.println(user);
      int add=  empService.addDept(user);
    }

    @RequestMapping("/selectUname")
    @ResponseBody
    public String selectUname(String name){
       boolean select= empService.selectUname(name);
       if (select){
           return "yes";
       }else {
           return "no";
       }
    }
    @RequestMapping(value = "/update_emp/{uId}",method =RequestMethod.GET)
    @ResponseBody
    public User update_emp(@PathVariable("uId")Integer id){
       User user= empService.update_emp(id);
        return user;
    }

    @RequestMapping(value = "/updateemp/{uId}",method = RequestMethod.PUT)
    @ResponseBody
    public void updateemp(User user){

     empService.updateuser(user);
    }

    @RequestMapping(value = "/delete/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public void delete(@PathVariable("id") String ids){
        String[] split = ids.split(",");
        for (String str: split) {
            Integer id=Integer.parseInt(str);
            empService.deleById(id);
        }


    }
}
