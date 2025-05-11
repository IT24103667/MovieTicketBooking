<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>User Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Custom gradient background */
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

        /* Form input focus effects */
        .form-input:focus {
            border-color: #06b6d4;
            box-shadow: 0 0 0 3px rgba(6, 182, 212, 0.3);
        }

        /* Floating label effect */
        .floating-label-group {
            position: relative;
        }

        .floating-label {
            position: absolute;
            left: 12px;
            top: 12px;
            color: #9ca3af;
            transition: all 0.2s ease;
            pointer-events: none;
        }

        .form-input:focus ~ .floating-label,
        .form-input:not(:placeholder-shown) ~ .floating-label {
            top: -8px;
            left: 10px;
            font-size: 0.75rem;
            background: #0f172a;
            padding: 0 4px;
            color: #06b6d4;
        }

        /* Error message styling */
        .error-message {
            background-color: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border-radius: 0.375rem;
            text-align: center;
        }
    </style>
</head>
<body class="bg-gray-900 text-white">
<!-- Include navbar with hideLogin parameter -->
<jsp:include page="Components/navbar.jsp">
    <jsp:param name="hideLogin" value="true"/>
</jsp:include>

<!-- Login Section -->
<section class="gradient-bg py-16 px-4 min-h-screen flex items-center justify-center">
    <div class="grid-overlay"></div>

    <div class="w-full max-w-md mx-auto relative z-10">
        <div class="bg-gray-800/70 backdrop-blur-md rounded-xl shadow-2xl overflow-hidden border border-gray-700">
            <!-- Form Header -->
            <div class="bg-gradient-to-r from-cyan-500 to-blue-600 p-6 text-center">
                <h2 class="text-2xl font-bold">Welcome Back</h2>
                <p class="text-cyan-100 mt-1">Sign in to your account</p>
            </div>

            <%-- Display error message if login failed --%>
            <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                ${error}
            </div>
            <% } %>

            <%-- Display success message if redirected from registration --%>
            <% if (request.getParameter("registration") != null) { %>
            <div class="bg-green-500/20 text-green-400 p-4 text-center">
                Registration successful! Please login.
            </div>
            <% } %>

            <!-- Login Form -->
            <form class="p-6 space-y-6" action="login" method="POST" id="loginForm">
                <!-- Email -->
                <div class="floating-label-group">
                    <input type="email" id="loginEmail" name="email"
                           class="form-input w-full px-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none text-white"
                           placeholder=" " required>
                    <label for="loginEmail" class="floating-label">Email Address</label>
                </div>

                <!-- Password -->
                <div class="floating-label-group">
                    <input type="password" id="loginPassword" name="password"
                           class="form-input w-full px-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none text-white"
                           placeholder=" " required>
                    <label for="loginPassword" class="floating-label">Password</label>
                </div>

                <!-- Remember Me & Forgot Password -->
                <div class="flex items-center justify-between">
                    <label class="flex items-center space-x-2 cursor-pointer">
                        <input type="checkbox" name="remember" class="form-checkbox h-4 w-4 text-cyan-500">
                        <span class="text-sm text-gray-300">Remember me</span>
                    </label>
                    <a href="forgotPassword.jsp" class="text-sm text-cyan-400 hover:text-cyan-300">Forgot password?</a>
                </div>

                <!-- Submit Button -->
                <button type="submit"
                        class="glow-effect w-full bg-gradient-to-r from-cyan-500 to-blue-600 text-white py-3 px-4 rounded-lg font-semibold hover:shadow-lg hover:shadow-cyan-500/30 transition-all duration-300">
                    Sign In
                </button>
            </form>

            <!-- Registration Link -->
            <div class="px-6 pb-6 text-center">
                <p class="text-gray-400">
                    Don't have an account?
                    <a href="${pageContext.request.contextPath}/register" class="text-cyan-400 hover:text-cyan-300 font-medium">Sign up</a>
                </p>
            </div>
        </div>
    </div>
</section>

<%@ include file="Components/footer.jsp" %>

<script>
    // Client-side form validation
    document.getElementById('loginForm').addEventListener('submit', function (e) {
        const email = document.getElementById('loginEmail').value;
        const password = document.getElementById('loginPassword').value;

        if (!email || !password) {
            e.preventDefault();
            alert('Please fill in all fields');
            return false;
        }

        // Basic email validation
        if (!email.includes('@') || !email.includes('.')) {
            e.preventDefault();
            alert('Please enter a valid email address');
            return false;
        }

        return true;
    });
</script>
</body>
</html>