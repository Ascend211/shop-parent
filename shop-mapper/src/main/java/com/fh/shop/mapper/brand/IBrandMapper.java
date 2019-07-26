package com.fh.shop.mapper.brand;

import com.fh.shop.param.brand.BrandSearchParam;
import com.fh.shop.po.brand.Brand;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IBrandMapper {

    public List<Brand> findAllBrandList();

    void addBrand(Brand brand);

    long findBrandListCount(BrandSearchParam brandSearchParam);

    List<Brand> findBrandPageList(BrandSearchParam brandSearchParam);

    void updateStatus(@Param("status") String status, @Param("id") int id);
}
