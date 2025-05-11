package com;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import com.Service.UserService;
import com.Model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String newPassword = request.getParameter("password");
		String confPassword = request.getParameter("confPassword");
		RequestDispatcher dispatcher = null;

		if (newPassword == null || confPassword == null || !newPassword.equals(confPassword)) {
			request.setAttribute("status", "resetFailed");
			response.sendRedirect( "/MovieTicketBooking_war_exploded/login"); // Redirect to login page on error
			return;
		}

		try {
			UserService userService = new UserService();
			String email = (String) session.getAttribute("email");

			// Get all users
			List<User> users = userService.getAllUsers();
			boolean passwordUpdated = false;

			// Find and update the user's password
			for (User user : users) {
				if (user.getEmail().equals(email)) {
					// Hash the new password before storing
					user.setPassword(BCrypt.hashpw(newPassword, BCrypt.gensalt()));
					passwordUpdated = true;
					break;
				}
			}

			if (passwordUpdated) {
				// Rewrite all users to file with the updated password
				try (BufferedWriter writer = new BufferedWriter(new FileWriter(UserService.FILE_PATH))) {
					for (User user : users) {
						writer.write(user.toString());
						writer.newLine();
					}
				}
				request.setAttribute("status", "resetSuccess");
				response.sendRedirect(request.getContextPath() + "/login"); // Redirect to login page on success
			} else {
				request.setAttribute("status", "resetFailed");
				response.sendRedirect("/MovieTicketBooking_war_exploded/login"); // Redirect to login page on failure
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("status", "resetFailed");
			response.sendRedirect( "/MovieTicketBooking_war_exploded/login"); // Redirect to login page on error
		}
	}
}