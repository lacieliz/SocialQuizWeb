package websocket.util;

import jakarta.servlet.ServletContext;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

@Component
public class ServletContextHolder implements ServletContextAware {
    private static ServletContext servletContext;

    @Override
    public void setServletContext(ServletContext context) {
        servletContext = context;
    }

    public static ServletContext getServletContext() {
        return servletContext;
    }
}