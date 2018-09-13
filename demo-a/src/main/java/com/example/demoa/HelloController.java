package com.example.demoa;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class HelloController {
    private final RestTemplate restTemplate;

    public HelloController(RestTemplateBuilder builder, Config config) {
        this.restTemplate = builder.rootUri(config.getTarget()).build();
    }

    @GetMapping(path = "/")
    public String hello() {
        return "A" + this.restTemplate.getForObject("/", String.class);
    }
}
