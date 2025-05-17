<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.Service.MovieService, com.Model.Movie, java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="icon"
          href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>SparkMovie Booking</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #0f172a, #1e293b, #0f172a);
            position: relative;
            overflow: hidden;
        }

        /* Animated grid overlay */
        .grid-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: linear-gradient(rgba(14, 165, 233, 0.1) 1px, transparent 1px),
            linear-gradient(90deg, rgba(14, 165, 233, 0.1) 1px, transparent 1px);
            background-size: 40px 40px;
            opacity: 0.3;
        }

        /* Floating animation for hero content */
        @keyframes float {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-15px);
            }
            100% {
                transform: translateY(0px);
            }
        }

        .floating {
            animation: float 6s ease-in-out infinite;
        }

        /* Glowing effect for CTA */
        .glow-effect {
            position: relative;
            z-index: 1;
        }

        .glow-effect::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            border-radius: 0.5rem;
            background: linear-gradient(45deg, #06b6d4, #3b82f6, #06b6d4);
            background-size: 200% 200%;
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s, transform 0.3s;
        }

        .glow-effect:hover::after {
            opacity: 1;
            transform: scale(1.05);
            animation: gradientBG 3s ease infinite;
        }

        @keyframes gradientBG {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        .movie-card {
            transition: all 0.3s ease;
        }

        .movie-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px -5px rgba(6, 182, 212, 0.4);
        }

        .rating-badge {
            position: absolute;
            top: -10px;
            right: -10px;
            background: linear-gradient(135deg, #f59e0b, #ef4444);
            color: white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 0.9rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .movie-poster {
            width: 100%;
            height: 300px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .movie-poster:hover {
            transform: scale(1.03);
        }

        .poster-container {
            position: relative;
            overflow: hidden;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
        }
    </style>
    <%
        MovieService movieService = new MovieService();
        List<Movie> movies = movieService.getAllMovies();

        // 1. Use a Queue to store movies temporarily (FIFO)
        Queue<Movie> movieQueue = new LinkedList<>();
        for (Movie movie : movies) {
            movieQueue.add(movie);
        }

        // 2. Convert Queue to List for sorting
        List<Movie> moviesToSort = new ArrayList<>(movieQueue);

        // 3. Apply Insertion Sort (descending order by rating)
        for (int i = 1; i < moviesToSort.size(); i++) {
            Movie key = moviesToSort.get(i);
            int j = i - 1;

            // Compare ratings (convert to double)
            while (j >= 0 && Double.parseDouble(moviesToSort.get(j).getRating()) < Double.parseDouble(key.getRating())) {
                moviesToSort.set(j + 1, moviesToSort.get(j));
                j--;
            }
            moviesToSort.set(j + 1, key);
        }

        // 4. Get top 3 highest-rated movies
        int displayCount = Math.min(moviesToSort.size(), 3);
        List<Movie> topMovies = moviesToSort.subList(0, displayCount);

    %>
</head>
<body class="bg-gray-900 text-white">
<!-- Include Navbar -->
<%@ include file="Components/navbar.jsp" %>

<!-- Hero Section -->
<section id="home"
         class="gradient-bg min-h-screen flex items-center justify-center text-center px-4 relative overflow-hidden">
    <!-- Grid overlay -->
    <div class="grid-overlay"></div>

    <!-- Floating dots -->
    <div class="absolute top-20 left-1/4 w-3 h-3 rounded-full bg-cyan-400 opacity-60 animate-float"
         style="animation-delay: 0s"></div>
    <div class="absolute top-1/3 right-1/5 w-4 h-4 rounded-full bg-blue-500 opacity-40 animate-float"
         style="animation-delay: 1s"></div>
    <div class="absolute bottom-1/4 left-1/5 w-2 h-2 rounded-full bg-cyan-300 opacity-50 animate-float"
         style="animation-delay: 2s"></div>

    <div class="max-w-4xl mx-auto relative z-10">
        <div class="floating">
            <h1 class="text-5xl md:text-6xl font-bold mb-6">
                <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
                  Book your ticket
                </span>
            </h1>
            <p class="text-lg md:text-xl text-gray-300 mb-8 max-w-2xl mx-auto">
                Book your favorite movies effortlessly with our seamless online ticket reservation system – fast,
                secure, and hassle-free
            </p>
            <div class="flex flex-col sm:flex-row justify-center gap-4">
                <%if (isLoggedIn) {%>
                <a href="${pageContext.request.contextPath}/movies"
                   class="glow-effect bg-gradient-to-r from-cyan-500 to-blue-600 text-white px-8 py-3 rounded-lg font-semibold hover:shadow-lg hover:shadow-cyan-500/30 transition-all duration-300">
                    Book Now
                </a>
                <%} else {%>
                <a href="./login"
                   class="glow-effect bg-gradient-to-r from-cyan-500 to-blue-600 text-white px-8 py-3 rounded-lg font-semibold hover:shadow-lg hover:shadow-cyan-500/30 transition-all duration-300">
                    Book Now
                </a>
                <%}%>
            </div>
        </div>
    </div>
</section>

<!-- Featured Movies Section -->
<section id="features" class="py-20 px-4">
    <div class="max-w-7xl mx-auto">
        <h2 class="text-3xl md:text-4xl font-bold text-center mb-12">
            <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
                Top Rated Movies (Sorted)
            </span>
        </h2>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <% if (!topMovies.isEmpty()) { %>
            <% for (Movie movie : topMovies) { %>
            <div class="movie-card bg-gray-800/50 p-6 rounded-xl border border-gray-700 hover:border-cyan-400 transition-all duration-300 relative">
                <div class="rating-badge">
                    <%= movie.getRating() %>
                </div>
                <div class="poster-container">
                    <% if (movie.getImgLink() != null && !movie.getImgLink().isEmpty()) { %>
                    <img src="<%= movie.getImgLink() %>" alt="<%= movie.getTitle() %> poster" class="movie-poster"
                         onerror="this.src='https://via.placeholder.com/300x450?text=Poster+Not+Available'">
                    <% } else { %>
                    <div class="w-full h-48 bg-gradient-to-br from-cyan-900 to-blue-900 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-cyan-400" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                  d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"></path>
                        </svg>
                    </div>
                    <% } %>
                </div>
                <h3 class="text-xl font-semibold mb-2 text-white"><%= movie.getTitle() %>
                </h3>
                <p class="text-gray-300 text-sm mb-4 line-clamp-2"><%= movie.getDescription() %>
                </p>
                <a href="${pageContext.request.contextPath}/booking?movieId=<%= movie.getId()%>"
                   class="inline-block w-full px-4 py-2 bg-gradient-to-r from-cyan-600 to-blue-600 text-white text-center rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all duration-300 flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"></path>
                    </svg>
                    Book Now
                </a>
            </div>
            <% } %>
            <% } else { %>
            <div class="col-span-3 text-center text-gray-400 py-10">
                <p>No movies available.</p>
            </div>
            <% } %>
        </div>
    </div>
</section>

<!-- All Movies Section -->
<section id="all-movies" class="py-20 px-4 bg-gray-900/50">
    <div class="max-w-7xl mx-auto">
        <h2 class="text-3xl md:text-4xl font-bold text-center mb-12">
            <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
                All Movies
            </span>
        </h2>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            <% if (!movies.isEmpty()) { %>
            <% for (Movie movie : movies) { %>
            <div class="movie-card bg-gray-800/50 p-4 rounded-xl border border-gray-700 hover:border-cyan-400 transition-all duration-300 relative">
                <div class="rating-badge">
                    <%= movie.getRating() %>
                </div>
                <div class="poster-container">
                    <% if (movie.getImgLink() != null && !movie.getImgLink().isEmpty()) { %>
                    <img src="<%= movie.getImgLink() %>" alt="<%= movie.getTitle() %> poster" class="movie-poster"
                         onerror="this.src='https://via.placeholder.com/300x450?text=Poster+Not+Available'">
                    <% } else { %>
                    <div class="w-full h-64 bg-gradient-to-br from-cyan-900 to-blue-900 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-cyan-400" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                  d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"></path>
                        </svg>
                    </div>
                    <% } %>
                </div>
                <h3 class="text-lg font-semibold mb-2 text-white"><%= movie.getTitle() %>
                </h3>
                <p class="text-gray-400 text-xs mb-3"><%= movie.getGenre() %>
                </p>
                <p class="text-gray-300 text-sm mb-4 line-clamp-2"><%= movie.getDescription() %>
                </p>
                <div class="flex space-x-2">
                    <a href="${pageContext.request.contextPath}/booking?movieId=<%= movie.getId()%>"
                       class="flex-1 text-center bg-gradient-to-r from-cyan-600 to-blue-600 text-white py-2 px-4 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all duration-300 flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"></path>
                        </svg>
                        Book
                    </a>
                </div>
            </div>
            <% } %>
            <% } else { %>
            <div class="col-span-4 text-center text-gray-400 py-10">
                <p>No movies available.</p>
            </div>
            <% } %>
        </div>
    </div>
</section>

<%@ include file="Components/footer.jsp" %>

<script>
    // Add floating animation to dots
    const dots = document.querySelectorAll('.animate-float');
    dots.forEach((dot, index) => {
        dot.style.animation = float ${3 + index}s ease-in-out infinite;
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
</script>
</body>
</html>
