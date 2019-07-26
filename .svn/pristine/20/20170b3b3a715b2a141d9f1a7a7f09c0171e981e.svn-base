package com.fh.shop;

import com.fh.shop.mapper.area.IAreaMapper;
import com.fh.shop.po.area.Area;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring/spring-dao.xml"})
public class TestAreaMapper {
    @Autowired
    private IAreaMapper areaMapper;

    @Test
    public void testAdd() {
        Area area = new Area();
        area.setAreaName("新疆");
        area.setFatherId(0);
        areaMapper.addArea(area);
    }
}
