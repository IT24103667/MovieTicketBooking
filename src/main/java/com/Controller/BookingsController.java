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
import java.util.List;

@WebServlet(name = "BookingsController", value = "/bookings")
public class BookingsController extends HttpServlet {
    private BookingService bookingService = new BookingService();
    private MovieService movieService = new MovieService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        List<Booking> bookings = bookingService.getUserBookings(user.getId());

        // Add movie details to each booking
        for (Booking booking : bookings) {
            Movie movie = movieService.getMovieById(booking.getMovieId());
            booking.setMovie(movie);
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/bookings.jsp").forward(request, response);
    }
}