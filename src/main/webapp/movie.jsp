<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>Movie Collection</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #0f172a, #1e293b, #0f172a);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }
        .grid-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 1px 1px, rgba(255,255,255,0.1) 1px, transparent 0);
            background-size: 40px 40px;
            pointer-events: none;
        }
        .movie-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        .rating-badge {
            height: 25px;
            width: 25px;
            border-radius: 50%;
            background: linear-gradient(135deg, #f59e0b, #ef4444);
            position: absolute;
            text-align: center;
            top: 10px;
            right: 10px;
            z-index: 10;
        }
        .movie-poster {
            height: 300px;
            width: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .movie-poster-container {
            overflow: hidden;
            position: relative;
        }
    </style>
</head>
<body class="gradient-bg text-white">
<%@ include file="Components/navbar.jsp" %>

<div class="grid-overlay"></div>


<section class="pt-24 pb-8 px-4 text-center">
    <h1 class="text-4xl md:text-5xl font-bold mb-6">
        <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
            Explore Movies
        </span>
    </h1>
    <p class="text-xl text-gray-300 max-w-2xl mx-auto">
        Discover the latest blockbusters and timeless classics in our collection
    </p>
</section>


<section class="px-4 pb-20">
    <div class="max-w-6xl mx-auto">
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
            <c:forEach var="movie" items="${movies}">
                <div class="movie-card bg-gray-800/70 backdrop-blur-md rounded-xl overflow-hidden border border-gray-700 relative transition-all duration-300">
                    <!-- Movie Poster -->
                    <div class="movie-poster-container">
                        <c:choose>
                            <c:when test="${not empty movie.imgLink}">
                                <img src="${movie.imgLink}" alt="${movie.title}" class="movie-poster hover:scale-105"
                                     onerror="this.src='https://via.placeholder.com/300x450?text=Poster+Not+Available'">
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/300x450?text=No+Poster" alt="No poster available" class="movie-poster">
                            </c:otherwise>
                        </c:choose>
                        <div class="rating-badge flex items-center justify-center">
                            <span class="text-xs font-bold">${movie.rating}</span>
                        </div>
                    </div>


                    <div class="p-4">
                        <h3 class="text-xl font-semibold mb-2">${movie.title}</h3>
                        <div class="flex items-center text-gray-400 text-sm mb-3">
                            <span>${movie.genre}</span>
                            <span class="mx-2">•</span>
                            <span>${movie.duration}</span>
                        </div>
                        <p class="text-gray-300 text-sm mb-4 line-clamp-2">
                                ${movie.description}
                        </p>
                        <div class="flex space-x-2">
                            <a href="${pageContext.request.contextPath}/booking?movieId=${movie.id}"
                               class="flex-1 text-center bg-gradient-to-r from-cyan-500 to-blue-600 text-white py-2 px-4 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all">
                                Book Now
                            </a>
                            <a href="${pageContext.request.contextPath}/reviews?movieId=${movie.id}"
                               class="flex-1 text-center bg-gray-700 text-white py-2 px-4 rounded-lg font-medium hover:bg-gray-600 transition-all">
                                Reviews
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<%@ include file="Components/footer.jsp" %>

<script>

    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');


            console.log("Filter by: " + this.textContent.trim());
        });
    });


    document.querySelectorAll('.movie-card').forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.transform = 'translateY(-5px)';
            card.style.boxShadow = '0 10px 25px rgba(0, 0, 0, 0.2)';
        });
        card.addEventListener('mouseleave', () => {
            card.style.transform = '';
            card.style.boxShadow = '';
        });
    });
</script>
</body>
</html>