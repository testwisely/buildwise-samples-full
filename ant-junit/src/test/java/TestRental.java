import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

public class TestRental{

    @BeforeAll
    static void setup() {
        Library.importResource();
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

    @DisplayName("Failed Rental")
    @Test
    void testFailed() {

        assertEquals("Book",  "Invalid");

    }
}
