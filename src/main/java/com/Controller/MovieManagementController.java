package com.Controller;

import com.Model.Movie;
import com.Service.MovieService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/manageMovie")
public class MovieManagementController extends HttpServlet {
    private MovieService movieService = new MovieService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        List<Movie> movies = movieService.getAllMovies();
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/manageMovie.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {


            Movie movie = new Movie(
                    UUID.randomUUID().toString(),
                    request.getParameter("title"),
                    request.getParameter("genre"),
                    request.getParameter("duration"),
                    request.getParameter("rating"),
                    request.getParameter("description"),
                    Integer.parseInt(request.getParameter("totalSeats")),
                    request.getParameter("showTimes"),
                    request.getParameter("imgLink")
            );
            movieService.addMovie(movie);
        } else if ("delete".equals(action)) {


            String movieId = request.getParameter("movieId");
            movieService.deleteMovie(movieId);
        }



        response.sendRedirect(request.getContextPath() + "/manageMovie");
    }
}