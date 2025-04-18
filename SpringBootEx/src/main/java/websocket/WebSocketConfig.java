package websocket;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import jakarta.websocket.server.ServerContainer;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.ServletContext;
import jakarta.websocket.DeploymentException;
import jakarta.websocket.server.ServerEndpointConfig;
import wordgame.WordServer;

import org.springframework.beans.factory.annotation.Autowired;

@Configuration
public class WebSocketConfig {

    @Autowired
    private ServletContext servletContext;

    @Bean
    public ServerEndpointExporter serverEndpointExporter() {
        System.out.println("✅ ServerEndpointExporter 등록됨!");
        return new ServerEndpointExporter();
    }

    @PostConstruct
    public void registerEndpoint() {
        try {
            System.out.println("✅ ChatServer 엔드포인트 등록 시도");
            ServerContainer serverContainer = 
                    (ServerContainer) servletContext.getAttribute("jakarta.websocket.server.ServerContainer");
            
            // 🔹 ChatServer 등록
            ServerEndpointConfig chatConfig = ServerEndpointConfig.Builder
                    .create(ChatServer.class, "/ChatingServer")
                    .configurator(new CustomSpringConfigurator())
                    .build();
            serverContainer.addEndpoint(chatConfig);
            System.out.println("✅ ChatServer 등록 완료!");

            // 🔹 WordServer 등록
            ServerEndpointConfig wordConfig = ServerEndpointConfig.Builder
                    .create(WordServer.class, "/WordGame")
                    .configurator(new CustomSpringConfigurator())
                    .build();
            serverContainer.addEndpoint(wordConfig);
            System.out.println("✅ WordServer 등록 완료!");
            
        } catch (DeploymentException e) {
            e.printStackTrace();
        }
    }
}