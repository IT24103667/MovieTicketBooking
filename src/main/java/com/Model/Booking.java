package com.Model;

import java.io.Serializable;

public class Booking implements Serializable {
    private String id;
    private String movieId;
    private int userId;
    private int tickets;
    private String showTime;
    private double totalPrice;
    private transient Movie movie;

    public Booking() {
    }

    public Booking(String id, String movieId, int userId, int tickets, String showTime, double totalPrice) {
        this.id = id;
        this.movieId = movieId;
        this.userId = userId;
        this.tickets = tickets;
        this.showTime = showTime;
        this.totalPrice = totalPrice;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMovieId() {
        return movieId;
    }

    public void setMovieId(String movieId) {
        this.movieId = movieId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTickets() {
        return tickets;
    }

    public void setTickets(int tickets) {
        this.tickets = tickets;
    }

    public String getShowTime() {
        return showTime;
    }

    public void setShowTime(String showTime) {
        this.showTime = showTime;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public Movie getMovie() {
        return movie;
    }

    @Override
    public String toString() {
        return id + "|" + movieId + "|" + userId + "|" + tickets + "|" + showTime + "|" + totalPrice;
    }

    public static Booking fromString(String str) {
        String[] parts = str.split("\\|");
        return new Booking(
                parts[0], parts[1], Integer.parseInt(parts[2]),
                Integer.parseInt(parts[3]), parts[4],
                Double.parseDouble(parts[5])
        );
    }
}