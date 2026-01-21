<%-- 
    Document   : Add_Question
    Created on : 19 Feb, 2025, 10:20:30 PM

--%>
<%@page import="Connection.Dbconnection"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>SecureMint</title>
        <meta name="description" content="">
        <meta name="keywords" content="">



        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,300;1,400;1,500;1,600;1,700;1,800&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">

        <!-- Main CSS File -->
        <link href="css/main.css" rel="stylesheet">
        <link href="css/form.css" rel="stylesheet">


    </head>
    <style>
        #hero img{
            opacity: 2;
        }
        
      .formbold-form-input-small {
                width: 70%;
                padding: 13px 22px;
                border-radius: 5px;
                border: 1px solid #dde3ec;
                background: #ffffff;
                font-weight: 500;
                font-size: 16px;
                color: #536387;
                outline: none;
                resize: none;
            }
            
            .formbold-radio-group input[type="radio"] {
    transform: scale(1.2);
    cursor: pointer;
    margin-left: 10px;
}

    </style>
    <body class="index-page">

        
          
        <%
            Integer id = (Integer) session.getAttribute("SF_Id");
            String name = (String) session.getAttribute("Email");

            if (id != null && name != null) {
                try {
                    Dbconnection db = new Dbconnection();
                    ResultSet rs = db.Select("SELECT * FROM staff_register WHERE SF_Id='" + id + "' AND Email='" + name + "'");
                    if (rs.next()) {
                        String Staff_Name = rs.getString("User_Name");
                        String Staff_Id = rs.getString("SF_Id");
                        String Staff_Email = rs.getString("Email");
        %>
        <header id="header" class="header fixed-top">



            <div class="branding d-flex align-items-center">

                <div class="container position-relative d-flex align-items-center justify-content-between">
                    <a href="index.jsp" class="logo d-flex align-items-center">
                        <!-- Uncomment the line below if you also wish to use an image logo -->
                        <!-- <img src="assets/img/logo.png" alt=""> -->
                        <h1 class="sitename">SecureMint</h1>
                    </a>

                    <nav id="navmenu" class="navmenu">
                        <ul>             
                             <li><a href="Staff_Home.jsp" > Home</a></li>    
                            <li><a href="Create_Exam.jsp">Create Exam</a></li>            
                            <li><a href="Your_Exam.jsp"class="active">View Exam</a></li>
                            <li><a href="index.html" >Logout</a></li>
                        </ul>
                        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
                    </nav>

                </div>

            </div>

        </header>

        <main class="main">

            <!-- Hero Section -->
            <section id="hero" class="hero section dark-background">

                <img src="assets/img/home2.jpg" alt="" data-aos="fade-in">

                <div class="container" data-aos="fade-up" data-aos-delay="100">
                    <div class="row justify-content-start">
                        <div class="col-lg-8">
                            <h2>Welcome to SecureMint</h2>
                            <p>Revolutionizing Exams with Blockchain ? Secure, Transparent, and Tamper-Proof!</p>
                            <a href="#about" class="btn-get-started">Get Started</a>
                        </div>
                    </div>
                </div>

            </section><!-- /Hero Section -->
        <%
            String CE_Id = request.getParameter("CE_Id");
        %>

        <script>
            function updateCorrectAnswer(index, value) {
                document.getElementById("correctAnswer" + index).value = value;
            }
        </script>

    <h2 class="header-title">Add Exam Questions</h2>
        <div class="formbold-main-wrapper">
    <div class="formbold-form-wrapper">
        <form action="Add_Question" method="post">
            <input type="hidden" name="CE_Id" value="<%= CE_Id%>">
            <input type="hidden" id="Staff_Name" name="Staff_Name" value="<%=Staff_Name%>" readonly>
            <input type="hidden" id="Staff_Id" name="Staff_Id" value="<%=Staff_Id%>" readonly>
            <input type="hidden" id="Staff_Email" name="Staff_Email" value="<%=Staff_Email%>" readonly>

            <% for (int i = 1; i <= 10; i++) { %>
            <div class="formbold-mb-3">
                <div>
                    <label class="formbold-form-label">Question <%= i%>:</label>
                    <input type="text" name="question<%= i%>" placeholder="Enter Question" class="formbold-form-input" required>
                </div>
            </div>

            <div class="formbold-mb-3">
                <div>
                    <label class="formbold-form-label">Option A:</label>
                    <div class="formbold-radio-group">
                        <input type="text" name="optionA<%= i%>" id="optionA<%= i%>" placeholder="Enter Option A" class="formbold-form-input-small" required>
                        <input type="radio" name="correctAnswerRadio<%= i%>" onclick="updateCorrectAnswer(<%= i%>, document.getElementById('optionA<%= i%>').value)" required>
                    </div>
                </div>
            </div>

            <div class="formbold-mb-3">
                <div>
                    <label class="formbold-form-label">Option B:</label>
                    <div class="formbold-radio-group">
                        <input type="text" name="optionB<%= i%>" id="optionB<%= i%>" placeholder="Enter Option B" class="formbold-form-input-small" required>
                        <input type="radio" name="correctAnswerRadio<%= i%>" onclick="updateCorrectAnswer(<%= i%>, document.getElementById('optionB<%= i%>').value)" required>
                    </div>
                </div>
            </div>

            <div class="formbold-mb-3">
                <div>
                    <label class="formbold-form-label">Option C:</label>
                    <div class="formbold-radio-group">
                        <input type="text" name="optionC<%= i%>" id="optionC<%= i%>" placeholder="Enter Option C" class="formbold-form-input-small" required>
                        <input type="radio" name="correctAnswerRadio<%= i%>" onclick="updateCorrectAnswer(<%= i%>, document.getElementById('optionC<%= i%>').value)" required>
                    </div>
                </div>
            </div>

            <div class="formbold-mb-3">
                <div>
                    <label class="formbold-form-label">Option D:</label>
                    <div class="formbold-radio-group">
                        <input type="text" name="optionD<%= i%>" id="optionD<%= i%>" placeholder="Enter Option D" class="formbold-form-input-small" required>
                        <input type="radio" name="correctAnswerRadio<%= i%>" onclick="updateCorrectAnswer(<%= i%>, document.getElementById('optionD<%= i%>').value)" required>
                    </div>
                </div>
            </div>

            <input type="hidden" name="correctAnswer<%= i%>" id="correctAnswer<%= i%>">
            <% } %>

            <button type="submit" class="formbold-btn">Save Questions</button>
        </form>
    </div>
</div>





        </main>

        <footer id="footer" class="footer position-relative dark-background" style="background-color:white;">

            <div class="container footer-top" style="color:black;">
                <div class="row gy-4">
                    <div class="col-lg-4 col-md-6">
                        <div class="footer-about">
                            <a href="index.html" class="logo sitename">SecureMint</a>
                            <div class="footer-contact pt-3">
                                <p>Chennai Central,</p>
                                <p>Anna Salai, Chennai, 600003.</p>
                                <p class="mt-3"><strong>Phone:</strong> <span>+91 98765 41230</span></p>
                                <p><strong>Email:</strong> <span>info@bustrack.com</span></p>
                            </div>
                            <div class="social-links d-flex mt-4">
                                <a href=""><i class="bi bi-twitter-x"></i></a>
                                <a href=""><i class="bi bi-facebook"></i></a>
                                <a href=""><i class="bi bi-instagram"></i></a>
                                <a href=""><i class="bi bi-linkedin"></i></a>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-3 footer-links" style="color:black;">
                        <h4 style="color:black">Useful Links</h4>
                        <ul>
                            <li><a href="#">Home</a></li>
                            <li><a href="#">About us</a></li>
                            <li><a href="#">Services</a></li>
                            <li><a href="User_Reg.jsp">Register</a></li>
                            <li><a href="User_Log.jsp">Login</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-2 col-md-3 footer-links" style="color:black;">
                        <h4  style="color:black">Our Services</h4>
                        <ul>
                            <li><a href="#">Decentralized Auctions</a></li>
                            <li><a href="#">Smart Contract Management</a></li>
                            <li><a href="#">Bid Tracking</a></li>
                            <li><a href="#">Transaction History</a></li>
                            <li><a href="#">Instant Alerts</a></li>
                        </ul>

                    </div>

                    <div class="col-lg-4 col-md-12 footer-newsletter">
                        <h4  style="color:black">Our Newsletter</h4>
                        <p style="color:black">Subscribe to our newsletter and receive the latest news about auctions!</p>
                        <form action="forms/newsletter.php" method="post" class="php-email-form">
                            <div class="newsletter-form"><input type="email" name="email"><input type="submit" value="Subscribe"></div>
                            <div class="loading">Loading</div>
                            <div class="error-message"></div>
                            <div class="sent-message">Your subscription request has been sent. Thank you!</div>
                        </form>
                    </div>

                </div>
            </div>

  
        <%
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        } else {
            session.setAttribute("msg", "Session Out Please Login");
            response.sendRedirect("error.jsp");
        }
        %>
        

        </footer>

        <!-- Scroll Top -->
        <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

        <!-- Preloader -->


        <!-- Vendor JS Files -->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>
        <script src="assets/vendor/aos/aos.js"></script>
        <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
        <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
        <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>

        <!-- Main JS File -->
        <script src="js/main.js"></script>

    </body>
</html>


