package com.isiraadithya.greensupermarket.filters;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class CSRFFilter implements Filter {
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
        String HOST_URL = "http://localhost";

//        In production servers, HOST_URL should be loaded through Environment variables
        try {
            if (System.getenv("PROD").equals("TRUE")){
                HOST_URL = System.getenv("HOST_URL");
            }
        } catch (Exception ignore){
        }

        if (req.getMethod().equalsIgnoreCase("GET") || req.getMethod().equalsIgnoreCase("HEAD")){
            filterChain.doFilter(servletRequest, servletResponse);
        } else {
            String origin = req.getHeader("Origin");
            String referer = req.getHeader("Referer");
            if ((origin != null) && referer != null){
                if (origin.startsWith(HOST_URL) && referer.startsWith(HOST_URL)){
                    filterChain.doFilter(servletRequest, servletResponse);
                } else {
                    res.getWriter().print("CSRF Error");
                    res.setStatus(401);
                    return;
                }
            } else {
                res.getWriter().print("CSRF Error");
                res.setStatus(401);
                return;
            }
        }
    }
}
