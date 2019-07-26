/** 
 * <pre>项目名称:shop-admin 
 * 文件名称:IProductMapper.java 
 * 包名:com.fh.shop.mapper.product 
 * 创建日期:2019年6月5日上午11:03:36 
 * Copyright (c) 2019, yuxy123@gmail.com All Rights Reserved.</pre> 
 */
package com.fh.shop.mapper.product;

import java.util.List;

import com.fh.shop.param.product.ProductSearchParam;
import org.apache.ibatis.annotations.Param;

import com.fh.shop.po.product.Product;

/**
 * <pre>
 * 项目名称：shop-admin    
 * 类名称：IProductMapper    
 * 类描述：    
 * 创建人：于笑扬 yuxy123@gmail.com    
 * 创建时间：2019年6月5日 上午11:03:36    
 * 修改人：于笑扬 yuxy123@gmail.com     
 * 修改时间：2019年6月5日 上午11:03:36    
 * 修改备注：       
 * &#64;version
 * </pre>
 */
public interface IProductMapper {

	public void addProduct(Product product);

	/**
	 * <pre>
	 * findProductListCount(这里用一句话描述这个方法的作用)   
	 * 创建人：于笑扬 yuxy123@gmail.com    
	 * 创建时间：2019年6月6日 下午6:10:02    
	 * 修改人：于笑扬 yuxy123@gmail.com     
	 * 修改时间：2019年6月6日 下午6:10:02    
	 * 修改备注： 
	 * &#64;return
	 * </pre>
	 */
	public long findProductListCount(ProductSearchParam productSearchParam);

	/**
	 * <pre>
	 * findProductList(这里用一句话描述这个方法的作用)   
	 * 创建人：于笑扬 yuxy123@gmail.com    
	 * 创建时间：2019年6月6日 下午6:14:14    
	 * 修改人：于笑扬 yuxy123@gmail.com     
	 * 修改时间：2019年6月6日 下午6:14:14    
	 * 修改备注： 
	 * &#64;param start
	 * &#64;param length
	 * &#64;return
	 * </pre>
	 */
	public List<Product> findProductList(ProductSearchParam productSearchParam);

    void deleteProduct(Integer id);

	Product findProduct(Integer id);

	void updateProduct(Product product);

    void deleteBatch(List<Integer> ids);

    List<Product> findAllProductList(ProductSearchParam productSearchParam);

	void addBatchProduct(List productList);

	void updateProductStatus(@Param("id") int id, @Param("status") int status);
}
