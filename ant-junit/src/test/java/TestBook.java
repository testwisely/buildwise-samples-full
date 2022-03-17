import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestBook {

    @BeforeAll
    static void setup() {
    }

    @BeforeEach
    void init() {
    }

    @AfterEach
    void tearDown() {
    }

    @AfterAll
    static void done() {
    }

    @DisplayName("Get Title")
    @Test
    void testGetTitle() {
        Book one = new Book("Practical Continuous Testing");
        assertEquals("Practical Continuous Testing", one.getTitle());
    }
}
