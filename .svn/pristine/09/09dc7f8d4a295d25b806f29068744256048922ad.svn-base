package com.fh.shop.biz.log;

import com.fh.shop.mapper.log.ILogMapper;
import com.fh.shop.param.log.LogSearchParam;
import com.fh.shop.po.log.Log;
import com.fh.shop.po.product.Product;
import com.fh.shop.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("logService")
public class ILogServiceImpl implements ILogService {
    @Autowired
    private ILogMapper logMapper;

    @Override
    public void addLog(Log log) {
        logMapper.addLog(log);
    }

    @Override
    public Map findLogData(LogSearchParam logSearchParam) {
        // 获取总条数
        int count = logMapper.findLogCount(logSearchParam);
        // 获取分页列表
        List<Log> logList = logMapper.findLogList(logSearchParam);
        // 组装数据
        List<Map> dataList = convertListMap(logList);
        Map resultMap = new HashMap();
        resultMap.put("draw", logSearchParam.getDraw());
        resultMap.put("recordsTotal", count);
        resultMap.put("recordsFiltered", count);
        resultMap.put("data", dataList);
        return resultMap;
    }

    private List<Map> convertListMap(List<Log> logList) {
        List<Map> resultList = new ArrayList();
        for (Log log : logList) {
            Map item = new HashMap();
            item.put("userName", log.getUserName());
            item.put("info", log.getInfo());
            item.put("createDate", DateUtil.date2str(log.getCreateDate(), DateUtil.FULL_TIME));
            item.put("status", log.getStatus());
            item.put("detailInfo", log.getDetailInfo());
            item.put("content", log.getContent());
            resultList.add(item);
        }
        return resultList;
    }
}
