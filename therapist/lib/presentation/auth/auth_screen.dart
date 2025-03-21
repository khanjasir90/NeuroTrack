import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../home/home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll(); // Start auto-scrolling animation
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0; // Loop back to the first page
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when leaving the screen
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * 0.2,
                decoration: const BoxDecoration(
                  color: Color(0xFFB066E4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(200),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.07,
                left: screenWidth * 0.08,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome To,",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Therapy App",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Carousel Section
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                _buildPage(
                  title: "Welcome To",
                  appName: "Therapy App",
                  description:
                      "Effortlessly manage patients & enhance therapy progress.",
                  image: "assets/manage_patients.png",
                ),
                _buildPage(
                  title: "Daily Activities",
                  appName: "Stay on Track",
                  description:
                      "Personalized Daily Activities, Tracked Effortlessly!",
                  image: "assets/daily_activities.png",
                ),
                _buildPage(
                  title: "Health Tracking",
                  appName: "Monitor Progress",
                  description:
                      "Track your health and therapy goals effectively.",
                  image: "assets/health_tracking.png",
                ),
              ],
            ),
          ),

          // Page Indicator
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: WormEffect(
                dotHeight: 8, dotWidth: 8, activeDotColor: Colors.purple),
          ),
          SizedBox(height: 20),

          // Google Sign-In Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/google_logo.png", height: 24),
                  SizedBox(width: 10),
                  Text(
                    "Continue with Google",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPage(
      {required String title,
      required String appName,
      required String description,
      required String image}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          

          // Illustration
          Image.asset(image, height: 250),
          SizedBox(height: 20),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
