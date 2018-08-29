package com.senzing.senzingdemo;

import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SenzingDemoApplicationTests {

	@BeforeClass
	public static void setup() {
		System.out.println("**********************PATH VALUE: " + System.getenv("PATH"));
		System.out.println("**********************Java Library Value: " + System.getProperty("java.library.path"));
		System.out.println("**********************DYLD Env Value: " + System.getenv("DYLD_LIBRARY_PATH"));
		System.out.println("**********************DYLD Value: " + System.getProperty("DYLD_LIBRARY_PATH"));
		System.out.println("**********************FOO Value: " + System.getenv("FOO"));
	}

	@Test
	public void contextLoads() {

	}

}
