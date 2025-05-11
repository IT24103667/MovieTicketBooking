package com.Service;

import com.Model.Review;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ReviewService {
    private static final String FILE_PATH = "./db/Reviews.txt";

    public boolean addReview(Review review) {
        try {
            File file = new File(FILE_PATH);

            // Create parent directories if needed
            if (!file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                writer.write(review.toString());
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error saving review:");
            e.printStackTrace();
            return false;
        }
    }

    public List<Review> getReviewsForMovie(String movieId) {
        List<Review> reviews = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) return reviews;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 7 && parts[1].equals(movieId)) {  // Changed index to 1 for movieId
                    reviews.add(new Review(
                            parts[0],  // reviewId
                            parts[1],  // movieId
                            parts[2],  // movieTitle
                            parts[3],  // reviewText
                            parts[4],  // author
                            parts[5],  // userName
                            Integer.parseInt(parts[6]) // rating
                    ));
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading reviews:");
            e.printStackTrace();
        }
        return reviews;
    }

    public boolean deleteReviewsForMovie(String movieId) {
        List<Review> allReviews = getAllReviews();
        List<Review> filteredReviews = allReviews.stream()
                .filter(r -> !r.getMovieId().equals(movieId))
                .toList();

        return writeAllReviews(filteredReviews);
    }

    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) return reviews;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 7) {
                    reviews.add(new Review(
                            parts[0],  // reviewId
                            parts[1],  // movieId
                            parts[2],  // movieTitle
                            parts[3],  // reviewText
                            parts[4],  // author
                            parts[5],  // userName
                            Integer.parseInt(parts[6]) // rating
                    ));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    private boolean writeAllReviews(List<Review> reviews) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Review review : reviews) {
                writer.write(review.toString());
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReview(String reviewId) {
        List<Review> allReviews = getAllReviews();
        List<Review> updatedReviews = allReviews.stream()
                .filter(review -> !review.getReviewId().equals(reviewId))
                .collect(Collectors.toList());

        if (updatedReviews.size() == allReviews.size()) {
            return false; // No review was deleted
        }
        return writeAllReviews(updatedReviews);
    }

    public boolean updateReview(Review updatedReview) {
        List<Review> allReviews = getAllReviews();
        boolean found = false;

        for (int i = 0; i < allReviews.size(); i++) {
            if (allReviews.get(i).getReviewId().equals(updatedReview.getReviewId())) {
                allReviews.set(i, updatedReview);
                found = true;
                break;
            }
        }

        if (!found) {
            return false;
        }

        return writeAllReviews(allReviews);
    }
}