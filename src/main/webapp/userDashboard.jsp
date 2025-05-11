<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>Profile Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .profile-card {
            background: rgba(31, 41, 55, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .gradient-text {
            background-clip: text;
            -webkit-background-clip: text;
            color: transparent;
            background-image: linear-gradient(to right, #38bdf8, #0ea5e9);
        }
    </style>
</head>
<body id="home" class="bg-gray-900 text-white min-h-screen flex flex-col">
<%@ include file="Components/navbar.jsp" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<main class="flex-grow flex items-center justify-center py-28 px-4 sm:px-6 lg:px-8">
    <div class="w-full max-w-3xl mx-auto">
        <div class="text-center mb-10">
            <h1 class="text-4xl md:text-5xl font-bold mb-2 gradient-text">Welcome back, <span
                    class="text-white">${user.username}!</span></h1>
            <p class="text-gray-400">Here's your account information</p>
        </div>

        <div class="profile-card rounded-xl shadow-2xl overflow-hidden p-8 md:p-10">
            <div class="mb-8">
                <h2 class="text-2xl font-semibold mb-6 text-cyan-400 border-b border-gray-700 pb-3">Profile Details</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="space-y-1">
                        <p class="text-sm font-medium text-gray-400">Email Address</p>
                        <p class="text-lg font-medium">${user.email}</p>
                    </div>

                    <div class="space-y-1">
                        <p class="text-sm font-medium text-gray-400">Account Role</p>
                        <p class="text-lg font-medium capitalize">${user.role}</p>
                    </div>

                    <div class="space-y-1">
                        <p class="text-sm font-medium text-gray-400">Phone Number</p>
                        <p class="text-lg font-medium">${user.phone}</p>
                    </div>

                    <div class="space-y-1">
                        <p class="text-sm font-medium text-gray-400">Account Status</p>
                        <p class="text-lg font-medium text-green-400">Active</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="Components/footer.jsp" %>
</body>
</html>