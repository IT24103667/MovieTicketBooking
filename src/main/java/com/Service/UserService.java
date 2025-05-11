package com.Service;

import com.Model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

public class UserService {
    public static final String FILE_PATH = "./db/Users.txt";

    static {
        try {
            File file = new File(FILE_PATH);
            if (!file.exists()) {
                file.getParentFile().mkdirs(); // Create parent directories if needed
                file.createNewFile();
                System.out.println("Created new user data file at: " + file.getAbsolutePath());
            }
        } catch (IOException e) {
            System.err.println("Failed to initialize user data file: " + e.getMessage());
        }
    }

    // Thread-safe user registration
    public synchronized boolean registerUser(User user) {
        try {
            // Validate input
            if (user.getEmail() == null || user.getEmail().isEmpty() ||
                    user.getPassword() == null || user.getPassword().isEmpty()) {
                return false;
            }
            // Check if email already exists
            if (emailExists(user.getEmail())) {
                return false;
            }

            // Hash password before storing
            user.setId(getNextId());
            user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));

            // Write to file
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(user.toString());
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            System.err.println("Registration failed: " + e.getMessage());
            return false;
        }
    }

    // Get all users (thread-safe)
    public synchronized List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                users.add(User.fromString(line));
            }
        } catch (IOException e) {
            System.err.println("Error reading user data: " + e.getMessage());
        }
        return users;
    }

    // Authenticate user
    public User authenticate(String email, String password) {
        List<User> users = getAllUsers();
        for (User user : users) {
            if (user.getEmail().equals(email) && BCrypt.checkpw(password, user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    // Check if email exists
    private boolean emailExists(String email) {
        return getAllUsers().stream().anyMatch(u -> u.getEmail().equals(email));
    }

    // Get next available ID
    private int getNextId() {
        List<User> users = getAllUsers();
        if (users.isEmpty()) {
            return 1;
        }
        return users.get(users.size() - 1).getId() + 1;
    }
}