package bl; // Assicurati che il pacchetto sia corretto

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeBean {

    @GetMapping("/")
    public String home() {
        return "Hello, World! Welcome to the Photo Event Backend.";
    }
}
