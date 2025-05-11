<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>Admin Dashboard | SparkMovie</title>
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
        .glass-card {
            background: rgba(31, 41, 55, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(55, 65, 81, 0.8);
            transition: all 0.3s ease;
        }
        .glass-card:hover {
            border-color: #06b6d4;
            box-shadow: 0 10px 25px rgba(6, 182, 212, 0.2);
        }
        .form-input {
            background: rgba(30, 41, 59, 0.5);
            border: 1px solid rgba(55, 65, 81, 0.8);
            transition: all 0.3s ease;
        }
        .form-input:focus {
            border-color: #06b6d4;
            box-shadow: 0 0 0 2px rgba(6, 182, 212, 0.3);
        }
        .action-btn {
            transition: all 0.3s ease;
        }
        .action-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .movie-poster {
            width: 60px;
            height: 90px;
            object-fit: cover;
            border-radius: 4px;
            transition: transform 0.3s ease;
        }
        .movie-poster:hover {
            transform: scale(1.1);
        }
    </style>
</head>
<body class="gradient-bg text-white">
<%@ include file="Components/navbar.jsp" %>

<div class="grid-overlay"></div>


<section class="pt-24 pb-12 px-4 text-center">
    <h1 class="text-4xl md:text-5xl font-bold mb-6">
        <span class="text-transparent bg-clip-text bg-gradient-to-r from-cyan-400 to-blue-500">
            Movie Manager
        </span>
    </h1>
    <p class="text-xl text-gray-300 max-w-2xl mx-auto">
        Manage movies
    </p>
</section>


<section class="px-4 pb-20">
    <div class="max-w-6xl mx-auto">

        <div class="glass-card rounded-xl p-6 mb-8">
            <h2 class="text-2xl font-bold text-cyan-400 mb-6 border-b border-gray-700 pb-3">Add New Movie</h2>
            <form action="manageMovie" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <input type="hidden" name="action" value="add">

                <div>
                    <label class="block text-gray-400 mb-2">Title</label>
                    <input type="text" name="title" required
                           class="form-input w-full px-4 py-2 rounded-lg">
                </div>

                <div>
                    <label class="block text-gray-400 mb-2">Genre</label>
                    <input type="text" name="genre" required
                           class="form-input w-full px-4 py-2 rounded-lg">
                </div>

                <div>
                    <label class="block text-gray-400 mb-2">Duration</label>
                    <input type="text" name="duration" placeholder="e.g. 2h 15m" required
                           class="form-input w-full px-4 py-2 rounded-lg">
                </div>

                <div>
                    <label class="block text-gray-400 mb-2">Rating</label>
                    <input type="text" name="rating" placeholder="PG-13 as 13 " required
                           class="form-input w-full px-4 py-2 rounded-lg">
                </div>

                <div>
                    <label class="block text-gray-400 mb-2">Total Seats</label>
                    <input type="number" name="totalSeats" required
                           class="form-input w-full px-4 py-2 rounded-lg">
                </div>

                <div>
                    <label class="block text-gray-400 mb-2">Show Times</label>
                    <input type="text" name="showTimes" placeholder="e.g. 10:00 AM, 2:30 PM" required
                           class="form-input w-full px-4 py-2 rounded-lg">
                </div>

                <div>
                    <label class="block text-gray-400 mb-2">Image URL</label>
                    <input type="url" name="imgLink" placeholder="https://example.com/poster.jpg" required
                           class="form-input w-full px-4 py-2 rounded-lg">
                </div>

                <div class="md:col-span-2">
                    <label class="block text-gray-400 mb-2">Description</label>
                    <textarea name="description" rows="3" required
                              class="form-input w-full px-4 py-2 rounded-lg"></textarea>
                </div>

                <div class="md:col-span-2">
                    <button type="submit"
                            class="w-full bg-gradient-to-r from-cyan-600 to-blue-600 text-white px-6 py-3 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all duration-300 action-btn">
                        Add Movie
                    </button>
                </div>
            </form>
        </div>


        <div class="glass-card rounded-xl p-6">
            <div class="flex justify-between items-center mb-6 border-b border-gray-700 pb-3">
                <h2 class="text-2xl font-bold text-cyan-400">Current Movies</h2>
                <p class="text-gray-400">${movies.size()} movies available</p>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-gray-800/50">
                    <tr>
                        <th class="py-3 px-4 text-gray-400 font-semibold">Poster</th>
                        <th class="py-3 px-4 text-gray-400 font-semibold">Title</th>
                        <th class="py-3 px-4 text-gray-400 font-semibold">PG Rating</th>
                        <th class="py-3 px-4 text-gray-400 font-semibold">Genre</th>
                        <th class="py-3 px-4 text-gray-400 font-semibold">Duration</th>
                        <th class="py-3 px-4 text-gray-400 font-semibold">Seats</th>
                        <th class="py-3 px-4 text-gray-400 font-semibold">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="movie" items="${movies}">
                        <tr class="border-b border-gray-700/50 hover:bg-gray-800/30 transition-colors">
                            <td class="py-4 px-4">
                                <c:if test="${not empty movie.imgLink}">
                                    <img src="${movie.imgLink}" alt="${movie.title} poster" class="movie-poster"
                                         onerror="this.src='https://via.placeholder.com/60x90?text=No+Poster'">
                                </c:if>
                                <c:if test="${empty movie.imgLink}">
                                    <img src="https://via.placeholder.com/60x90?text=No+Poster" alt="Placeholder poster" class="movie-poster">
                                </c:if>
                            </td>
                            <td class="py-4 px-4 font-medium">${movie.title}</td>
                            <td class="py-4 px-4">${movie.rating}</td>
                            <td class="py-4 px-4">${movie.genre}</td>
                            <td class="py-4 px-4">${movie.duration}</td>
                            <td class="py-4 px-4">${movie.totalSeats}</td>
                            <td class="py-4 px-4">
                                <form action="manageMovie" method="post" class="inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="movieId" value="${movie.id}">
                                    <button type="submit"
                                            class="text-red-500 hover:text-red-400 action-btn px-3 py-1 rounded">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty movies}">
                <div class="text-center py-10">
                    <div class="mx-auto w-20 h-20 mb-4 text-gray-600">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-medium text-gray-300 mb-2">No movies found</h3>
                    <p class="text-gray-500">Add your first movie using the form above</p>
                </div>
            </c:if>
        </div>
    </div>
</section>

<%@ include file="Components/footer.jsp" %>

<script>

    document.querySelectorAll('tbody tr').forEach(row => {
        row.addEventListener('mouseenter', () => {
            row.style.backgroundColor = 'rgba(30, 41, 59, 0.4)';
        });
        row.addEventListener('mouseleave', () => {
            row.style.backgroundColor = '';
        });
    });
</script>
</body>
</html>