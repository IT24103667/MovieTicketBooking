package com.Controller;

import com.Model.Movie;
import com.Model.User;
import com.Service.MovieService;
import com.Service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminController", value = "/admin")
public class AdminController extends HttpServlet {
    private MovieService movieService = new MovieService();
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Redirect to login if not authenticated or not admin
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get all movies and users for the admin dashboard
        List<Movie> movies = movieService.getAllMovies();
        List<User> users = userService.getAllUsers();

        request.setAttribute("movies", movies);
        request.setAttribute("users", users);
        request.setAttribute("admin", user); // Pass admin data to JSP

        request.getRequestDispatcher("/userDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        // Verify admin privileges
        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if (action.equals("deleteMovie")) {
                handleDeleteMovie(request, response);
            } else {
                request.setAttribute("error", "Invalid action");
                doGet(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Operation failed: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void handleDeleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieId = request.getParameter("movieId");
        boolean success = movieService.deleteMovie(movieId);

        if (success) {
            request.setAttribute("success", "Movie deleted successfully");
        } else {
            request.setAttribute("error", "Failed to delete movie");
        }
        doGet(request, response);
    }
}