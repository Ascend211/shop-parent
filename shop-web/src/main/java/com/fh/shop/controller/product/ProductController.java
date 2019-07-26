/** 
 * <pre>项目名称:shop-admin 
 * 文件名称:ProductController.java 
 * 包名:com.fh.shop.controller.product 
 * 创建日期:2019年6月4日下午5:22:29 
 * Copyright (c) 2019, yuxy123@gmail.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.controller.product;

import com.fh.shop.biz.product.IProductService;
import com.fh.shop.common.DataTableResult;
import com.fh.shop.common.LogMessage;
import com.fh.shop.common.ServerResponse;
import com.fh.shop.param.product.ProductSearchParam;
import com.fh.shop.po.product.Product;
import com.fh.shop.util.DateUtil;
import com.fh.shop.util.FileUtil;
import com.fh.shop.util.RedisUtil;
import com.fh.shop.util.SystemConstant;
import com.fh.shop.vo.ProductVo;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.formula.functions.T;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

/** 
 * <pre>项目名称：shop-admin    
 * 类名称：ProductController    
 * 类描述：    
 * 创建人：于笑扬 yuxy123@gmail.com    
 * 创建时间：2019年6月4日 下午5:22:29    
 * 修改人：于笑扬 yuxy123@gmail.com     
 * 修改时间：2019年6月4日 下午5:22:29    
 * 修改备注：       
 * @version </pre>    
 */
@Controller
@RequestMapping("/product")
public class ProductController {


	@Resource(name="productService")
	private IProductService productService;
	
	@RequestMapping("/toAdd")
	public String toAdd() {
		return "/product/add";
	}

    @RequestMapping("/refreshProductCache")
    @ResponseBody
	public ServerResponse refreshProductCache() {
        RedisUtil.del("hotProductList");
        return ServerResponse.success();
    }

    @RequestMapping("/update")
    @ResponseBody
    @LogMessage("更新商品")
	public ServerResponse update(Product product) {
	    productService.updateProduct(product);
        return ServerResponse.success();
    }

    @RequestMapping("/find")
    @ResponseBody
	public ServerResponse find(Integer id) {
	    ProductVo productVo = productService.findProduct(id);
        return ServerResponse.success(productVo);
    }

    @RequestMapping("/exportExcel")
    public void exportExcel(ProductSearchParam productSearchParam, HttpServletResponse response) {
        Workbook workbook = productService.buildWorkbook(productSearchParam);
        // 下载
        FileUtil.xlsDownloadFile(response, workbook);
    }

    @RequestMapping("/exportWord")
    public void exportWord(ProductSearchParam productSearchParam, HttpServletResponse response, HttpServletRequest request) throws IOException {
        File file = productService.buildWordFile(productSearchParam);
        // 下载
        FileUtil.downloadFile(request, response, file);
        // 删除垃圾文件
        FileUtil.deleteFile(file);
    }


    @RequestMapping("/exportPdf")
    public void exportPdf(ProductSearchParam productSearchParam, HttpServletResponse response) throws IOException, TemplateException {
        String htmlContent = productService.buildHtmlContent(productSearchParam);
        // 转为pdf并进行下载
        FileUtil.pdfDownloadFile(response, htmlContent);
    }


    @RequestMapping("/importProductExcel")
    @ResponseBody
    public ServerResponse importProductExcel(String path){
	    productService.importExcel(path);
        return ServerResponse.success();
    }



    @RequestMapping("/add")
    @ResponseBody
    @LogMessage("添加商品")
	public ServerResponse add(Product product)  {
	    productService.addProduct(product);
        return ServerResponse.success();
    }

    @RequestMapping("/delete")
    @ResponseBody
    @LogMessage("删除商品")
    public ServerResponse deleteProduct(Integer id) {
	    productService.deleteProduct(id);
        return ServerResponse.success();
    }
	
	@RequestMapping("/toList")
	public String toList() {
        System.out.println("产品页面");
		return "/product/list";
	}
	
	@RequestMapping("/findList")
    public @ResponseBody ServerResponse findList(ProductSearchParam productSearchParam) {
        System.out.println("产品列表");
        DataTableResult productPageList = productService.findProductPageList(productSearchParam);
        return ServerResponse.success(productPageList);
	}

    @RequestMapping("/toHotList")
	public String toHotList() {
	    return "/product/hotproduct";
    }

    @RequestMapping("/hotlist")
	public @ResponseBody ServerResponse findHotlist() {
        ServerResponse serverResponse = productService.findHotList();
	    return serverResponse;
    }

    @RequestMapping("/updateProductStatus")
    @LogMessage("更新商品状态")
	public @ResponseBody ServerResponse updateProductStatus(int id, int status) {
        productService.updateProductStatus(id, status);
	    return ServerResponse.success();
    }

    @RequestMapping("/deleteBatch")
    @ResponseBody
    @LogMessage("批量删除商品")
	public ServerResponse deleteBatch(@RequestParam("ids[]") List<Integer> ids) {
            productService.deleteBatch(ids);
            return ServerResponse.success();
    }

}
