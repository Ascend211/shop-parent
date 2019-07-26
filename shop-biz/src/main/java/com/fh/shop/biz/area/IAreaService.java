package com.fh.shop.biz.area;

import com.fh.shop.po.area.Area;

import java.util.List;

public interface IAreaService {

    public List<Area> findAllAreaList();

    void addArea(Area area);

    void updateArea(Area area);

    void deleteArea(List<Integer> idList);
}
