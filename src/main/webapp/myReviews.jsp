<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="icon"
          href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>My Reviews</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Add SweetAlert for better confirmation dialogs -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

        .review-card {
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }

        .review-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
        }

        .movie-poster-thumbnail {
            width: 80px;
            height: 120px;
            object-fit: cover;
            border-radius: 0.25rem;
            transition: transform 0.3s ease;
        }

        .movie-poster-thumbnail:hover {
            transform: scale(1.05);
        }

        .placeholder-icon {
            color: rgba(34, 211, 238, 0.5);
        }
    </style>
</head>
<body class="gradient-bg text-white">
<%@ include file="Components/navbar.jsp" %>

<div class="max-w-6xl mx-auto py-24 px-4">

    <section class="pb-8 px-4 text-center">
        <h1 class="text-4xl md:text-5xl font-bold mb-4">
        <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
            My Reviews
        </span>
        </h1>
        <p class="text-xl text-gray-300 max-w-2xl mx-auto">
            Your personal collection of movie reviews and ratings
        </p>
    </section>

    <c:if test="${not empty success}">
        <div class="bg-green-800/50 border border-green-600 text-green-200 px-4 py-3 rounded-lg mb-6">
                ${success}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="bg-red-800/50 border border-red-600 text-red-200 px-4 py-3 rounded-lg mb-6">
                ${error}
        </div>
    </c:if>

    <c:choose>
        <c:when test="${not empty userReviews}">
            <div class="grid gap-6" id="reviewsContainer">
                <c:forEach items="${userReviews}" var="review">
                    <div class="review-card rounded-xl p-6" id="review-${review.reviewId}">
                        <div class="flex flex-col md:flex-row gap-6">
                            <div class="flex-shrink-0">
                                <c:choose>
                                    <c:when test="${not empty movieImages[review.movieId]}">
                                        <img src="${movieImages[review.movieId]}"
                                             alt="${review.movieTitle} poster"
                                             class="movie-poster-thumbnail"
                                             onerror="this.onerror=null;this.src='data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCIgc3Ryb2tlPSJjdXJyZW50Q29sb3IiIHN0cm9rZS13aWR0aD0iMSIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBmaWxsPSJub25lIj48cGF0aCBkPSJNNyA0djE2TTE3IDR2MTZNMyA4aDRNMTcgOGg0TTMgMTJoMThNMyAxNmg0TTE3IDE2aDRNNCAyMGgxNmExIDEgMCAwIDAgMS0xVjVhMSAxIDAgMCAwLTEtMUg0YTEgMSAwIDAgMC0xIDF2MTRhMSAxIDAgMCAwIDEgMXoiPjwvcGF0aD48L3N2Zz4='">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="movie-poster-thumbnail bg-gradient-to-br from-cyan-900 to-blue-900 flex items-center justify-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 placeholder-icon" fill="none"
                                                 viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                                      d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"></path>
                                            </svg>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="flex-grow">
                                <div class="flex justify-between items-start mb-2">
                                    <div>
                                        <h3 class="text-xl font-semibold">${review.movieTitle}</h3>
                                        <p class="text-gray-400 text-sm">Movie ID: ${review.movieId}</p>
                                    </div>
                                    <div class="star-rating">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= review.rating}">★</c:when>
                                                <c:otherwise>☆</c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <span class="ml-1 text-sm text-gray-400">(${review.rating}/5)</span>
                                    </div>
                                </div>

                                <p class="text-gray-300 mb-4">${review.reviewText}</p>

                                <div class="flex justify-between items-center">
                                    <span class="text-sm text-gray-500">
                                        Reviewed as: ${review.author}
                                    </span>
                                    <div class="flex gap-2">
                                        <a href="${pageContext.request.contextPath}/editReview?reviewId=${review.reviewId}"
                                           class="text-cyan-400 hover:text-cyan-300 text-sm font-medium">Edit</a>
                                        <button onclick="deleteReview('${review.reviewId}')"
                                                class="text-red-400 hover:text-red-300 text-sm font-medium">
                                            Delete
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <c:otherwise>
            <div class="review-card rounded-xl p-12 text-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 mx-auto text-gray-500 mb-4" fill="none"
                     viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                          d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                <h3 class="text-xl font-medium text-gray-400 mb-2">No Reviews Yet</h3>
                <p class="text-gray-500 mb-4">You haven't reviewed any movies yet.</p>
                <a href="${pageContext.request.contextPath}/movies"
                   class="inline-block bg-gradient-to-r from-cyan-500 to-blue-600 text-white py-2 px-6 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all">
                    Browse Movies
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="Components/footer.jsp" %>

<script>
    function deleteReview(reviewId) {
        Swal.fire({
            title: 'Delete Review?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#64748b',
            confirmButtonText: 'Yes, delete it!',
            background: '#1e293b',
            color: '#ffffff'
        }).then((result) => {
            if (result.isConfirmed) {
                const formData = new FormData();
                formData.append('reviewId', reviewId);
                formData.append('action', 'delete');

                fetch('${pageContext.request.contextPath}/myReviews', {
                    method: 'POST',
                    body: new URLSearchParams(formData)
                })
                    .then(response => {
                        if (response.ok) {
                            Swal.fire({
                                title: 'Deleted!',
                                text: 'Your review has been deleted.',
                                icon: 'success',
                                background: '#1e293b',
                                color: '#ffffff',
                                confirmButtonColor: '#3b82f6',
                                timer: 1500,
                                showConfirmButton: false
                            }).then(() => {
                                location.reload();
                            });
                        } else {
                            throw new Error('Failed to delete review');
                        }
                    })
                    .catch(error => {
                        Swal.fire({
                            title: 'Error!',
                            text: error.message,
                            icon: 'error',
                            background: '#1e293b',
                            color: '#ffffff',
                            confirmButtonColor: '#3b82f6'
                        });
                    });
            }
        });
    }
</script>
</body>
</html>