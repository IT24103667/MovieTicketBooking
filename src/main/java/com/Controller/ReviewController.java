package com.Controller;

import com.Model.Movie;
import com.Model.Review;
import com.Model.User;
import com.Service.MovieService;
import com.Service.ReviewService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/reviews")
public class ReviewController extends HttpServlet {
    private final ReviewService reviewService = new ReviewService();
    private final MovieService movieService = new MovieService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String movieId = request.getParameter("movieId");

        if (movieId == null || movieId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing movieId parameter");
            return;
        }

        Movie movie = movieService.getMovieById(movieId);
        if (movie == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found");
            return;
        }

        List<Review> reviews = reviewService.getReviewsForMovie(movieId);

        request.setAttribute("movie", movie);
        request.setAttribute("reviews", reviews);

        // Verify the JSP path
        String jspPath = "/review.jsp";

        request.getRequestDispatcher(jspPath).forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String movieId = request.getParameter("movieId");
            String movieTitle = request.getParameter("movieTitle");
            String reviewText = request.getParameter("reviewText");
            String author = request.getParameter("author"); // Display name from input
            String userName = request.getParameter("userName"); // Logged-in username
            int rating = Integer.parseInt(request.getParameter("rating"));


            Review review = new Review(movieId, movieTitle, reviewText, author, userName, rating);

            if (reviewService.addReview(review)) {
                response.sendRedirect(request.getContextPath() + "/reviews?movieId=" + movieId + "&success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/reviews?movieId=" + movieId + "&error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing review");
        }
    }
}