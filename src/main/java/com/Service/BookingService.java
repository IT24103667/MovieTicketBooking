package com.Service;

import com.Model.Booking;
import com.Model.Movie;
import java.io.*;
import java.util.*;
import java.util.concurrent.locks.ReentrantLock;

public class BookingService {
    private static final String BOOKINGS_FILE = "./db/Bookings.txt";
    private static final ReentrantLock lock = new ReentrantLock();
    private MovieService movieService = new MovieService();

    public boolean createBooking(Booking booking) {
        lock.lock();
        try {
            // Check seat availability
            Movie movie = movieService.getMovieById(booking.getMovieId());
            if (movie == null || movie.getTotalSeats() < booking.getTickets()) {
                return false;
            }

            // Update available seats
            movie.setTotalSeats(movie.getTotalSeats() - booking.getTickets());
            if (!movieService.updateMovie(movie)) {
                return false;
            }

            // Save booking
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(BOOKINGS_FILE, true))) {
                writer.write(booking.toString());
                writer.newLine();
                return true;
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        } finally {
            lock.unlock();
        }
    }

    public List<Booking> getUserBookings(int userId) {
        List<Booking> bookings = new ArrayList<>();
        File file = new File(BOOKINGS_FILE);

        if (!file.exists()) return bookings;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Booking booking = Booking.fromString(line);
                if (booking != null && booking.getUserId() == userId) {
                    bookings.add(booking);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bookings;
    }
}