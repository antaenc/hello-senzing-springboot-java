package com.senzing.senzingdemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SenzingDemoApplication {

	public static void main(String[] args) {
		System.out.println("**********************PATH VALUE: " + System.getenv("PATH"));
		System.out.println("**********************Java Library Value: " + System.getProperty("java.library.path"));
		System.out.println("**********************DYLD Env Value: " + System.getenv("DYLD_LIBRARY_PATH"));
		System.out.println("**********************DYLD Value: " + System.getProperty("DYLD_LIBRARY_PATH"));
		System.out.println("**********************FOO Value: " + System.getenv("FOO"));

		SpringApplication.run(SenzingDemoApplication.class, args);
	}
}
