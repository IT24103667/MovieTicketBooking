<!doctype html>
<html>
<head>
	<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2306b6d4' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M13 10V3L4 14h7v7l9-11h-7z'/></svg>">
	<title>Reset Password</title>
	<script src="https://cdn.tailwindcss.com"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	<style>
		body {
			background-color: #111827;
			font-family: "Rubik", Helvetica, Arial, sans-serif;
		}
		.auth-card {
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
		.input-field {
			background-color: rgba(17, 24, 39, 0.7);
			border: 1px solid rgba(255, 255, 255, 0.1);
		}
		.input-field:focus {
			border-color: #38bdf8;
			box-shadow: 0 0 0 1px rgba(56, 189, 248, 0.5);
		}
	</style>
</head>
<body class="min-h-screen flex items-center justify-center">
<div class="w-full max-w-md mx-4">
	<div class="auth-card rounded-xl shadow-2xl overflow-hidden">
		<!-- Header -->
		<div class="text-center py-6 px-4 border-b border-gray-700">
			<h1 class="text-2xl font-bold gradient-text">Reset Password</h1>
		</div>

		<!-- Form -->
		<div class="p-6">
			<form class="space-y-6" action="newPassword" method="POST">
				<!-- New Password -->
				<div class="space-y-2">
					<label class="block text-sm font-medium text-gray-400">New Password</label>
					<div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fas fa-lock"></i>
                            </span>
						<input type="password" name="password"
							   class="input-field w-full pl-10 pr-3 py-3 rounded-lg text-white focus:outline-none focus:ring-1 focus:ring-cyan-500 transition duration-200"
							   placeholder="Enter new password" required>
					</div>
				</div>

				<!-- Confirm Password -->
				<div class="space-y-2">
					<label class="block text-sm font-medium text-gray-400">Confirm Password</label>
					<div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">
                                <i class="fas fa-lock"></i>
                            </span>
						<input type="password" name="confPassword"
							   class="input-field w-full pl-10 pr-3 py-3 rounded-lg text-white focus:outline-none focus:ring-1 focus:ring-cyan-500 transition duration-200"
							   placeholder="Confirm new password" required>
					</div>
				</div>

				<!-- Submit Button -->
				<div>
					<button type="submit"
							class="btn-primary w-full text-white font-medium py-3 px-4 rounded-lg transition duration-200">
						Reset Password
					</button>
				</div>
			</form>

			<!-- Divider -->
			<div class="flex items-center my-6">
				<div class="flex-grow border-t border-gray-700"></div>
				<span class="flex-shrink mx-4 text-gray-500">or</span>
				<div class="flex-grow border-t border-gray-700"></div>
			</div>

			<!-- Footer Links -->
			<div class="text-center text-sm text-gray-500">
				<p>
					Don't have an account?
					<a href="#" class="text-cyan-400 hover:text-cyan-300 transition duration-200">
						Register Now!
					</a>
				</p>
			</div>
		</div>
	</div>
</div>
</body>
</html>