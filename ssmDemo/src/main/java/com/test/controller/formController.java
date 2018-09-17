package com.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.xml.soap.DetailEntry;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class formController {
    private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");

    @RequestMapping("/uploadFile")
    public void getform(String name, MultipartFile uploadFile, HttpServletRequest request) {
        String contextPath = request.getSession().getServletContext().getRealPath("/fileupload");
        System.out.println(contextPath);
        System.out.println(uploadFile.getName());
        String originalFilename = uploadFile.getOriginalFilename();
        String houzuiname = originalFilename.substring(originalFilename.lastIndexOf(".")).trim();
        String newname = simpleDateFormat.format(new Date()) + (int) (Math.random() * 1000) + houzuiname;
        try {
            uploadFile.transferTo(new File(contextPath, newname));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
