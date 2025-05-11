<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>User Registration</title>
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

        /* Checkbox styling */
        .form-checkbox:checked {
            background-color: #06b6d4;
            border-color: #06b6d4;
        }

        /* Password strength indicator */
        .password-strength {
            height: 4px;
            transition: all 0.3s;
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
            animation: fadeIn 0.3s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body class="bg-gray-900 text-white">
<%@ include file="Components/navbar.jsp" %>

<!-- Registration Section -->
<section class="gradient-bg py-24 px-4 min-h-screen flex items-center justify-center">
    <div class="grid-overlay"></div>

    <div class="w-full max-w-md mx-auto relative z-10">
        <div class="bg-gray-800/70 backdrop-blur-md rounded-xl shadow-2xl overflow-hidden border border-gray-700">
            <!-- Form Header -->
            <div class="bg-gradient-to-r from-cyan-500 to-blue-600 p-6 text-center">
                <h2 class="text-2xl font-bold">Create Your Account</h2>
                <p class="text-cyan-100 mt-1">Join our community today</p>
            </div>

            <!-- Error Message -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="error-message bg-red-500/20 border-l-4 border-red-500 text-red-100 p-4 mx-6 mt-4">
                <p><%= request.getAttribute("error") %>
                </p>
            </div>
            <% } %>

            <!-- Registration Form -->
            <form class="p-6 space-y-6" id="registrationForm" action="register" method="POST">
                <!-- CSRF Token (Add proper implementation in your controller) -->
                <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">

                <!-- Username -->
                <div class="floating-label-group">
                    <input type="text" id="username" name="username"
                           class="form-input w-full px-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none text-white"
                           placeholder=" " required
                           value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                    <label for="username" class="floating-label">Username</label>
                </div>

                <!-- Email -->
                <div class="floating-label-group">
                    <input type="email" id="email" name="email"
                           class="form-input w-full px-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none text-white"
                           placeholder=" " required
                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                    <label for="email" class="floating-label">Email Address</label>
                </div>

                <!-- Password with strength indicator -->
                <div>
                    <div class="floating-label-group">
                        <input type="password" id="password" name="password"
                               class="form-input w-full px-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none text-white"
                               placeholder=" " required
                               oninput="checkPasswordStrength(this.value)">
                        <label for="password" class="floating-label">Password</label>
                    </div>
                    <div class="mt-2 flex space-x-1">
                        <div id="strength-1" class="password-strength w-1/4 bg-gray-600 rounded"></div>
                        <div id="strength-2" class="password-strength w-1/4 bg-gray-600 rounded"></div>
                        <div id="strength-3" class="password-strength w-1/4 bg-gray-600 rounded"></div>
                        <div id="strength-4" class="password-strength w-1/4 bg-gray-600 rounded"></div>
                    </div>
                    <p id="password-hint" class="text-xs text-gray-400 mt-1 hidden">
                        Password should contain at least 8 characters with uppercase, lowercase, numbers and special
                        characters
                    </p>
                </div>

                <!-- Role Selection -->
                <div>
                    <label class="block text-sm font-medium text-gray-300 mb-2">Role</label>
                    <div class="grid grid-cols-2 gap-3">
                        <label class="flex items-center space-x-2 cursor-pointer">
                            <input type="radio" name="role" value="user" class="form-radio text-cyan-500"
                                <%= "admin".equals(request.getParameter("role")) ? "" : "checked" %>>
                            <span class="text-gray-300">Regular User</span>
                        </label>
                        <label class="flex items-center space-x-2 cursor-pointer">
                            <input type="radio" name="role" value="admin" class="form-radio text-cyan-500"
                                <%= "admin".equals(request.getParameter("role")) ? "checked" : "" %>>
                            <span class="text-gray-300">Admin</span>
                        </label>
                    </div>
                </div>

                <!-- Phone Number -->
                <div class="floating-label-group">
                    <input type="tel" id="phone" name="phone"
                           class="form-input w-full px-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none text-white"
                           placeholder=" " required
                           value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>">
                    <label for="phone" class="floating-label">Phone Number</label>
                </div>

