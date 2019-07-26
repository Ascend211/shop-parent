package com.fh.shop.controller.area;

import com.fh.shop.biz.area.IAreaService;
import com.fh.shop.common.LogMessage;
import com.fh.shop.common.ServerResponse;
import com.fh.shop.po.area.Area;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/area")
public class AreaController {

    @Resource(name = "areaService")
    private IAreaService areaService;

    @RequestMapping("/index")
    public String index() {
        return "/area/index";
    }

    @RequestMapping("/findList")
    @ResponseBody
    public ServerResponse findList() {
        List<Area> allAreaList = areaService.findAllAreaList();
        return ServerResponse.success(allAreaList);
    }

    @RequestMapping("/add")
    @ResponseBody
    @LogMessage("添加地区")
    public ServerResponse addArea(Area area) {
        areaService.addArea(area);
        return ServerResponse.success(area.getId());
    }

    @RequestMapping("/update")
    @ResponseBody
    @LogMessage("修改地区")
    public ServerResponse updateArea(Area area) {
        areaService.updateArea(area);
        return ServerResponse.success();
    }

    @RequestMapping("/delete")
    @ResponseBody
    @LogMessage("删除地区")
    public ServerResponse deleteArea(@RequestParam("ids[]") List<Integer> idList) {
        areaService.deleteArea(idList);
        return ServerResponse.success();
    }
}
