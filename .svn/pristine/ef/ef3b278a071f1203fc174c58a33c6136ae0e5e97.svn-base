package com.fh.shop.controller.log;

import com.fh.shop.biz.log.ILogService;
import com.fh.shop.param.log.LogSearchParam;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

@Controller
@RequestMapping("/log")
public class LogController {

    @Resource(name = "logService")
    private ILogService logService;

    @RequestMapping("/index")
    public String index() {
        return "log/index";
    }

    @RequestMapping("/logdata")
    @ResponseBody
    public Map findLogData(LogSearchParam logSearchParam) {
        Map logData = logService.findLogData(logSearchParam);
        return logData;
    }
}
