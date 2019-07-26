package com.fh.shop.aspect;

import com.fh.shop.biz.log.ILogService;
import com.fh.shop.common.LogMessage;
import com.fh.shop.common.WebContext;
import com.fh.shop.po.log.Log;
import com.fh.shop.po.user.User;
import com.fh.shop.util.SystemConstant;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.*;

public class LogAspect {

    private static final Logger LOGGER = LoggerFactory.getLogger(LogAspect.class);
    @Resource(name="logService")
    private ILogService logService;

    public Object doLog(ProceedingJoinPoint pjp) {
        HttpServletRequest request = WebContext.getRequest();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(SystemConstant.CURR_USER);
        String userName = user.getUserName();
        Object result = null;
        // 反射获取类名
        String canonicalName = pjp.getTarget().getClass().getCanonicalName();
        // 获取方法
        String name = pjp.getSignature().getName();
        // 获取详情
        String detailInfo = buildDetailInfo(request);
        // 获取方法签名
        MethodSignature methodSignature= (MethodSignature) pjp.getSignature();
        // 获取方法
        Method method = methodSignature.getMethod();
        String msg = "";
        // 判断方法上是否有指定的注解
        if (method.isAnnotationPresent(LogMessage.class)) {
            // 获取注解
            LogMessage annotation = method.getAnnotation(LogMessage.class);
            // 获取注解的内容
            msg = annotation.value();
        }
        try {
            LOGGER.info("{}开始执行了{}的{}()方法", userName, canonicalName, name);
            // pjp.proceed()：每个控制层中的每个方法
            // result:每个控制层中的每个方法的返回值
            result = pjp.proceed();
            LOGGER.info("执行"+canonicalName+"的"+name+"成功");
            LOGGER.info("{}执行{}的{}()方法成功", userName, canonicalName, name);
            // 插入日志
            String info = "执行了"+canonicalName+"的"+name+"方法";
            Log log = buildLog(userName, info, SystemConstant.LOG_SUCCESS, detailInfo, msg);
            logService.addLog(log);
        } catch (Throwable throwable) {
            LOGGER.error("{}执行{}的{}()方法失败:{}", userName, canonicalName, name, throwable.getMessage());
            // 插入日志
            String info = "执行了"+canonicalName+"的"+name+"方法失败:"+throwable.getMessage();
            if (info.length() > 2000) {
                info = info.substring(2000);
            }
            Log log = buildLog(userName, info, SystemConstant.LOG_ERROR, detailInfo, msg);
            logService.addLog(log);
            throw new RuntimeException(throwable);
        }
        return result;
    }

    private Log buildLog(String userName, String info, int status, String detail, String msg) {
        Log log = new Log();
        log.setCreateDate(new Date());
        log.setUserName(userName);
        log.setInfo(info);
        log.setStatus(status);
        log.setDetailInfo(detail);
        log.setContent(msg);
        return log;
    }


    private String buildDetailInfo(HttpServletRequest request) {
        StringBuffer sb = new StringBuffer();
        Map<String, String[]> parameterMap = request.getParameterMap();
        Iterator<Map.Entry<String, String[]>> iterator = parameterMap.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, String[]> entry = iterator.next();
            String key = entry.getKey();
            String[] value = entry.getValue();
            sb.append(key).append("=").append(StringUtils.join(value, ",")).append(";");
        }
        return sb.toString();
    }


    public static void main(String[] args) {
        buildMapInfo();
    }

    public static String buildMapInfo() {
        Map<String, String> result = new HashMap();
        result.put("userName", "zhangsan");
        result.put("age", "30");
        result.put("sex", "男");
        StringBuffer sb = new StringBuffer();
        // map循环遍历
        Iterator<Map.Entry<String, String>> iterator = result.entrySet().iterator();
        // 判断是否有下一个数据
        while (iterator.hasNext()) {
            // 获取下一个数据
            Map.Entry<String, String> next = iterator.next();
            // 获取key
            String key = next.getKey();
            // 获取value
            String value = next.getValue();
            sb.append(key).append("=").append(value).append(";");
        }
        return sb.toString();
    }


}
