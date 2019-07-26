package com.fh.shop.controller.category;


import com.fh.shop.biz.category.ICategoryService;
import com.fh.shop.common.ServerResponse;
import com.fh.shop.po.category.Category;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/category")
public class CategoryController {
    @Resource(name = "categoryService")
    private ICategoryService categoryService;


     @RequestMapping("/findChildCategoryList")
     @ResponseBody
     public ServerResponse findChildCategoryList(Integer id) {
        List<Category> childCategoryList = categoryService.findChildCategoryList(id);
        return ServerResponse.success(childCategoryList);
     }

}
