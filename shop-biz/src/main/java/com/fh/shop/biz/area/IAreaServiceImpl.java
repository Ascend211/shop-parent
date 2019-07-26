package com.fh.shop.biz.area;

import com.fh.shop.mapper.area.IAreaMapper;
import com.fh.shop.po.area.Area;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("areaService")
public class IAreaServiceImpl implements IAreaService {

    @Autowired
    private IAreaMapper areaMapper;

    @Override
    public List<Area> findAllAreaList() {
        List<Area> allAreaList = areaMapper.findAllAreaList();
        return allAreaList;
    }

    @Override
    public void addArea(Area area) {
        areaMapper.addArea(area);
    }

    @Override
    public void updateArea(Area area) {
        areaMapper.updateArea(area);
    }

    @Override
    public void deleteArea(List<Integer> idList) {
        areaMapper.deleteArea(idList);
    }
}
