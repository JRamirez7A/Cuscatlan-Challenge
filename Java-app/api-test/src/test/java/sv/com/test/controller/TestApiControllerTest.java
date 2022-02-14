package sv.com.test.controller;

import static org.junit.jupiter.api.Assertions.*;

import java.net.URI;
import java.net.URISyntaxException;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class TestApiControllerTest {
	
	@Autowired
	private TestRestTemplate restTemplate;
	@LocalServerPort
	int randomServerPort;

	@BeforeEach
	void setUp() throws Exception {
		MockitoAnnotations.openMocks(this);
	}

	@Test
	void fillOTPControllerGenerar_Test() throws URISyntaxException {
		final String address = "http://localhost:"+randomServerPort+"/api/test/";
		URI url = new URI(address);
		ResponseEntity<String> result = this.restTemplate.getForEntity(url, String.class);
		assertNotEquals(HttpStatus.ACCEPTED, result.getStatusCode());
	}

}
