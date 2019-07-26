package com.fh.shop.po.product;

import java.io.Serializable;
import java.util.Date;

import com.fh.shop.po.brand.Brand;
import org.springframework.format.annotation.DateTimeFormat;

public class Product implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8314862653251098440L;

	private Integer id;
	
	private String productName;
	
	private Float productPrice;

	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createDate;

	private Brand brand = new Brand();

	private Integer gc1;

	private Integer gc2;

	private Integer gc3;

	private String categoryName;

	private String mainImagePath;

	private String oldMainImagePath;

	private int isHot;

	private int status;

	public String getOldMainImagePath() {
		return oldMainImagePath;
	}

	public void setOldMainImagePath(String oldMainImagePath) {
		this.oldMainImagePath = oldMainImagePath;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getIsHot() {
		return isHot;
	}

	public void setIsHot(int isHot) {
		this.isHot = isHot;
	}

	public String getMainImagePath() {
		return mainImagePath;
	}

	public void setMainImagePath(String mainImagePath) {
		this.mainImagePath = mainImagePath;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

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

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}


	

	public Float getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Float productPrice) {
		this.productPrice = productPrice;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
}
