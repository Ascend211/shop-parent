/** 
 * <pre>项目名称:shop-admin 
 * 文件名称:ProductServiceImpl.java 
 * 包名:com.fh.shop.biz.product 
 * 创建日期:2019年6月5日上午9:37:57 
 * Copyright (c) 2019, yuxy123@gmail.com All Rights Reserved.</pre> 
 */  
package com.fh.shop.biz.product;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.common.DataTableResult;
import com.fh.shop.common.ServerResponse;
import com.fh.shop.mapper.brand.IBrandMapper;
import com.fh.shop.mapper.product.IProductMapper;
import com.fh.shop.param.product.ProductSearchParam;
import com.fh.shop.po.brand.Brand;
import com.fh.shop.po.product.Product;
import com.fh.shop.util.*;
import com.fh.shop.vo.ProductVo;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

/** 
 * <pre>项目名称：shop-admin    
 * 类名称：ProductServiceImpl    
 * 类描述：    
 * 创建人：于笑扬 yuxy123@gmail.com    
 * 创建时间：2019年6月5日 上午9:37:57    
 * 修改人：于笑扬 yuxy123@gmail.com     
 * 修改时间：2019年6月5日 上午9:37:57    
 * 修改备注：       
 * @version </pre>    
 */
@Service("productService")
public class ProductServiceImpl implements IProductService {
	
	@Autowired
	private IProductMapper productMapper;
	@Autowired
	private IBrandMapper brandMapper;
	@Value("${api.product.hot.list.url}")
	private String hot_product_url;

	/* (non-Javadoc)    
	 * @see com.fh.shop.biz.product.IProductService#addProduct(com.fh.shop.po.product.Product)    
	 */
	@Override
	public void addProduct(Product product)  {
		productMapper.addProduct(product);
	}

	public DataTableResult findProductPageList(ProductSearchParam productSearchParam) {
		// 获取总条数
		long totalCount = productMapper.findProductListCount(productSearchParam);
		// 获取分页列表
		List<Product> productList = productMapper.findProductList(productSearchParam);
		// 将List<Product>转换为List<Map>,目的就是要对日期做特殊处理
		List<Map> resultList = convertListMap(productList);
		// 组装数据
		DataTableResult dataTableResult = new DataTableResult(productSearchParam.getDraw(), totalCount, resultList);
		return dataTableResult;
	}

	@Override
	public void deleteProduct(Integer id) {
		productMapper.deleteProduct(id);
	}

	@Override
	public ProductVo findProduct(Integer id) {
		Product product = productMapper.findProduct(id);
		// po转vo
		ProductVo productVo = convertProductVo(product);
		return productVo;
	}

	@Override
	public void updateProduct(Product product) {
		String mainImagePath = product.getMainImagePath();
		if (StringUtils.isEmpty(mainImagePath)) {
			// 证明没有上传新图
			product.setMainImagePath(product.getOldMainImagePath());
		} else {
			// 证明上传新图,删除旧图
			OSSUtil.deleteFile(product.getOldMainImagePath());
		}
		productMapper.updateProduct(product);
	}

    @Override
    public void deleteBatch(List<Integer> ids) {
		productMapper.deleteBatch(ids);
    }

    @Override
    public List<Product> findProductList(ProductSearchParam productSearchParam) {
		List<Product> allProductList = productMapper.findAllProductList(productSearchParam);
		return allProductList;
    }

    @Override
    public void importExcel(String path){
		// 查询品牌列表
		List<Brand> brandList = brandMapper.findAllBrandList();
		// 将excel文件转换为workbook
		Workbook workbook = buildWorkBook(path);
		// 插入数据库
		insertDB(brandList, workbook);
		// 删除文件，释放硬盘空间
		FileUtil.deleteFile(path);
	}

    @Override
    public String buildHtmlContent(ProductSearchParam productSearchParam) {
		// 根据条件动态查询数据
		List<Product> productList = findProductList(productSearchParam);
		// 构建模板数据
		Map data = buildData(productList);
		// 生成模板对应的html
		String htmlContent = FileUtil.buildPdfHtml(data, SystemConstant.PRODUCT_PDF_TEMPLATE_FILE, SystemConstant.TEMPLATE_PATH);
		// 返回html
		return htmlContent;
    }

