package com.Controller;

import com.Model.Movie;
import com.Model.User;
import com.Service.MovieService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserController", value = "/user")
public class UserController extends HttpServlet {
    private MovieService movieService = new MovieService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Redirect to login if not authenticated
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get movies for the dashboard
        List<Movie> movies = movieService.getAllMovies();
        request.setAttribute("movies", movies);
        request.setAttribute("user", user); // Pass user data to JSP

        request.getRequestDispatcher("/userDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle user-specific actions (e.g., bookings)
        // Example:
        String action = request.getParameter("action");
        if ("book".equals(action)) {
            String movieId = request.getParameter("movieId");
            // Add booking logic here
        }

        response.sendRedirect(request.getContextPath() + "/user-dashboard");
    }
}