import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

public class TestLibrary {

    @BeforeAll
    static void setup() {
        Library.importResource();
        assertEquals(1, Library.GetResourcesCount());
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

    @DisplayName("Find Title")
    @Test
    void testFindTitle() {
        Resource james = Library.findByTitle("James");
        assertNull(james);
        Resource book = Library.findByTitle("Selenium WebDriver Recipes in Ruby");
        assertNotNull(book);
        assertEquals("Book",  book.getClass().getName());

    }
}
