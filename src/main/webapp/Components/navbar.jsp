<%@ page import="com.Model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/tailwindcss">
    @layer utilities {
        .nav-link {
            @apply relative text-white px-4 py-2 rounded-lg transition-all duration-300;
        }

        .nav-link::after {
            @apply content-[''] absolute bottom-0 left-1/2 w-0 h-0.5 bg-cyan-400 transition-all duration-300;
        }

        .nav-link:hover::after {
            @apply left-0 w-full;
        }

        .nav-link.active {
            @apply text-cyan-300;
        }

        .nav-link.active::after {
            @apply left-0 w-full bg-cyan-300;
        }

        .navbar-scrolled {
            @apply bg-gray-900/90 backdrop-blur-md shadow-lg;
        }

        /* Mobile menu specific styles */
        .mobile-menu-item {
            @apply block px-4 py-3 text-white hover:bg-gray-800/50 rounded-lg transition-all duration-300;
        }

        .mobile-menu-item.active {
            @apply bg-cyan-500/10 text-cyan-300;
        }

        .mobile-menu-divider {
            @apply border-t border-gray-700/50 my-2;
        }

        .mobile-menu-button {
            @apply w-full px-6 py-3 bg-gradient-to-r from-cyan-500 to-blue-600 text-white
            rounded-lg font-medium transition-all duration-300
            hover:shadow-lg hover:shadow-cyan-500/30 hover:scale-[1.02];
        }
    }
</style>

<%
    String uri = request.getRequestURI();
    String contextPath = request.getContextPath();
    boolean isLoginPage = uri.endsWith("/login.jsp");

    boolean isLoggedIn = session.getAttribute("user") != null;

    User user = (User) session.getAttribute("user");
    boolean isAdmin = user != null && "admin".equals(user.getRole());
    boolean isUser = user != null && "user".equals(user.getRole());

    if (session.getAttribute("user") == null && !(uri.endsWith("/") || uri.endsWith("/register.jsp"))) {
        response.sendRedirect(request.getContextPath() + "/login");
    }
%>

