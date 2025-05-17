<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="icon"
          href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>My Bookings | SparkMovie</title>
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
            background-image: radial-gradient(circle at 1px 1px, rgba(255, 255, 255, 0.1) 1px, transparent 0);
            background-size: 40px 40px;
            pointer-events: none;
        }

        .booking-card {
            background: rgba(31, 41, 55, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(55, 65, 81, 0.8);
            transition: all 0.3s ease;
        }

        .booking-card:hover {
            transform: translateY(-5px);
            border-color: #06b6d4;
            box-shadow: 0 10px 25px rgba(6, 182, 212, 0.2);
        }

        .price-tag {
            background: linear-gradient(135deg, rgba(6, 182, 212, 0.2), rgba(59, 130, 246, 0.2));
        }
    </style>
</head>
<body class="gradient-bg text-white">
<%@ include file="Components/navbar.jsp" %>

<div class="grid-overlay"></div>

<!-- Hero Section -->
<section class="pt-24 pb-12 px-4 text-center">
    <h1 class="text-4xl md:text-5xl font-bold mb-6">
        <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
            My Bookings
        </span>
    </h1>
    <p class="text-xl text-gray-300 max-w-2xl mx-auto">
        Manage your upcoming movie experiences
    </p>
</section>

<!-- Success Message -->
<c:if test="${not empty param.success}">
    <div class="max-w-6xl mx-auto px-4 mb-8">
        <div class="bg-green-600/30 border border-green-500 text-green-100 px-4 py-3 rounded-lg flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clip-rule="evenodd"></path>
            </svg>
            Booking created successfully!
        </div>
    </div>
</c:if>

<!-- Bookings Section -->
<section class="px-4 pb-20">
    <div class="max-w-6xl mx-auto">
        <c:choose>
            <c:when test="${not empty bookings}">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <c:forEach items="${bookings}" var="booking">
                        <div class="booking-card rounded-xl p-6">
                            <div class="flex flex-col md:flex-row justify-between gap-4">
                                <div class="flex-1">
                                    <h3 class="text-xl font-bold text-white mb-2">${booking.movie.title}</h3>

                                    <div class="flex items-center text-gray-400 text-sm mb-3">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none"
                                             viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                  d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                        </svg>
                                            ${booking.showTime}
                                    </div>

                                    <div class="flex flex-wrap gap-3 text-sm mb-4">
                                        <span class="bg-gray-700/50 px-3 py-1 rounded-full flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none"
                                                 viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                      d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"></path>
                                            </svg>
                                            ${booking.tickets} ticket(s)
                                        </span>
                                        <span class="bg-gray-700/50 px-3 py-1 rounded-full">
                                            Booking #${booking.id.substring(0, 8)}
                                        </span>
                                    </div>
                                </div>

                                <div class="price-tag rounded-lg p-4 min-w-[120px] text-center">
                                    <p class="text-cyan-400 font-bold text-2xl">LKR ${booking.totalPrice}</p>
                                    <a href="#" class="text-xs text-gray-400 hover:text-cyan-400 mt-1 inline-block">View
                                        details</a>
                                </div>
                            </div>

                            <div class="mt-4 pt-4 border-t border-gray-700/50 flex space-x-2">
<%--                                <a href="${pageContext.request.contextPath}/booking/cancel?id=${booking.id}"--%>
<%--                                   class="flex-1 text-center bg-gray-700/50 hover:bg-gray-600 text-white py-2 px-4 rounded-lg font-medium transition-all">--%>
<%--                                    Cancel--%>
<%--                                </a>--%>
                                <a href="${pageContext.request.contextPath}/booking?movieId=${booking.movie.id}"
                                   class="flex-1 text-center bg-gradient-to-r from-cyan-500 to-blue-600 text-white py-2 px-4 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all">
                                    View Movie
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-16">
                    <div class="mx-auto w-24 h-24 mb-6 text-gray-600">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                  d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-medium text-gray-300 mb-3">No bookings found</h3>
                    <p class="text-gray-500 mb-6 max-w-md mx-auto">You haven't made any bookings yet. Browse our
                        collection to get started!</p>
                    <a href="${pageContext.request.contextPath}/movies"
                       class="inline-block bg-gradient-to-r from-cyan-500 to-blue-600 text-white px-6 py-3 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all">
                        Browse Movies
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%@ include file="Components/footer.jsp" %>

<script>
    // Add hover effects to booking cards
    document.querySelectorAll('.booking-card').forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.transform = 'translateY(-5px)';
            card.style.boxShadow = '0 10px 25px rgba(6, 182, 212, 0.2)';
        });
        card.addEventListener('mouseleave', () => {
            card.style.transform = '';
            card.style.boxShadow = '';
        });
    });
</script>
</body>
</html>
