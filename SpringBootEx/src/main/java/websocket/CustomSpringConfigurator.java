package websocket;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import jakarta.servlet.ServletContext;
import jakarta.websocket.server.ServerEndpointConfig;
import websocket.util.ServletContextHolder;

public class CustomSpringConfigurator extends ServerEndpointConfig.Configurator {
	@Override
	public <T> T getEndpointInstance( Class<T> endpointClass ) throws InstantiationException {
		ServletContext servletContext = ServletContextHolder.getServletContext();
        WebApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
		return ctx.getAutowireCapableBeanFactory().createBean( endpointClass );
	}
}
