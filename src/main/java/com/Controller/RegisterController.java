package com.Controller;

import com.Model.User;
import com.Service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private UserService userService = new UserService();

    // Show registration form
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Clear any existing error messages
        request.removeAttribute("error");
        // Forward to register.jsp
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    // Process registration form submission
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form data
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");

        // Create user object
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);
        user.setPhone(phone);

        // Register user
        boolean success = userService.registerUser(user);

        if (success) {
            // Redirect to login page with success message
            response.sendRedirect(request.getContextPath() + "/login?registration=success");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}