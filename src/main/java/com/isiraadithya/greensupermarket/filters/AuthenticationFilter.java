package com.isiraadithya.greensupermarket.filters;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthenticationFilter implements Filter {
    private String contextPath;
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        contextPath = filterConfig.getServletContext().getContextPath();
        System.out.println("Context Path: " + contextPath);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;
        String requestPath = req.getRequestURI();

        if (req.getSession().getAttribute("isLoggedIn") != null){
            if(requestPath.contains("admin/") && !requestPath.contains("/login")){
                if (!req.getSession().getAttribute("role").equals("admin")){
                    res.sendRedirect("/admin/login.jsp?err=Unauthorized");
                }
            }
            filterChain.doFilter(servletRequest, servletResponse);
        } else {
            if (requestPath.contains("/login")){
                filterChain.doFilter(servletRequest, servletResponse);
            } else {
                res.sendRedirect("/login.jsp?err=Unauthorized");
            }
        }
    }
}
