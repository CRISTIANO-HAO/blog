package com.ssm.blog.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;

public class CacheFilter implements Filter {

    private FilterConfig config  = null;
    private HashMap expiresMap = new HashMap();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.config = filterConfig;
        expiresMap.clear();
        Enumeration names = config.getInitParameterNames();
        while( names.hasMoreElements() ) {
            try {
                String name = (String)names.nextElement();
                String value = config.getInitParameter( name );
                Integer expire = Integer.valueOf( value );
                expiresMap.put( name, expire );
            }
            catch( Exception ex) {
            }
        }
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse res = (HttpServletResponse) servletResponse;

        String uri = req.getRequestURI();
        String ext = null;
        int dot =  uri.lastIndexOf(".");
        if( dot != -1 ) {
            ext = uri.substring( dot+1 );
        }
        setResponseHeader( res, uri, ext );
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }

    protected FilterConfig getFilterConfig() {
        return (config);
    }


    private void setResponseHeader( HttpServletResponse response, String uri, String ext ) {
        if( ext!= null && ext.length() > 0 ) {
            Integer expires = (Integer)expiresMap.get(ext);
            if( expires != null ) {

                if( expires.intValue() > 0 ) {
                    response.setHeader("Cache-Control","max-age=" + expires.intValue()); //HTTP 1.1
                } else {
                    response.setHeader("Cache-Control","no-cache");
                    response.setHeader("Pragma","no-cache"); //HTTP 1.0
                    response.setDateHeader ("Expires", 0 );
                }
            }
        }
    }

}
