package com.fh.shop.param.product;

import com.fh.shop.common.Page;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class ProductSearchParam extends Page {

    private String productName;

    private Float minPrice;

    private Float maxPrice;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxDate;

    private Integer brandId;

    private Integer gc1;

    private Integer gc2;

    private Integer gc3;

    public Integer getGc1() {
        return gc1;
    }

    public void setGc1(Integer gc1) {
        this.gc1 = gc1;
    }

    public Integer getGc2() {
        return gc2;
    }

    public void setGc2(Integer gc2) {
        this.gc2 = gc2;
    }

    public Integer getGc3() {
        return gc3;
    }

    public void setGc3(Integer gc3) {
        this.gc3 = gc3;
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Float getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Float minPrice) {
        this.minPrice = minPrice;
    }

    public Float getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Float maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Date getMinDate() {
        return minDate;
    }

    public void setMinDate(Date minDate) {
        this.minDate = minDate;
    }

    public Date getMaxDate() {
        return maxDate;
    }

    public void setMaxDate(Date maxDate) {
        this.maxDate = maxDate;
    }
}
