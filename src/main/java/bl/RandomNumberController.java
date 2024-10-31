package bl;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@RestController
public class RandomNumberController {

    private final Random random = new Random();

    @GetMapping("/random-number")
    public Map<String, Object> getRandomNumber() {
        int randomNumber = random.nextInt(100); // Restituisce un numero casuale tra 0 e 99
        Map<String, Object> response = new HashMap<>();
        response.put("number", randomNumber);
        response.put("message", "Ecco un numero casuale!");
        return response;
    }
}