	@Override
	public File buildWordFile(ProductSearchParam productSearchParam) {
		// 根据条件动态查询数据
		List<Product> productList = findProductList(productSearchParam);
		// 构建数据
		Map resultMap = buildWordData(productList);
		// 转换为指定的格式
		File file = FileUtil.buildWord(resultMap, SystemConstant.PRODUCT_WORD_TEMPLATE_FILE, SystemConstant.TEMPLATE_PATH, SystemConstant.WORD_SAVE_PATH);
		return file;
	}

	@Override
	public Workbook buildWorkbook(ProductSearchParam productSearchParam) {
		// 根据条件动态查询数据
		List<Product> productList = findProductList(productSearchParam);
		// 将其转换为workbook
		XSSFWorkbook workbook = buildWorkBook(productList);
		return workbook;
	}

	@Override
	public void updateProductStatus(int id, int status) {
		productMapper.updateProductStatus(id, status);
	}

    @Override
    public ServerResponse findHotList() {
		String result = HttpClientUtil.sendGet(hot_product_url, null);
		if (StringUtils.isNotEmpty(result)) {
			return JSONObject.parseObject(result, ServerResponse.class);
		} else {
			return ServerResponse.error();
		}
    }

    private XSSFWorkbook buildWorkBook(List<Product> productList) {
		XSSFWorkbook workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet("商品列表【"+productList.size()+"】");
		// 构建大标题
		buildTitle(sheet, workbook);
		// 构造标题行
		buildHeader(sheet);
		// 构造内容
		buildBody(productList, sheet, workbook);
		return workbook;
	}

	private void buildTitle(XSSFSheet sheet, XSSFWorkbook workbook) {
		XSSFRow row = sheet.createRow(3);
		XSSFCell cell = row.createCell(7);
		cell.setCellValue("商品列表");
		CellRangeAddress cellRangeAddress = new CellRangeAddress(3, 5, 7, 10);
		sheet.addMergedRegion(cellRangeAddress);
		// 构建一个样式
		XSSFCellStyle cellStyle = buildTitleStyle(workbook);
		// 设置样式
		cell.setCellStyle(cellStyle);
	}

