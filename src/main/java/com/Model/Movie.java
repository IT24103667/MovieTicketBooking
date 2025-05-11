package com.Model;

import java.io.Serializable;

public class Movie implements Serializable {
    private String id;
    private String title;
    private String genre;
    private String duration;
    private String rating;
    private String description;
    private int totalSeats;
    private String showTimes;
    private String imgLink;
    private transient Movie movie;


    public Movie() {
    }

    public Movie(String id, String title, String genre, String duration,
                 String rating, String description, int totalSeats, String showTimes, String imgLink) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.duration = duration;
        this.rating = rating;
        this.description = description;
        this.totalSeats = totalSeats;
        this.showTimes = showTimes;
        this.imgLink = imgLink;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTotalSeats() {
        return totalSeats;
    }

    public void setTotalSeats(int totalSeats) {
        this.totalSeats = totalSeats;
    }

    public String getShowTimes() {
        return showTimes;
    }

    public void setShowTimes(String showTimes) {
        this.showTimes = showTimes;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public String getImgLink() {
        return imgLink;
    }

    public void setImgLink(String imgLink) {
        this.imgLink = imgLink;
    }

    @Override
    public String toString() {
        return id + "|" + title + "|" + genre + "|" + duration + "|" +
                rating + "|" + description + "|" + totalSeats + "|" + showTimes + "|" + imgLink;
    }

    public static Movie fromString(String str) {
        String[] parts = str.split("\\|");
        if (parts.length != 9) return null;

        return new Movie(
                parts[0], parts[1], parts[2], parts[3],
                parts[4], parts[5], Integer.parseInt(parts[6]), parts[7], parts[8]
        );
    }
}