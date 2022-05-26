package com.agileway;
import com.agileway.*;

public class Main {

    public static void main(String[] args) {
        // write your code here
        Resource the_title = Library.findByTitle("ABC");
        System.out.println("the_title = " + the_title);
    }
}