	private XSSFCellStyle buildTitleStyle(XSSFWorkbook workbook) {
		// 通过workbook创建了样式
		XSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 通过workbook创建了字体
		XSSFFont font = workbook.createFont();
		// 加粗
		font.setBold(true);
		font.setFontHeightInPoints((short) 22);
		font.setColor(HSSFColor.RED.index);
		// 将单元格样式和字体合二为一
		cellStyle.setFont(font);
		// 背景色
		cellStyle.setFillForegroundColor(HSSFColor.BLUE.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		return cellStyle;
	}

	private void buildBody(List<Product> productList, XSSFSheet sheet, XSSFWorkbook wb) {
		XSSFCellStyle dateStyle = wb.createCellStyle();
		// 日期格式
		dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
		for (int i = 0; i < productList.size(); i++) {
			Product product = productList.get(i);
			XSSFRow row = sheet.createRow(i + 7);
			row.createCell(7).setCellValue(product.getProductName());
			row.createCell(8).setCellValue(product.getBrand().getBrandName());
			row.createCell(9).setCellValue(product.getProductPrice());
			XSSFCell cell = row.createCell(10);
			cell.setCellValue(product.getCreateDate());
			cell.setCellStyle(dateStyle);
		}
	}

	private void buildHeader(XSSFSheet sheet) {
		XSSFRow row = sheet.createRow(6);
		String[] titles = {"产品名", "品牌名", "价格", "生产日期"};
		for (int i = 0; i < titles.length; i++) {
			row.createCell(i+7).setCellValue(titles[i]);
		}
	}

	private Map buildWordData(List<Product> productList) {
		Map resultMap = new HashMap();
		resultMap.put("products", productList);
		return resultMap;
	}

	private Map buildData(List<Product> productList) {
		Map data = new HashMap();
		data.put("companyName", SystemConstant.COMPANY_NAME);
		data.put("products", productList);
		data.put("createDate", DateUtil.date2str(new Date(), DateUtil.Y_M_D));
		return data;
	}

	private void insertDB(List<Brand> brandList, Workbook workbook) {
		// 获取sheet
		Sheet sheet = workbook.getSheetAt(0);
		// 获取开始行，结束行
		int firstRowNum = sheet.getFirstRowNum();
		int lastRowNum = sheet.getLastRowNum();
		List productList = new ArrayList();
		for (int i = firstRowNum+1; i <= lastRowNum; i++) {
				Product product = convertProductPo(sheet, i, brandList);
				// 分段批量提交
				productList.add(product);
				if (productList.size() == SystemConstant.BATCH_SIZE) {
					// 批量提交
					productMapper.addBatchProduct(productList);
					productList = new ArrayList();
				}
		}
		// 处理小尾巴
		if (productList.size() > 0) {
			// 批量提交
			productMapper.addBatchProduct(productList);
		}
	}



	private Workbook buildWorkBook(String path) {
		Workbook workbook = null;
		try {
				if (path.endsWith("xlsx")) {
					workbook = new XSSFWorkbook(new FileInputStream(path));
				} else {
					workbook = new HSSFWorkbook(new FileInputStream(path));
				}

		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		return workbook;
	}

	private Product convertProductPo(Sheet sheet, int i, List<Brand> brandList) {
		Row row = sheet.getRow(i);
		String productName = row.getCell(0).getStringCellValue();
		double price = row.getCell(1).getNumericCellValue();
		String brandName = row.getCell(2).getStringCellValue();
		// 根据品牌名获取对应品牌id
		int brandId = buildBrandId(brandName, brandList);
		Date createDate = row.getCell(3).getDateCellValue();
		// 转换po
		Product product = new Product();
		product.setProductName(productName);
		product.setProductPrice((float) price);
		product.getBrand().setId(brandId);
		product.setCreateDate(createDate);
		return product;
	}

	private int buildBrandId(String brandName, List<Brand> brandList) {
		for (Brand brand : brandList) {
			if (brand.getBrandName().equals(brandName)) {
				return brand.getId();
			}
		}
		Brand brand = new Brand();
		brand.setBrandName(brandName);
		// 证明没有匹配的品牌，先插入品牌，再获取品牌id
		brandMapper.addBrand(brand);
		Integer id = brand.getId();
		// 特别重要！！！
		brandList.add(brand);
		return id;
	}

	private ProductVo convertProductVo(Product product) {

		ProductVo productVo = new ProductVo();
		productVo.setId(product.getId());
		productVo.setProductName(product.getProductName());
		productVo.setProductPrice(product.getProductPrice());
		productVo.setCreateDate(DateUtil.date2str(product.getCreateDate(), DateUtil.Y_M_D));
		productVo.setBrandId(product.getBrand().getId());
		productVo.setGc1(product.getGc1());
		productVo.setGc2(product.getGc2());
		productVo.setGc3(product.getGc3());
		productVo.setCategoryName(product.getCategoryName());
		productVo.setIsHot(product.getIsHot());
		productVo.setMainImagePath(product.getMainImagePath());
		return productVo;
	}




	private List<Map> convertListMap(List<Product> productList) {
		List<Map> resultList = new ArrayList();
		for (Product product : productList) {
			Map item = new HashMap();
			item.put("productId", product.getId());
			item.put("productName", product.getProductName());
			item.put("productPrice", product.getProductPrice());
			item.put("createDate", DateUtil.date2str(product.getCreateDate(), DateUtil.Y_M_D));
			item.put("brandName", product.getBrand().getBrandName());
			item.put("categoryName", product.getCategoryName());
			item.put("mainImagePath", product.getMainImagePath());
			item.put("isHot", product.getIsHot());
			item.put("status", product.getStatus());
			resultList.add(item);
		}
		return resultList;
	}

}