<nav id="navbar" class="fixed w-full z-50 transition-all duration-500">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-20">
            <!-- Logo -->
            <div class="flex-shrink-0 flex items-center">
                <a href="${pageContext.request.contextPath}/"
                   class="text-white text-2xl font-bold flex items-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 mr-2 text-cyan-400" fill="none"
                         viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M13 10V3L4 14h7v7l9-11h-7z"></path>
                    </svg>
                    SparkMovie
                </a>
            </div>

            <!-- Desktop Menu -->
            <div class="hidden md:block">
                <div class="ml-10 flex items-center space-x-4">
                    <% if (isLoggedIn) { %>
                    <a href="${pageContext.request.contextPath}/"
                       class="nav-link <%= uri.endsWith(contextPath + "/") ? "active" : "" %>">Home</a>

                    <a href="${pageContext.request.contextPath}/movies"
                       class="nav-link <%= uri.startsWith(contextPath + "/movie") ? "active" : "" %>">Movies</a>
                    <a href="${pageContext.request.contextPath}/bookings"
                       class="nav-link <%= uri.startsWith(contextPath + "/bookings") ? "active" : "" %>">My Bookings</a>
                    <a href="${pageContext.request.contextPath}/myReviews"
                       class="nav-link <%= uri.startsWith(contextPath + "/myReviews") ? "active" : "" %>">My Reviews</a>

                    <% if (isAdmin) {%>
                    <a href="${pageContext.request.contextPath}/manageMovie"
                       class="nav-link <%= uri.startsWith(contextPath + "/manageMovie.jsp") ? "active" : "" %>">Manage
                        Movies</a>
                    <a href="${pageContext.request.contextPath}/admin"
                       class="nav-link <%= uri.startsWith(contextPath + "/userDashboard.jsp") ? "active" : "" %>">Profile</a>
                    <%} else { %>
                    <a href="${pageContext.request.contextPath}/user"
                       class="nav-link <%= uri.startsWith(contextPath + "/userDashboard.jsp") ? "active" : "" %>">Profile</a>
                    <%}%>
                    <% } %>
                </div>
            </div>

            <!-- User/Login Section -->
            <div class="hidden md:block">
                <% if (isLoggedIn) { %>
                <div class="flex items-center space-x-2">
                    <a href="${pageContext.request.contextPath}/logout"
                       class="px-4 py-2 bg-gradient-to-r from-cyan-600 to-blue-600 rounded-lg font-medium hover:shadow-lg hover:shadow-cyan-500/30 transition-all duration-300 flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                        </svg>
                        Sign Out
                    </a>
                </div>
                <% } else if (!isLoginPage) { %>
                <a href="${pageContext.request.contextPath}/login">
                    <button id="cta-btn"
                            class="relative overflow-hidden px-6 py-2 bg-gradient-to-r from-cyan-500 to-blue-600 text-white rounded-full font-medium transition-all duration-300 hover:shadow-lg hover:shadow-cyan-500/30 hover:scale-105">
                        <span class="relative z-10">Log in</span>
                        <span class="absolute inset-0 bg-gradient-to-r from-blue-600 to-cyan-500 opacity-0 hover:opacity-100 transition-opacity duration-300 rounded-full"></span>
                    </button>
                </a>
                <% } %>
            </div>

            <!-- Mobile menu button -->
            <div class="md:hidden">
                <button id="mobile-menu-button"
                        class="text-white hover:text-cyan-400 focus:outline-none transition-all duration-300">
                    <svg class="h-8 w-8" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M4 6h16M4 12h16M4 18h16"></path>
                    </svg>
                </button>
            </div>
        </div>
    </div>

    <!-- Mobile Menu -->
    <div id="mobile-menu"
         class="md:hidden hidden bg-gray-900/95 backdrop-blur-md transition-all duration-500 overflow-hidden">
        <div class="px-4 pt-3 pb-6 space-y-2">
            <% if (isLoggedIn) { %>
            <a href="${pageContext.request.contextPath}/"
               class="mobile-menu-item <%= uri.endsWith(contextPath + "/") ? "active" : "" %>">
                   <span class="flex items-center">
                       <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                           <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                       </svg>
                       Home
                   </span>
            </a>

            <a href="${pageContext.request.contextPath}/movies"
               class="mobile-menu-item <%= uri.startsWith(contextPath + "/movie") ? "active" : "" %>">
                   <span class="flex items-center">
                       <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                           <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z"/>
                       </svg>
                       Movies
                   </span>
            </a>

            <a href="${pageContext.request.contextPath}/bookings"
               class="mobile-menu-item <%= uri.startsWith(contextPath + "/bookings") ? "active" : "" %>">
                   <span class="flex items-center">
                       <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                           <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                       </svg>
                       My Bookings
                   </span>
            </a>

            <a href="${pageContext.request.contextPath}/myReviews"
               class="mobile-menu-item <%= uri.startsWith(contextPath + "/myReviews") ? "active" : "" %>">
                   <span class="flex items-center">
                       <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                           <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"/>
                       </svg>
                       My Reviews
                   </span>
            </a>

            <% if (isAdmin) {%>
            <div class="mobile-menu-divider"></div>

            <a href="${pageContext.request.contextPath}/manageMovie"
               class="mobile-menu-item <%= uri.startsWith(contextPath + "/manageMovie.jsp") ? "active" : "" %>">
                   <span class="flex items-center">
                       <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                           <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"/>
                       </svg>
                       Manage Movies
                   </span>
            </a>
            <%}%>

            <div class="mobile-menu-divider"></div>

            <% if (isAdmin) {%>
            <a href="${pageContext.request.contextPath}/admin"
               class="mobile-menu-item <%= uri.startsWith(contextPath + "/userDashboard.jsp") ? "active" : "" %>">
                   <span class="flex items-center">
                       <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                           <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                       </svg>
                       Profile
                   </span>
            </a>
            <%} else { %>
            <a href="${pageContext.request.contextPath}/user"
               class="mobile-menu-item <%= uri.startsWith(contextPath + "/userDashboard.jsp") ? "active" : "" %>">
                   <span class="flex items-center">
                       <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                           <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                       </svg>
                       Profile
                   </span>
            </a>
            <%}%>

            <div class="mobile-menu-divider"></div>

            <a href="${pageContext.request.contextPath}/logout"
               class="mobile-menu-button flex items-center justify-center">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                </svg>
                Sign Out
            </a>
            <% } else if (!isLoginPage) { %>
            <a href="${pageContext.request.contextPath}/login" class="block w-full">
                <button class="mobile-menu-button flex items-center justify-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"/>
                    </svg>
                    Log in
                </button>
            </a>
            <% } %>
        </div>
    </div>
</nav>
<script>
    // Mobile menu toggle
    const mobileMenuButton = document.getElementById('mobile-menu-button');
    const mobileMenu = document.getElementById('mobile-menu');

    mobileMenuButton.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
        mobileMenu.classList.toggle('block');
        mobileMenuButton.classList.toggle('text-cyan-400');
    });

    // Navbar scroll effect
    const navbar = document.getElementById('navbar');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('navbar-scrolled');
        } else {
            navbar.classList.remove('navbar-scrolled');
        }
    });

    // Active link animation
    const navLinks = document.querySelectorAll('[data-link]');
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');

            // Close mobile menu if open
            if (!mobileMenu.classList.contains('hidden')) {
                mobileMenu.classList.add('hidden');
                mobileMenuButton.classList.remove('text-cyan-400');
            }
        });
    });

    // CTA button animation
    const ctaBtn = document.getElementById('cta-btn');
    if (ctaBtn) {
        ctaBtn.addEventListener('mouseenter', () => {
            ctaBtn.style.transform = 'scale(1.05)';
        });

        ctaBtn.addEventListener('mouseleave', () => {
            ctaBtn.style.transform = 'scale(1)';
        });

        ctaBtn.addEventListener('click', () => {
            ctaBtn.style.transform = 'scale(0.95)';
            setTimeout(() => {
                ctaBtn.style.transform = 'scale(1.05)';
            }, 150);
        });
    }

    // Add ripple effect to buttons
    document.querySelectorAll('button').forEach(button => {
        button.addEventListener('click', function (e) {
            const x = e.clientX - e.target.getBoundingClientRect().left;
            const y = e.clientY - e.target.getBoundingClientRect().top;

            const ripple = document.createElement('span');
            ripple.className = 'ripple';
            ripple.style.left = `${x}px`;
            ripple.style.top = `${y}px`;

            this.appendChild(ripple);

            setTimeout(() => {
                ripple.remove();
            }, 1000);
        });
    });
</script>