package com.fh.shop;

import com.fh.shop.biz.area.IAreaService;
import com.fh.shop.po.area.Area;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring/spring-biz.xml"})
public class TestAreaBiz {
    @Resource(name = "areaService")
    private IAreaService areaService;

    @Test
    public void testSelect() {
        List<Area> allAreaList = areaService.findAllAreaList();
        System.out.println(allAreaList);
    }
}
