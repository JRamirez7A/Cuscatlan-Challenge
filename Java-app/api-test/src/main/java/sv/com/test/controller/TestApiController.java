package sv.com.test.controller;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/test")
@RestController
public class TestApiController {
	
	@GetMapping("/")
	public ResponseEntity<String> test() {
		String responseBody = "{\"result\": \"Hola Mundo !!\"}";
		return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(responseBody);
	}

}
