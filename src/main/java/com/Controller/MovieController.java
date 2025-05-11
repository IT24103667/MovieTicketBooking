package com.Controller;

import com.Model.Movie;
import com.Service.MovieService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MovieController", value = "/movies")
public class MovieController extends HttpServlet {
    private final MovieService movieService = new MovieService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Movie> movies = movieService.getAllMovies();
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/movie.jsp").forward(request, response);
    }
}