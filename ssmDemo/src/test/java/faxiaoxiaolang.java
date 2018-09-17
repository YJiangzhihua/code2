import com.github.pagehelper.PageInfo;
import com.test.entity.User;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;


@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:config/application-bean.xml","classpath:config/springmvc-config.xml"})
public class faxiaoxiaolang {
    @Autowired
    WebApplicationContext context;
    MockMvc mockMvc;

    @Before
    public void init(){
        mockMvc= MockMvcBuilders.webAppContextSetup(context).build();

    }
    @Test
    public void Test(){
        try {
            MvcResult result=mockMvc.perform(MockMvcRequestBuilders.get("/emp").param("pn","1")).andReturn();
            MockHttpServletRequest request=result.getRequest();
            PageInfo pageInfo=(PageInfo)request.getAttribute("haha");
            System.out.println("当前页："+pageInfo.getPageNum());
            System.out.println("总数："+pageInfo.getTotal());
            System.out.println("总页数："+pageInfo.getPages());
            System.out.println();
            List<User> list=pageInfo.getList();
            for(User u:list){
                System.out.println(u.getuName()+u.getuGander()+u.getuEmail()+u.getuId()+u.getdId()+u.getDept().getDeptName()+u.getDept().getDeptId());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }




}
