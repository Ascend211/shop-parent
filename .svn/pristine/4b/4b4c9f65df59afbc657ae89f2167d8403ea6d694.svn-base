package com.fh.shop.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.common.IgnoreCheck;
import com.fh.shop.po.user.User;
import com.fh.shop.util.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("拦截器");
        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod();
        if (method.isAnnotationPresent(IgnoreCheck.class)) {
            return true;
        }
        //User user = (User) request.getSession().getAttribute(SystemConstant.CURR_USER);
        String sessionId = DistributedSessionUtil.getSessionId(request, response, SystemConstant.COOKIE_NAME, SystemConstant.DOMAIN);
        String userJson = RedisUtil.get(KeyUtil.buildUserKey(sessionId));
        String servletPath = request.getServletPath();
        String requestURI = request.getRequestURI();
        StringBuffer requestURL = request.getRequestURL();
        System.out.println(servletPath+":"+requestURI+":"+requestURL);
        if (StringUtils.isEmpty(userJson)) {
            // 如果是ajax请求
//            String header = request.getHeader("X-Requested-With");
//            if (StringUtils.isNotEmpty(header) && header.equalsIgnoreCase("XMLHttpRequest")) {
//                response.setHeader("ajaxTimeout", "timeout");
//                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//                return false;
//            }
            // 跳转
            response.sendRedirect(SystemConstant.LOGIN_PAGE_URL);
            // 拦截，不放行
            return false;
        } else {
            // 续命
            RedisUtil.expire(KeyUtil.buildUserKey(sessionId), SystemConstant.USER_EXPIRE);
            User user = JSONObject.parseObject(userJson, User.class);
            request.getSession().setAttribute(SystemConstant.CURR_USER, user);
            return true;
        }
    }
}
