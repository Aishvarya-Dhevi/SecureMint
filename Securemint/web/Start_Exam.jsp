<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.Connection"%>
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
        
    </head>
  
    
    
    <body class="index-page">

      
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
                             <li><a href="Student_Home.jsp" > Home</a></li>    
                            <li><a href="Student_View_Exam.jsp" class="active">View Exam</a></li>                                        
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

    if (CE_Id == null) {
        response.sendRedirect("student_dashboard.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int duration = 0;
    String Exam_Name=null;
    JSONArray questions = new JSONArray();

    Integer id = (Integer) session.getAttribute("ST_ID");
    String email = (String) session.getAttribute("Email");

    if (id == null || email == null) {
        session.setAttribute("msg", "Session Expired! Please Login.");
        response.sendRedirect("error.jsp");
        return;
    }

    String userName = "", college = "", department = "";

    try {
        Class.forName("com.mysql.jdbc.Driver"); // Use the latest driver
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam_guard", "root", "admin");

        // Fetch exam duration
        ps = con.prepareStatement("SELECT Duration,Exam_Name FROM create_exam WHERE CE_Id = ?");
        ps.setString(1, CE_Id);
        rs = ps.executeQuery();
        if (rs.next()) {
            duration = rs.getInt("Duration");
            Exam_Name=rs.getString("Exam_Name");
            
        }
        rs.close();
        ps.close();

        // Fetch student details
        ps = con.prepareStatement("SELECT User_Name, College_Name, Department FROM student_register WHERE ST_ID = ? AND Email = ?");
        ps.setInt(1, id);
        ps.setString(2, email);
        rs = ps.executeQuery();
        if (rs.next()) {
            userName = rs.getString("User_Name");
            college = rs.getString("College_Name");
            department = rs.getString("Department");
        }
        rs.close();
        ps.close();

        // Fetch questions for the exam
        ps = con.prepareStatement("SELECT id, question, optionA, optionB, optionC, optionD FROM questions WHERE CE_Id = ?");
        ps.setString(1, CE_Id);
        rs = ps.executeQuery();

        while (rs.next()) {
            JSONObject question = new JSONObject();
            question.put("id", rs.getInt("id"));
            question.put("question", rs.getString("question"));  // Fixed column name case
            question.put("optionA", rs.getString("optionA"));
            question.put("optionB", rs.getString("optionB"));
            question.put("optionC", rs.getString("optionC"));
            question.put("optionD", rs.getString("optionD"));
            questions.put(question);
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (con != null) {
            con.close();
        }
    }
%>


  
        <script>


    // Function to store selected answers using sessionStorage (compatible with ES5)
            function saveAnswer(questionId, answer) {
                var savedData = sessionStorage.getItem("examAnswers");
                savedData = savedData ? JSON.parse(savedData) : {};
                savedData[questionId] = answer;
                sessionStorage.setItem("examAnswers", JSON.stringify(savedData));
            }

    // Function to retrieve saved answers
            function getSavedAnswer(questionId) {
                var savedData = sessionStorage.getItem("examAnswers");
                savedData = savedData ? JSON.parse(savedData) : {};
                return savedData[questionId] || "";
            }

            var questions = <%= questions.toString()%>;
            var currentQuestionIndex = 0;
            var timeLeft = <%= duration * 60%>;

    // Start the countdown timer
            function startTimer() {
                var timerElement = document.getElementById("timer");
                var countdown = setInterval(function () {
                    var minutes = Math.floor(timeLeft / 60);
                    var seconds = timeLeft % 60;
                    timerElement.innerHTML = "Time Left: " + minutes + "m " + seconds + "s";

                    if (timeLeft <= 0) {
                        clearInterval(countdown);
                        alert("Time is up! Submitting your exam.");
                        document.getElementById("examForm").submit();
                    }
                    timeLeft--;
                }, 1000);
            }

    // Show a question and restore previously selected answer
            function showQuestion(index) {
                if (index < 0 || index >= questions.length)
                    return;
                currentQuestionIndex = index;

                var q = questions[index];
                var questionText = document.getElementById("questionText");
                var optionsContainer = document.getElementById("options");

                questionText.innerHTML = "<strong>Q" + (index + 1) + ":</strong> " + q.question;

                var savedAnswer = getSavedAnswer(q.id);

                optionsContainer.innerHTML =
    '<label class="option-label"><input type="radio" name="answer_' + q.id + '" value="' + q.optionA + '" ' + (savedAnswer === q.optionA ? "checked" : "") + '><span class="option">' + q.optionA + '</span></label><br>' +
    '<label class="option-label"><input type="radio" name="answer_' + q.id + '" value="' + q.optionB + '" ' + (savedAnswer === q.optionB ? "checked" : "") + '><span class="option">' + q.optionB + '</span></label><br>' +
    '<label class="option-label"><input type="radio" name="answer_' + q.id + '" value="' + q.optionC + '" ' + (savedAnswer === q.optionC ? "checked" : "") + '><span class="option">' + q.optionC + '</span></label><br>' +
    '<label class="option-label"><input type="radio" name="answer_' + q.id + '" value="' + q.optionD + '" ' + (savedAnswer === q.optionD ? "checked" : "") + '><span class="option">' + q.optionD + '</span></label><br>';

                // Save selected answer when an option is clicked
                var radioButtons = document.getElementsByName("answer_" + q.id);
                for (var i = 0; i < radioButtons.length; i++) {
                    radioButtons[i].addEventListener("change", function () {
                        saveAnswer(q.id, this.value);
                    });
                }

                // Enable/Disable navigation buttons
                document.getElementById("prevBtn").disabled = (index === 0);
                document.getElementById("nextBtn").disabled = (index === questions.length - 1);
            }

    // Move to the next question
            function nextQuestion() {
                showQuestion(currentQuestionIndex + 1);
            }

    // Move to the previous question
            function prevQuestion() {
                showQuestion(currentQuestionIndex - 1);
            }

    // Prevent accidental refresh or page leave
            window.onbeforeunload = function () {
                return "Are you sure you want to leave? Your progress may be lost!";
            };

    // Initialize the exam when the page loads
            window.onload = function () {
                if (questions.length === 0) {
                    alert("No questions available for this exam.");
                } else {
                    startTimer();
                    showQuestion(0);
                }
            };


        </script>
    </head>
    <body>

            <div class="exam-wrapper">
    <!-- Left Panel (Student Info) -->
    
    <div class="student-info">
        <img src="Student_Img.jsp?name=<%= id%>" alt="Product Image" width="200px;">
        <h3><%= userName%></h3>
        <p>College: <%= college%></p>
        <p>Department: <%= department%></p>
    </div>

    <!-- Middle Panel (Questions) -->
    <div class="exam-container">
        <h2 style="color:black;text-align: center;"><%=Exam_Name%> Exam Questions</h2>
        
        <form id="examForm" action="SubmitExam.jsp" method="post">
            <input type="hidden" name="CE_Id" value="<%= CE_Id%>">
            <div class="question-container" id="questionText"><h2></h2></div>
            <div id="options" class="option-container"></div>

            <div class="navigation">
                <button type="button" id="prevBtn" onclick="prevQuestion()">Previous</button>
                <button type="button" id="nextBtn" onclick="nextQuestion()">Next</button>
            </div>
            <button type="submit" class="submit-btn">Submit Exam</button>
        </form>
    </div>

    <!-- Right Panel (Timer) -->
   <div class="timer-section">
    <h3>Time Remaining</h3>
    <p id="timer" class="timer"></p>

    <!-- Video Container -->
    <div class="video-container">
        <video id="userVideo" autoplay></video>
        <div class="video-cover"></div>
    </div>
</div>

</div>
            
            <script>
                
                document.addEventListener("DOMContentLoaded", function () {
    const video = document.getElementById("userVideo");

    // Check if browser supports getUserMedia
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
        navigator.mediaDevices.getUserMedia({ video: true })
            .then(function (stream) {
                video.srcObject = stream;
            })
            .catch(function (error) {
                console.error("Camera access denied!", error);
            });
    } else {
        console.error("getUserMedia is not supported in this browser.");
    }
});

            </script>
            <style>
            
            /* General Styles */


.exam-wrapper {
    display: flex;
    justify-content: space-between;
    width: 100%;
    margin: auto;
    padding: 20px;
    background: #000;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);

}
.option{
    color:black;
    padding: 10px;
    padding-bottom: 30px;
}


/* Student Info Panel */
.student-info {
    width: 25%;
    background: #007bff;
    color: white;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
}

/* Exam Container */
.exam-container {
    width: 50%;
    background: #ddd;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.1);
}

/* Question Box */
.question-container {
    background: #f9f9f9;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 15px;
    font-size: 18px;
    font-weight: bold;
    color:black;
}

.option-container{
    margin-bottom: 20px;
    line-height: 35px;

}
/* Timer Section */
.timer-section {
    width: 20%;
    background: #ff4444;
    color: white;
    text-align: center;
    padding: 20px;
    border-radius: 10px;
}

/* Timer */
.exam-timer {
    font-size: 24px;
    font-weight: bold;
}

/* Navigation Buttons */
.navigation {
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
}

.navigation button {
    padding: 10px 15px;
    font-size: 16px;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}

#prevBtn {
    background: #6c757d;
    color: white;
}

#nextBtn {
    background: #28a745;
    color: white;
}
.student-info img {
    width: 170px;  /* Adjust width as needed */
    height: 170px; /* Ensure it maintains a circular shape */
    border-radius: 50%;
    object-fit: cover; /* Ensures the image fills the circle */
    border: 3px solid white; /* Optional: adds a border */
    display: block;
    margin: 0 auto 10px; /* Centers the image */
}


/* Submit Button */
.submit-btn {
    width: 100%;
    background: #ff5722;
    color: white;
    padding: 12px;
    font-size: 18px;
    margin-top: 20px;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}

.submit-btn:hover {
    background: #e64a19;
}

.video-container {
    position: relative;
    width: 100%;
    height: 150px; /* Adjust height as needed */
    overflow: hidden;
    border-radius: 10px;
    margin-top: 10px;
}

#userVideo {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 10px;
}

/* Video Cover Overlay */
.video-cover {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.3); /* Semi-transparent overlay */
    border-radius: 10px;
}

</style>

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

