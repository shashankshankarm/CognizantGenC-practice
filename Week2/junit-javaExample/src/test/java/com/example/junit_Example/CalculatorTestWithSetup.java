package com.example.junit_Example;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.*;

public class CalculatorTestWithSetup {

    private Calculator calculator;

    @BeforeEach
    void initCalculator() {
        // Initialize a new Calculator instance before every test method
        calculator = new Calculator();
        System.out.println("Calculator instance created.");
    }

    @AfterEach
    void cleanUp() {
        // Release resources or perform cleanup tasks post test execution
        calculator = null;
        System.out.println("Calculator instance cleared.");
    }

    @Test
    void shouldReturnCorrectSumWhenAddingTwoNumbers() {
        // Act
        int result = calculator.add(3, 7);

        // Assert
        assertEquals(10, result);
    }

    @Test
    void shouldReturnCorrectDifferenceWhenSubtractingTwoNumbers() {
        int result = calculator.subtract(10, 4);
        assertEquals(6, result);
    }
}
