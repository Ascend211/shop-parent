package com.fh.shop.controller.brand;

import com.fh.shop.biz.brand.IBrandService;
import com.fh.shop.common.DataTableResult;
import com.fh.shop.common.ServerResponse;
import com.fh.shop.param.brand.BrandSearchParam;
import com.fh.shop.po.brand.Brand;
import com.mysql.fabric.Server;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/brand")
public class BrandController {

    @Resource(name="brandService")
    private IBrandService brandService;

    @RequestMapping("/findAll")
    @ResponseBody
    public ServerResponse findAllBrandList() {
        List<Brand> allBrandList = brandService.findAllBrandList();
        return ServerResponse.success(allBrandList);
    }

    @RequestMapping("/index")
    public String index() {
        return "/brand/list";
    }

    @RequestMapping("/toAdd")
    public String toAdd() {
        return "/brand/add";
    }
    @RequestMapping("/updateStatus")
    @ResponseBody
    public ServerResponse updateStatus(String status, int id ) {
        brandService.updateStatus(status, id);
        return ServerResponse.success();
    }

    @RequestMapping("/add")
    @ResponseBody
    public ServerResponse add(Brand brand) {
        brandService.addBrand(brand);
        return ServerResponse.success();
    }

    @RequestMapping("/list")
    @ResponseBody
    public DataTableResult findlist(BrandSearchParam brandSearchParam) {
        DataTableResult brandPageList = brandService.findBrandPageList(brandSearchParam);
        return brandPageList;
    }
}