<%--                <!-- Location -->--%>
<%--                <div class="floating-label-group">--%>
<%--                    <select id="location" name="location"--%>
<%--                            class="form-input w-full px-4 py-3 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none text-white appearance-none"--%>
<%--                            required>--%>
<%--                        <option value="" disabled selected></option>--%>
<%--                        <option value="US" <%= "US".equals(request.getParameter("location")) ? "selected" : "" %>>United--%>
<%--                            States--%>
<%--                        </option>--%>
<%--                        <option value="UK" <%= "UK".equals(request.getParameter("location")) ? "selected" : "" %>>United--%>
<%--                            Kingdom--%>
<%--                        </option>--%>
<%--                        <option value="CA" <%= "CA".equals(request.getParameter("location")) ? "selected" : "" %>>--%>
<%--                            Canada--%>
<%--                        </option>--%>
<%--                        <option value="AU" <%= "AU".equals(request.getParameter("location")) ? "selected" : "" %>>--%>
<%--                            Australia--%>
<%--                        </option>--%>
<%--                        <option value="IN" <%= "IN".equals(request.getParameter("location")) ? "selected" : "" %>>--%>
<%--                            India--%>
<%--                        </option>--%>
<%--                    </select>--%>
<%--                    <label for="location" class="floating-label">Location</label>--%>
<%--                    <div class="absolute right-3 top-3 pointer-events-none">--%>
<%--                        <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">--%>
<%--                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"--%>
<%--                                  d="M19 9l-7 7-7-7"></path>--%>
<%--                        </svg>--%>
<%--                    </div>--%>
<%--                </div>--%>

                <!-- Terms and Conditions -->
                <div class="flex items-start">
                    <div class="flex items-center h-5">
                        <input id="terms" name="terms" type="checkbox"
                               class="form-checkbox h-4 w-4 text-cyan-500 transition duration-150 ease-in-out" required>
                    </div>
                    <div class="ml-3">
                        <label for="terms" class="flex items-center text-sm text-gray-300 cursor-pointer">
                            I agree to the
                            <a href="#" class="text-cyan-400 hover:text-cyan-300 ml-1 underline">Terms and
                                Conditions</a>
                        </label>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit"
                        class="glow-effect w-full bg-gradient-to-r from-cyan-500 to-blue-600 text-white py-3 px-4 rounded-lg font-semibold hover:shadow-lg hover:shadow-cyan-500/30 transition-all duration-300">
                    Create Account
                </button>
            </form>

            <!-- Login Link -->
            <div class="px-6 pb-6 text-center">
                <p class="text-gray-400">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login" class="text-cyan-400 hover:text-cyan-300 font-medium">Sign in</a>
                </p>
            </div>
        </div>
    </div>
</section>

<%@ include file="Components/footer.jsp" %>

<script>
    // Password strength indicator
    function checkPasswordStrength(password) {
        const strengthBars = [
            document.getElementById('strength-1'),
            document.getElementById('strength-2'),
            document.getElementById('strength-3'),
            document.getElementById('strength-4')
        ];
        const hint = document.getElementById('password-hint');

        // Reset all bars
        strengthBars.forEach(bar => {
            bar.style.backgroundColor = '#4b5563'; // gray-600
        });

        if (password.length === 0) {
            hint.classList.add('hidden');
            return;
        }

        hint.classList.remove('hidden');

        let strength = 0;

        // Length check
        if (password.length >= 8) strength++;
        // Contains uppercase
        if (/[A-Z]/.test(password)) strength++;
        // Contains numbers
        if (/[0-9]/.test(password)) strength++;
        // Contains special chars
        if (/[^A-Za-z0-9]/.test(password)) strength++;

        // Update strength bars
        for (let i = 0; i < strength; i++) {
            if (i === 0) strengthBars[i].style.backgroundColor = '#ef4444'; // red-500
            if (i === 1) strengthBars[i].style.backgroundColor = '#f59e0b'; // amber-500
            if (i === 2) strengthBars[i].style.backgroundColor = '#3b82f6'; // blue-500
            if (i === 3) strengthBars[i].style.backgroundColor = '#10b981'; // emerald-500
        }
    }

    // Form submission feedback
    document.getElementById('registrationForm').addEventListener('submit', function (e) {
        const submitBtn = this.querySelector('button[type="submit"]');
        submitBtn.disabled = true;
        submitBtn.innerHTML = `
            <svg class="animate-spin -ml-1 mr-2 h-5 w-5 text-white inline" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            Creating Account...
        `;
    });

    // Initialize floating labels for select elements
    document.querySelectorAll('select').forEach(select => {
        select.addEventListener('change', function () {
            if (this.value) {
                this.nextElementSibling.style.display = 'none';
            } else {
                this.nextElementSibling.style.display = 'block';
            }
        });

        // Initialize on page load
        if (select.value) {
            select.nextElementSibling.style.display = 'none';
        }
    });
</script>
</body>
</html>