package com.fh.shop.biz.brand;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.common.DataTableResult;
import com.fh.shop.mapper.brand.IBrandMapper;
import com.fh.shop.param.brand.BrandSearchParam;
import com.fh.shop.po.brand.Brand;
import com.fh.shop.util.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("brandService")
public class IBrandServiceImpl implements IBrandService {

    @Autowired
    private IBrandMapper brandMapper;


    @Override
    public List<Brand> findAllBrandList() {
        String brandListStr = RedisUtil.get("brandList");
        if (brandListStr != null) {
            List<Brand> brands = JSONObject.parseArray(brandListStr, Brand.class);
            return brands;
        }
        // 查询数据库
        List<Brand> allBrandList = brandMapper.findAllBrandList();
        // 转换为json格式的字符串
        String brandListJson = JSONObject.toJSONString(allBrandList);
        // 存缓存
        RedisUtil.set("brandList", brandListJson);
//        RedisUtil.setEx("brandList", brandListJson, 1*60);
        // 返回去
        return allBrandList;
    }

    @Override
    public void addBrand(Brand brand) {
        brandMapper.addBrand(brand);
        // 手动刷新缓存
        RedisUtil.del("brandList");
    }

    @Override
    public DataTableResult findBrandPageList(BrandSearchParam brandSearchParam) {
        // 获取总条数
        long totalCount = brandMapper.findBrandListCount(brandSearchParam);
        // 获取分页列表
        List<Brand> brandList = brandMapper.findBrandPageList(brandSearchParam);
        // 组装数据
        DataTableResult dataTableResult = new DataTableResult(brandSearchParam.getDraw(), totalCount, brandList);
        // 返回数据
        return dataTableResult;
    }

    @Override
    public void updateStatus(String status, int id) {
        brandMapper.updateStatus(status, id);
    }


}
