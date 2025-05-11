<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="icon"
          href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>Edit Review</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #0f172a, #1e293b, #0f172a);
            min-height: 100vh;
        }
        .review-card {
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .star-rating {
            color: gold;
            font-size: 1.5rem;
            cursor: pointer;
        }
        .star-rating .star {
            transition: all 0.2s;
        }
        .star-rating .star:hover {
            transform: scale(1.2);
        }
    </style>
</head>
<body class="gradient-bg text-white">
<%@ include file="Components/navbar.jsp" %>

<div class="max-w-4xl mx-auto py-24 px-4">
    <section class="text-center mb-10">
        <h1 class="text-3xl md:text-4xl font-bold">
            <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
                Edit Your Review
            </span>
        </h1>
        <p class="text-gray-300 mt-2">Update your thoughts about ${review.movieTitle}</p>
    </section>

    <div class="review-card rounded-xl p-6">
        <div class="flex flex-col md:flex-row gap-6">
            <div class="flex-shrink-0">
                <c:choose>
                    <c:when test="${not empty movie.imgLink}">
                        <img src="${movie.imgLink}"
                             alt="${review.movieTitle} poster"
                             class="w-32 h-48 object-cover rounded-lg">
                    </c:when>
                    <c:otherwise>
                        <div class="w-32 h-48 bg-gradient-to-br from-cyan-900 to-blue-900 rounded-lg flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-cyan-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"/>
                            </svg>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="flex-grow">
                <h2 class="text-2xl font-semibold mb-2">${review.movieTitle}</h2>

                <!-- Star Rating Editor -->
                <div class="star-rating mb-4" id="ratingEditor">
                    <c:forEach begin="1" end="5" var="i">
                        <span class="star ${i <= review.rating ? 'text-yellow-400' : 'text-gray-500'}"
                              data-value="${i}">★</span>
                    </c:forEach>
                    <input type="hidden" name="rating" id="ratingValue" value="${review.rating}">
                </div>

                <!-- Review Text Editor -->
                <form id="editReviewForm" action="${pageContext.request.contextPath}/editReview" method="post">
                    <input type="hidden" name="reviewId" value="${review.reviewId}">
                    <textarea name="reviewText" class="w-full bg-slate-800/50 border border-slate-700 rounded-lg p-4 mb-4 text-gray-300 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:border-transparent"
                              rows="5">${review.reviewText}</textarea>

                    <div class="flex justify-end gap-3">
                        <a href="${pageContext.request.contextPath}/myReviews"
                           class="px-4 py-2 rounded-lg border border-gray-600 text-gray-300 hover:bg-gray-700/50 transition">
                            Cancel
                        </a>
                        <button type="submit"
                                class="px-4 py-2 rounded-lg bg-gradient-to-r from-cyan-500 to-blue-600 text-white hover:shadow-lg hover:shadow-cyan-500/30 transition">
                            Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="Components/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    // Star Rating Interaction
    document.querySelectorAll('#ratingEditor .star').forEach(star => {
        star.addEventListener('click', () => {
            const value = parseInt(star.getAttribute('data-value'));
            document.querySelectorAll('#ratingEditor .star').forEach((s, i) => {
                s.classList.toggle('text-yellow-400', i < value);
                s.classList.toggle('text-gray-500', i >= value);
            });
            document.getElementById('ratingValue').value = value;
        });
    });

    // Form Submission
    document.getElementById('editReviewForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(this);
        formData.append('rating', document.getElementById('ratingValue').value);
        formData.append('action', 'update');

        fetch(this.action, {
            method: 'POST',
            body: new URLSearchParams(formData)
        })
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error('Failed to update review');
            })
            .then(data => {
                Swal.fire({
                    title: 'Success!',
                    text: 'Your review has been updated',
                    icon: 'success',
                    background: '#1e293b',
                    color: '#ffffff',
                    confirmButtonColor: '#3b82f6'
                }).then(() => {
                    window.location.href = '${pageContext.request.contextPath}/myReviews';
                });
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
    });
</script>
</body>
</html>