<!doctype html>
<html>
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
    <title>Enter OTP</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            background-color: #111827;
            font-family: "Rubik", Helvetica, Arial, sans-serif;
            color: #e5e7eb;
        }
        .forgot-card {
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
        .btn-primary {
            background: linear-gradient(to right, #0ea5e9, #38bdf8);
        }
        .btn-primary:hover {
            box-shadow: 0 0 15px rgba(56, 189, 248, 0.3);
        }
    </style>
</head>
<body class="min-h-screen">
<div class="container mx-auto px-4 py-16 max-w-xl">
    <div class="flex justify-center">
        <div class="w-full">
            <div class="forgot-card rounded-xl shadow-2xl p-8 md:p-10">
                <div class="text-center mb-6">
                    <div class="text-5xl text-cyan-400 mb-4">
                        <i class="fas fa-lock"></i>
                    </div>
                    <h2 class="text-3xl font-bold gradient-text mb-2">Enter OTP</h2>
                    <% if (request.getAttribute("message") != null) { %>
                    <p class='text-red-400 mt-2'><%= request.getAttribute("message") %></p>
                    <% } %>
                    <p class="text-gray-400 mt-2">Please enter the OTP sent to your registered email address.</p>
                </div>

                <form action="ValidateOtp" method="POST" class="space-y-6">
                    <div>
                        <label for="otp" class="block text-sm font-medium text-gray-400 mb-2">OTP</label>
                        <input
                                type="text"
                                id="otp"
                                name="otp"
                                required
                                placeholder="Enter OTP"
                                class="w-full px-4 py-3 bg-gray-800 border border-gray-700 rounded-lg focus:border-cyan-500 focus:ring-1 focus:ring-cyan-500 text-white transition duration-200"
                        >
                    </div>

                    <input type="hidden" name="token" id="token" value="">

                    <div class="flex flex-col sm:flex-row gap-4 mt-4">
                        <button type="submit"
                                class="btn-primary text-white font-medium py-3 px-6 rounded-lg transition duration-200 w-full">
                            Reset Password
                        </button>
                        <a href="login.jsp"
                           class="bg-gray-700 hover:bg-gray-600 text-white font-medium py-3 px-6 rounded-lg transition duration-200 w-full text-center">
                            Back to Login
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Font Awesome CDN -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>
