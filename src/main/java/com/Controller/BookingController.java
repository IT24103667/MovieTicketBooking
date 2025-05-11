package com.Controller;

import com.Model.Booking;
import com.Model.Movie;
import com.Model.User;
import com.Service.BookingService;
import com.Service.MovieService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "BookingController", value = "/booking")
public class BookingController extends HttpServlet {
    private BookingService bookingService = new BookingService();
    private MovieService movieService = new MovieService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieId = request.getParameter("movieId");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        Movie movie = movieService.getMovieById(movieId);
        if (movie == null) {
            response.sendRedirect("movies");
            return;
        }

        request.setAttribute("movie", movie);
        request.getRequestDispatcher("/booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String movieId = request.getParameter("movieId");
        int tickets = Integer.parseInt(request.getParameter("tickets"));
        String showTime = request.getParameter("showTime");
        double totalPrice = tickets * 10.0; // $10 per ticket

        Booking booking = new Booking(
                UUID.randomUUID().toString(),
                movieId,
                user.getId(),
                tickets,
                showTime,
                totalPrice
        );

        if (bookingService.createBooking(booking)) {
            response.sendRedirect("bookings?success=true");
        } else {
            response.sendRedirect("booking?movieId=" + movieId + "&error=seats");
        }
    }
}