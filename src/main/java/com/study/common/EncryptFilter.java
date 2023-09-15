package com.study.common;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter(urlPatterns = "/*")
public class EncryptFilter extends HttpFilter implements Filter {

    public EncryptFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        PasswordEncoding pew=new PasswordEncoding((HttpServletRequest)request);


        // pass the request along the filter chain
        chain.doFilter(pew, response);
    }

    public void init(FilterConfig fConfig) throws ServletException {
        // TODO Auto-generated method stub
    }
}
