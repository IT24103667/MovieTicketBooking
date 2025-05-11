<!doctype html>
<html>
<head>
	<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
	<title>Forgot Password</title>
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
<div class="container mx-auto px-4 py-16 max-w-4xl">
	<div class="flex justify-center">
		<div class="w-full lg:w-2/3">
			<div class="forgot-card rounded-xl shadow-2xl p-8 md:p-10 mb-8">
				<h2 class="text-3xl font-bold mb-2 gradient-text">Forgot your password?</h2>
				<p class="text-gray-400 mb-6">Change your password in three easy steps. This will help you secure your account!</p>

				<ol class="list-decimal list-inside space-y-2 text-gray-300 mb-8">
					<li><span class="text-cyan-400">Enter your email address below</span></li>
					<li><span class="text-cyan-400">Our system will send you an OTP to your email</span></li>
					<li><span class="text-cyan-400">Enter the OTP on the next page</span></li>
				</ol>
			</div>

			<form class="forgot-card rounded-xl shadow-2xl p-8 md:p-10" action="forgotPassword" method="POST">
				<div class="mb-6">
					<label for="email-for-pass" class="block text-sm font-medium text-gray-400 mb-2">Email Address</label>
					<input class="w-full px-4 py-3 bg-gray-800 border border-gray-700 rounded-lg focus:border-cyan-500 focus:ring-1 focus:ring-cyan-500 text-white transition duration-200"
						   type="email"
						   name="email"
						   id="email-for-pass"
						   required>
					<p class="mt-2 text-sm text-gray-500">Enter the registered email address. We'll email an OTP to this address.</p>
				</div>

				<div class="flex flex-col sm:flex-row gap-4 mt-8">
					<button class="btn-primary text-white font-medium py-3 px-6 rounded-lg transition duration-200 flex-1"
							type="submit">
						Get New Password
					</button>
					<a href="login.jsp"
					   class="bg-gray-700 hover:bg-gray-600 text-white font-medium py-3 px-6 rounded-lg transition duration-200 text-center flex-1">
						Back to Login
					</a>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>