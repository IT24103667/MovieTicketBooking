package com.Controller;

import com.Model.Movie;
import com.Model.Review;
import com.Model.User;
import com.Service.ReviewService;
import com.Service.MovieService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "EditReviewController", value = "/editReview")
public class EditReviewController extends HttpServlet {
    private final ReviewService reviewService = new ReviewService();
    private final MovieService movieService = new MovieService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Authentication check
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String reviewId = request.getParameter("reviewId");

        // Parameter validation
        if (reviewId == null || reviewId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Review ID is required");
            return;
        }

        Review review = reviewService.getAllReviews().stream()
                .filter(r -> r.getReviewId().equals(reviewId))
                .findFirst()
                .orElse(null);

        // Authorization check
        if (review == null || !review.getUserName().equals(currentUser.getUsername())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You can only edit your own reviews");
            return;
        }

        // Get movie details for the poster
        Movie movie = movieService.getAllMovies().stream()
                .filter(m -> m.getId().equals(review.getMovieId()))
                .findFirst()
                .orElse(null);

        request.setAttribute("review", review);
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("/editReview.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Authentication check
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if (!"update".equals(action)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            return;
        }

        String reviewId = request.getParameter("reviewId");
        String reviewText = request.getParameter("reviewText");
        int rating = Integer.parseInt(request.getParameter("rating"));

        // Validate rating range
        if (rating < 1 || rating > 5) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Rating must be between 1-5");
            return;
        }

        // Verify review exists and belongs to user
        Review existingReview = reviewService.getAllReviews().stream()
                .filter(r -> r.getReviewId().equals(reviewId))
                .findFirst()
                .orElse(null);

        if (existingReview == null || !existingReview.getUserName().equals(currentUser.getUsername())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You can only update your own reviews");
            return;
        }

        // Update review
        Review updatedReview = new Review(
                existingReview.getReviewId(),
                existingReview.getMovieId(),
                existingReview.getMovieTitle(),
                reviewText,
                existingReview.getAuthor(),
                existingReview.getUserName(),
                rating
        );

        boolean success = reviewService.updateReview(updatedReview);

        if (success) {
            response.setContentType("application/json");
            response.getWriter().write("{\"status\":\"success\"}");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update review");
        }
    }
}