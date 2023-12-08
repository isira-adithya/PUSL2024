package com.isiraadithya.greensupermarket.filters;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthenticationFilter implements Filter {
    private String contextPath;
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        contextPath = filterConfig.getServletContext().getContextPath();
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;
        String requestPath = req.getRequestURI();

        if (requestPath.contains("/user/") || requestPath.contains("/admin/")){
            if (requestPath.contains("/login") || requestPath.contains("/signup") ){
                filterChain.doFilter(servletRequest, servletResponse);
                return;
            }
            if (req.getSession().getAttribute("isLoggedIn") != null){
                if(requestPath.contains("/admin/")){
                    if (!req.getSession().getAttribute("role").equals("admin")){
                        res.sendRedirect("/login.jsp?err=Unauthorized");
                    }
                }
                filterChain.doFilter(servletRequest, servletResponse);
                return;
            } else {
                res.sendRedirect("/login.jsp?err=Unauthorized");
            }
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

    }
}
