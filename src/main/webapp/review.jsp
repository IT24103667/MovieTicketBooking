<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="icon"
          href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>${movie.title} - Reviews</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #0f172a, #1e293b, #0f172a);
            min-height: 100vh;
        }

        .star-rating {
            color: gold;
            font-size: 1.2rem;
        }

        .movie-poster {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
        }

        .movie-card {
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
    </style>
</head>
<body class="gradient-bg text-white">
<%@ include file="Components/navbar.jsp" %>

<div class="max-w-6xl mx-auto py-24 px-4">
    <!-- Movie Details Section -->
    <div class="flex flex-col lg:flex-row gap-8 mb-12">
        <!-- Movie Poster -->
        <div class="w-full lg:w-2/5">
            <div class="movie-card rounded-xl overflow-hidden">
                <c:choose>
                    <c:when test="${not empty movie.imgLink}">
                        <img src="${movie.imgLink}" alt="${movie.title} poster" class="movie-poster"
                             onerror="this.src='https://via.placeholder.com/400x600?text=Poster+Not+Available'">
                    </c:when>
                    <c:otherwise>
                        <div class="w-full h-full bg-gradient-to-br from-cyan-900 to-blue-900 flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-24 w-24 text-cyan-400" fill="none"
                                 viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                      d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"></path>
                            </svg>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Movie Info -->
        <div class="w-full lg:w-3/5">
            <h1 class="text-4xl font-bold mb-4">
                <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
                    ${movie.title}
                </span>
            </h1>

            <div class="flex items-center space-x-4 mb-6">
                <span class="text-gray-300">${movie.genre}</span>
                <span class="text-gray-500">•</span>
                <span class="text-gray-300">${movie.duration}</span>
                <span class="text-gray-500">•</span>
                <div class="flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-400 mr-1" viewBox="0 0 20 20"
                         fill="currentColor">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                    </svg>
                    <span class="text-white">${movie.rating}/10</span>
                </div>
            </div>

            <p class="text-gray-300 mb-6">${movie.description}</p>

            <div class="mb-6">
                <h3 class="text-xl font-semibold mb-2">Show Times</h3>
                <div class="flex flex-wrap gap-2">
                    <c:forTokens items="${movie.showTimes}" delims="," var="time">
                        <span class="bg-cyan-900/50 text-cyan-400 px-3 py-1 rounded-full text-sm">${time.trim()}</span>
                    </c:forTokens>
                </div>
            </div>
        </div>
    </div>

    <!-- Review Form -->
    <%--    <div class="movie-card rounded-xl p-6 mb-12">--%>
    <%--        <h2 class="text-2xl font-semibold mb-4">Write a Review</h2>--%>
    <%--        <form action="${pageContext.request.contextPath}/reviews" method="post">--%>
    <%--            <input type="hidden" name="movieId" value="${movie.id}">--%>
    <%--            <input type="hidden" name="movieTitle" value="${movie.title}">--%>

    <%--            <div class="mb-4">--%>
    <%--                <label class="block text-gray-300 mb-2">Your Name</label>--%>
    <%--                <input type="text" name="author" required--%>
    <%--                       class="w-full bg-gray-700 rounded-lg px-4 py-2 text-white border border-gray-600 focus:ring-2 focus:ring-cyan-500 focus:border-transparent">--%>
    <%--            </div>--%>

    <%--            <div class="mb-4">--%>
    <%--                <label class="block text-gray-300 mb-2">Rating</label>--%>
    <%--                <select name="rating" required--%>
    <%--                        class="w-full bg-gray-700 rounded-lg px-4 py-2 text-white border border-gray-600 focus:ring-2 focus:ring-cyan-500 focus:border-transparent">--%>
    <%--                    <option value="5">★★★★★ - Excellent</option>--%>
    <%--                    <option value="4">★★★★☆ - Good</option>--%>
    <%--                    <option value="3">★★★☆☆ - Average</option>--%>
    <%--                    <option value="2">★★☆☆☆ - Poor</option>--%>
    <%--                    <option value="1">★☆☆☆☆ - Terrible</option>--%>
    <%--                </select>--%>
    <%--            </div>--%>

    <%--            <div class="mb-4">--%>
    <%--                <label class="block text-gray-300 mb-2">Review</label>--%>
    <%--                <textarea name="reviewText" rows="4" required--%>
    <%--                          class="w-full bg-gray-700 rounded-lg px-4 py-2 text-white border border-gray-600 focus:ring-2 focus:ring-cyan-500 focus:border-transparent"></textarea>--%>
    <%--            </div>--%>

    <%--            <button type="submit"--%>
    <%--                    class="bg-gradient-to-r from-cyan-500 to-blue-600 text-white py-3 px-8 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all">--%>
    <%--                Submit Review--%>
    <%--            </button>--%>
    <%--        </form>--%>
    <%--    </div>--%>

    <!-- Review Form -->
    <div class="movie-card rounded-xl p-6 mb-12">
        <h2 class="text-2xl font-semibold mb-4">Write a Review</h2>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <form action="${pageContext.request.contextPath}/reviews" method="post">
                    <input type="hidden" name="movieId" value="${movie.id}">
                    <input type="hidden" name="movieTitle" value="${movie.title}">

                    <!-- Hidden field for logged-in user's username -->
                    <input type="hidden" name="userName" value="${sessionScope.user.username}">

                    <!-- Visible input for author name -->
                    <div class="mb-4">
                        <label class="block text-gray-300 mb-2">Display Name</label>
                        <input type="text" name="author" required
                               class="w-full bg-gray-700 rounded-lg px-4 py-2 text-white border border-gray-600 focus:ring-2 focus:ring-cyan-500 focus:border-transparent"
                               placeholder="How you want your name to appear">
                    </div>

                    <div class="mb-4">
                        <label class="block text-gray-300 mb-2">Rating</label>
                        <select name="rating" required
                                class="w-full bg-gray-700 rounded-lg px-4 py-2 text-white border border-gray-600 focus:ring-2 focus:ring-cyan-500 focus:border-transparent">
                            <option value="5">★★★★★ - Excellent</option>
                            <option value="4">★★★★☆ - Good</option>
                            <option value="3">★★★☆☆ - Average</option>
                            <option value="2">★★☆☆☆ - Poor</option>
                            <option value="1">★☆☆☆☆ - Terrible</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label class="block text-gray-300 mb-2">Review</label>
                        <textarea name="reviewText" rows="4" required
                                  class="w-full bg-gray-700 rounded-lg px-4 py-2 text-white border border-gray-600 focus:ring-2 focus:ring-cyan-500 focus:border-transparent"></textarea>
                    </div>

                    <button type="submit"
                            class="bg-gradient-to-r from-cyan-500 to-blue-600 text-white py-3 px-8 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all">
                        Submit Review
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <div class="text-center py-8">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 mx-auto text-gray-500 mb-4" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                    </svg>
                    <p class="text-gray-400 mb-4">You need to be logged in to submit a review</p>
                    <a href="${pageContext.request.contextPath}/login"
                       class="inline-block bg-gradient-to-r from-cyan-500 to-blue-600 text-white py-2 px-6 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all">
                        Login Now
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Reviews List -->
    <div class="space-y-6">
        <h2 class="text-3xl font-bold mb-6 text-center">
            <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
                User Reviews
            </span>
        </h2>

        <c:forEach items="${reviews}" var="review">
            <div class="movie-card rounded-xl p-6">
                <div class="flex justify-between items-start mb-2">
                    <h3 class="text-xl font-semibold">${review.author}</h3>
                    <div class="star-rating">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= review.rating}">★</c:when>
                                <c:otherwise>☆</c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <span class="ml-2 text-sm text-gray-400">${review.rating}/5</span>
                    </div>
                </div>
                <p class="text-gray-300">${review.reviewText}</p>
            </div>
        </c:forEach>

        <c:if test="${empty reviews}">
            <div class="movie-card rounded-xl p-8 text-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 mx-auto text-gray-500 mb-4" fill="none"
                     viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                          d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                <p class="text-gray-400 text-lg">No reviews yet. Be the first to review this movie!</p>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="Components/footer.jsp" %>
</body>
</html>