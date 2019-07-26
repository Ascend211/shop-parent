/** 
 * <pre>项目名称:shop-admin 
 * 文件名称:IProductService.java 
 * 包名:com.fh.shop.biz.product 
 * 创建日期:2019年6月5日上午9:36:50 
 * Copyright (c) 2019, yuxy123@gmail.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.biz.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.fh.shop.common.DataTableResult;
import com.fh.shop.common.ServerResponse;
import com.fh.shop.param.product.ProductSearchParam;
import com.fh.shop.po.product.Product;
import com.fh.shop.vo.ProductVo;
import org.apache.poi.ss.usermodel.Workbook;

/** 
 * <pre>项目名称：shop-admin    
 * 类名称：IProductService    
 * 类描述：    
 * 创建人：于笑扬 yuxy123@gmail.com    
 * 创建时间：2019年6月5日 上午9:36:50    
 * 修改人：于笑扬 yuxy123@gmail.com     
 * 修改时间：2019年6月5日 上午9:36:50    
 * 修改备注：       
 * @version </pre>    
 */
public interface IProductService {
	
	public void addProduct(Product product) ;

	public DataTableResult findProductPageList(ProductSearchParam productSearchParam);

    void deleteProduct(Integer id);

	ProductVo findProduct(Integer id);

	void updateProduct(Product product);

    void deleteBatch(List<Integer> ids);

    List<Product> findProductList(ProductSearchParam productSearchParam);

    void importExcel(String path);

    String buildHtmlContent(ProductSearchParam productSearchParam);

    File buildWordFile(ProductSearchParam productSearchParam);

    Workbook buildWorkbook(ProductSearchParam productSearchParam);

    void updateProductStatus(int id, int status);

    ServerResponse findHotList();
}
