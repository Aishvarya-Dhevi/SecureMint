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
        <script src="https://cdn.jsdelivr.net/npm/web3/dist/web3.min.js"></script>


    </head>
    <style>
        #hero img{
            opacity: 2;
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
                            <li><a href="Create_Exam.jsp"class="active">Create Exam</a></li>            
                            <li><a href="Your_Exam.jsp">View Exam</a></li>
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

           
  
            <h2 class="header-title">Create Exam</h2>
            <div class="formbold-main-wrapper">
                <div class="formbold-form-wrapper">
                    <form action="Create_Exam" id="createExamForm" method="POST" enctype="multipart/form-data">
                        <!-- User Name -->
                        <div class="formbold-mb-3">
                            <div>
                                <label for="name" class="formbold-form-label">Exam Name:</label>
                                <input type="text" id="examname" name="Exam_Name" placeholder="Enter Exam name" class="formbold-form-input" required>
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="formbold-mb-3">
                            <div>
                                <label for="email" class="formbold-form-label">Start Time:</label>
                                <input type="datetime-local" id="startTime" name="Start_Time"  class="formbold-form-input" required>
                            </div>
                        </div>

                        <!-- Password -->
                        <div class="formbold-mb-3">
                            <div>
                                <label for="password" class="formbold-form-label">End Time:</label>
                                <input type="datetime-local" id="endTime" name="End_Time"  class="formbold-form-input" required>
                            </div>
                        </div>

                        <!-- Contact Number -->
                        <div class="formbold-mb-3">
                            <div>
                                <label for="contact" class="formbold-form-label">Duration:</label>
                                <input type="text" id="duration" name="Duration" placeholder="Exam Duration" class="formbold-form-input" required>
                            </div>
                        </div>

                        <!-- State -->
                        <div class="formbold-mb-3">
                            <div>
                                <label for="state" class="formbold-form-label">Total Marks:</label>
                                <input type="text" id="totalMarks" name="Total_Marks" placeholder="Enter Total Marks" class="formbold-form-input" required>
                            </div>
                        </div>

                        <!-- City -->
                        <div class="formbold-mb-3">
                            <div>
                                <label for="city" class="formbold-form-label">Total Questions:</label>
                                <input type="number" id="totalQuestions" name="Total_Ques" placeholder="Enter Total Questions" class="formbold-form-input" required>
                            </div>
                        </div>
                        
                        <input type="hidden" id="Staff_Name" name="Staff_Name" value="<%=Staff_Name%>" readonly>
                        <input type="hidden" id="Staff_Name" name="Staff_Id" value="<%=Staff_Id%>" readonly>
                        <input type="hidden" id="Staff_Name" name="Staff_Email" value="<%=Staff_Email%>" readonly>
                        
                        <!-- Submit Button -->
                        <button type="submit" class="formbold-btn">Create Exam</button>
                    </form>
                </div>
            </div>
<script>
function updateOptions(questionNumber) {
    for (let i = 1; i <= 4; i++) {
        let optionInput = document.getElementsByName(`option${questionNumber}_${i}`)[0]; // Get the input field
        let correctAnswerOption = document.getElementById(`option${questionNumber}_${i}`); // Get the dropdown option

        if (optionInput && correctAnswerOption) {
            correctAnswerOption.textContent = optionInput.value.trim() !== "" ? optionInput.value : `Option ${i}`; 
        }
    }
}
</script>


<script>
    async function createExamOnBlockchain() {
        try {
            // Check if MetaMask (or another Web3 provider) is available
            if (typeof window.ethereum === 'undefined') {
                alert("Please install MetaMask to use this feature!");
                return;
            }

            // Initialize Web3
            const web3 = new Web3(window.ethereum);
            await window.ethereum.enable();

            // Smart contract details
            const contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138"; // Replace with your deployed contract address
            const abi = [
                {
                    "inputs": [
                        { "internalType": "string", "name": "_examName", "type": "string" },
                        { "internalType": "uint256", "name": "_startTime", "type": "uint256" },
                        { "internalType": "uint256", "name": "_endTime", "type": "uint256" },
                        { "internalType": "uint256", "name": "_duration", "type": "uint256" },
                        { "internalType": "uint256", "name": "_totalMarks", "type": "uint256" },
                        { "internalType": "uint256", "name": "_totalQuestions", "type": "uint256" }
                    ],
                    "name": "createExam",
                    "outputs": [],
                    "stateMutability": "nonpayable",
                    "type": "function"
                }
            ];

            const contract = new web3.eth.Contract(abi, contractAddress);

            // Get the current user's Ethereum address
            const accounts = await web3.eth.getAccounts();

            // Collect form data
            const examName = document.getElementById('examname').value;
            const startTime = new Date(document.getElementById('startTime').value).getTime() / 1000; // Convert to UNIX timestamp
            const endTime = new Date(document.getElementById('endTime').value).getTime() / 1000; // Convert to UNIX timestamp
            const duration = parseInt(document.getElementById('duration').value);
            const totalMarks = parseInt(document.getElementById('totalMarks').value);
            const totalQuestions = parseInt(document.getElementById('totalQuestions').value);

            // Call the smart contract function to create an exam
            await contract.methods.createExam(
                examName,
                startTime,
                endTime,
                duration,
                totalMarks,
                totalQuestions
            ).send({ from: accounts[0] });

            alert("Exam successfully created on the blockchain!");

        } catch (error) {
            console.error("Blockchain error:", error);
            alert("Failed to create exam on the blockchain. Please try again.");
        }
    }

    // Handle form submission
    document.getElementById('createExamForm').onsubmit = async function (event) {
        event.preventDefault(); // Prevent default form submission

        // Add exam to the blockchain
        await createExamOnBlockchain();

        // Submit the form data to the server
        this.submit();
    };
</script>



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


