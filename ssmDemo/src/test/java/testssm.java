import com.test.dao.DeptMapper;
import com.test.dao.UserMapper;
import com.test.entity.Dept;
import com.test.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/application-bean.xml"})
public class testssm {
    @Autowired
    UserMapper userMapper;

    @Test
    public void test() {
        /*传统方式*/
       /* ApplicationContext context = new ClassPathXmlApplicationContext("config/application-bean.xml");
        UserMapper userMapper = context.getBean(UserMapper.class);
        int i = userMapper.insertSelective(new User(null, "张三", "男", "111@qq.com", 2));
        DeptMapper bean = context.getBean(DeptMapper.class);
        int 吃货部门 = bean.insertSelective(new Dept(null, "吃货部门"));*/

        for (int x=0;x<50;x++) {
            String substring = UUID.randomUUID().toString().substring(0, 4);
            int i = userMapper.insertSelective(new User(null, substring, "男", substring+"@qq.com", 1));
        }
    }
}
