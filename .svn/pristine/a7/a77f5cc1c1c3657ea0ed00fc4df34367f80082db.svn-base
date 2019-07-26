package com.fh.shop.biz.category;

import com.fh.shop.mapper.category.ICategoryMapper;
import com.fh.shop.po.category.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("categoryService")
public class ICategoryServiceImpl implements ICategoryService {
    @Autowired
    private ICategoryMapper categoryMapper;

    @Override
    public List<Category> findChildCategoryList(Integer id) {
        List<Category> childCategoryList = categoryMapper.findChildCategoryList(id);
        return childCategoryList;
    }
}
