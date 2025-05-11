<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="icon"
          href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>Book ${movie.title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .movie-poster {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 0.5rem 0.5rem 0 0;
        }

        .movie-card {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body class="bg-gray-900 text-white">
<%@ include file="Components/navbar.jsp" %>

<div class="container mx-auto px-4 py-24 max-w-6xl">
    <div class="flex flex-col lg:flex-row gap-8 items-start">
        <!-- Movie Poster Card -->
        <div class="w-full lg:w-2/5">
            <div class="bg-gray-800 rounded-lg movie-card overflow-hidden">
                <c:choose>
                    <c:when test="${not empty movie.imgLink}">
                        <img src="${movie.imgLink}" alt="${movie.title} poster" class="movie-poster"
                             onerror="this.src='https://via.placeholder.com/400x600?text=Poster+Not+Available'">
                    </c:when>
                    <c:otherwise>
                        <div class="w-full h-400 bg-gradient-to-br from-cyan-900 to-blue-900 flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-24 w-24 text-cyan-400" fill="none"
                                 viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                      d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"></path>
                            </svg>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="p-6">
                    <h2 class="text-2xl font-bold text-white mb-2">${movie.title}</h2>
                    <div class="flex items-center space-x-4 mb-4">
                        <span class="text-gray-400">${movie.genre}</span>
                        <span class="text-gray-600">•</span>
                        <span class="text-gray-400">${movie.duration}</span>
                    </div>
                    <div class="flex justify-between items-center">
                        <div class="flex items-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-400 mr-1"
                                 viewBox="0 0 20 20" fill="currentColor">
                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                            </svg>
                            <span class="text-white font-medium">${movie.rating}/10</span>
                        </div>
                        <span class="text-cyan-400 font-medium">${movie.totalSeats} seats left</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Booking Form -->
        <div class="w-full lg:w-3/5">
            <div class="bg-gray-800 rounded-lg p-8 movie-card">
                <h1 class="text-3xl font-bold text-cyan-400 mb-2">Book Your Tickets</h1>
                <p class="text-gray-400 mb-8">Secure your seats for ${movie.title}</p>

                <c:if test="${not empty param.error}">
                    <div class="bg-red-500/20 border border-red-500 text-red-300 px-4 py-3 rounded mb-6">
                        <c:choose>
                            <c:when test="${param.error == 'seats'}">
                                <strong>Not enough seats available!</strong> Please select fewer tickets.
                            </c:when>
                        </c:choose>
                    </div>
                </c:if>

                <form action="booking" method="post">
                    <input type="hidden" name="movieId" value="${movie.id}">

                    <div class="space-y-6">
                        <!-- Tickets Input -->
                        <div>
                            <label for="tickets" class="block text-gray-400 mb-2 font-medium">Number of Tickets</label>
                            <div class="relative">
                                <input type="number" id="tickets" name="tickets" min="1" max="${movie.totalSeats}"
                                       class="w-full bg-gray-700 border border-gray-600 text-white px-4 py-3 rounded-lg focus:ring-2 focus:ring-cyan-500 focus:border-transparent"
                                       required>
                                <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none text-gray-400">
                                    tickets
                                </div>
                            </div>
                        </div>

                        <!-- Showtime Selector -->
                        <div>
                            <label for="showTime" class="block text-gray-400 mb-2 font-medium">Show Time</label>
                            <select id="showTime" name="showTime"
                                    class="w-full bg-gray-700 border border-gray-600 text-white px-4 py-3 rounded-lg focus:ring-2 focus:ring-cyan-500 focus:border-transparent"
                                    required>
                                <c:forTokens items="${movie.showTimes}" delims="," var="time">
                                    <option value="${time.trim()}">${time.trim()}</option>
                                </c:forTokens>
                            </select>
                        </div>

                        <!-- Price Display -->
                        <div class="bg-gray-700/50 rounded-lg p-4">
                            <div class="flex justify-between items-center">
                                <span class="text-gray-400">Total Price</span>
                                <span class="text-2xl font-bold text-cyan-400" id="totalPrice">LKR0.00</span>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit"
                                class="w-full bg-gradient-to-r from-cyan-600 to-blue-600 hover:from-cyan-500 hover:to-blue-500 text-white font-bold py-4 px-6 rounded-lg transition-all duration-300 shadow-lg hover:shadow-cyan-500/30">
                            Complete Booking
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="Components/footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const ticketInput = document.getElementById('tickets');
        const priceDisplay = document.getElementById('totalPrice');
        const ticketPrice = 1000.00; // Set your ticket price in LKR

        // Format currency with commas
        function formatLKR(amount) {
            return 'LKR ' + parseFloat(amount).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        function calculateTotal() {
            const tickets = parseInt(ticketInput.value) || 1;
            const total = tickets * ticketPrice;
            priceDisplay.textContent = formatLKR(total);
        }

        // Initialize
        ticketInput.value = 1;
        calculateTotal();

        // Add event listeners
        ticketInput.addEventListener('input', calculateTotal);
        ticketInput.addEventListener('change', calculateTotal);

        // Debugging checks
        console.log("Ticket input element:", ticketInput);
        console.log("Price display element:", priceDisplay);
        console.log("Initial calculation complete");
    });
</script>
</body>
</html>