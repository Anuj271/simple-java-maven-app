package com.mycompany.app;

import java.io.IOException;
import java.io.OutputStream;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;
import java.net.InetSocketAddress;

public class App {

    private static final String MESSAGE = "Hello Anuj!";

    public App() {}

    // Keep this method so tests pass
    public String getMessage() {
        return MESSAGE;
    }

    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);
        server.createContext("/", new HttpHandler() {
            public void handle(HttpExchange exchange) throws IOException {
                String response = new App().getMessage(); // use getMessage()
                exchange.sendResponseHeaders(200, response.getBytes().length);
                OutputStream os = exchange.getResponseBody();
                os.write(response.getBytes());
                os.close();
            }
        });
        server.setExecutor(null);
        server.start();
        System.out.println("Server started at http://localhost:8080");
    }
}