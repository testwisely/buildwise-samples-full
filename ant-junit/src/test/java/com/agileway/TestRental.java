package com.agileway;

import org.junit.jupiter.api.*;

import static org.junit.jupiter.api.Assertions.*;

import com.agileway.*;

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
    void testIsActive() {
        Rental rental = new Rental();
        assertEquals(false, rental.isActive());
    }
}
