package com.fh.shop.common;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class WebContextFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // 在每次发送请求时，先将当前请求存入webContext中
        WebContext.setRequest((HttpServletRequest) servletRequest);
        try {
        // 继续进行后续的访问
        filterChain.doFilter(servletRequest, servletResponse);
    } finally {
        // 请求处理完后，将其从webContext中移除
        WebContext.remove();
    }
}

    @Override
    public void destroy() {

    }
}
