package com.Model;

import java.util.UUID;

public class Review {
    private String reviewId;  // Unique identifier for the review
    private String movieId;   // Reference to Movie
    private String movieTitle;
    private String reviewText;
    private String author;
    private String userName;
    private int rating;

    // Constructor with auto-generated reviewId
    public Review(String movieId, String movieTitle, String reviewText, String author, String userName, int rating) {
        this.reviewId = UUID.randomUUID().toString();  // Generate unique ID
        this.movieId = movieId;
        this.movieTitle = movieTitle;
        this.reviewText = reviewText;
        this.author = author;
        this.userName = userName;
        this.rating = rating;
    }

    // Constructor with existing reviewId (for loading from storage)
    public Review(String reviewId, String movieId, String movieTitle, String reviewText, String author, String userName, int rating) {
        this.reviewId = reviewId;
        this.movieId = movieId;
        this.movieTitle = movieTitle;
        this.reviewText = reviewText;
        this.author = author;
        this.userName = userName;
        this.rating = rating;
    }

    // Getters & Setters
    public String getReviewId() {
        return reviewId;
    }

    public String getMovieId() {
        return movieId;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public String getReviewText() {
        return reviewText;
    }

    public String getAuthor() {
        return author;
    }

    public int getRating() {
        return rating;
    }

    public String getUserName() {
        return userName;
    }

    // For file storage
    @Override
    public String toString() {
        return reviewId + "|" + movieId + "|" + movieTitle + "|" + reviewText + "|" + author + "|" + userName + "|" + rating;
    }

    // For star display
    public String getStarRating() {
        return "★".repeat(rating) + "☆".repeat(5 - rating);
    }
}