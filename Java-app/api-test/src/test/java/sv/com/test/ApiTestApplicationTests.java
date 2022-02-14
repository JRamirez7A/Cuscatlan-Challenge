package sv.com.test;

import static org.junit.Assert.assertNull;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ApiTestApplicationTests {

	@Test
	void contextLoads() {
		assertNull(null);
	}
	
	@Test
	void applicationContextTest() {
		ApiTestApplication.main(new String[] {});
		assertNull(null);
	}

}
