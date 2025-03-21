

import 'package:flutter/material.dart';
import 'package:patient/presentation/home/home_screen_slider.dart';
import '../operations/therapy_goals.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome section
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 2, 2, 2),
                      ),
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 2, 2),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Cards section
                    Expanded(
                      child: ListView(
                        children: [
                          // Autism Level Card
                          const LevelIndicator(
                            currentLevel: 5, // Replace with dynamic data
                            maxLevel: 18, // Replace with dynamic data
                          ),

                          const SizedBox(height: 15),

                          // Therapy Goals Card
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TherapyGoalsScreen()),
                              );
                            },
                            child: Card(
                              elevation: 0,
                              color: const Color(0xFFF9F3E3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30.0,
                                    horizontal: 25.0), 
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              25.0), 
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Therapy',
                                            style: TextStyle(
                                              fontSize:
                                                  24,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 2, 2, 2),
                                            ),
                                          ),
                                          Text(
                                            'Goals',
                                            style: TextStyle(
                                              fontSize:
                                                  24, 
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 2, 2, 2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      'assets/illustration1.png',
                                      height: 100,
                                      width:
                                          100,
                                      fit: BoxFit
                                          .cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 15), 

                          // Daily Activities Card
                          Card(
                            elevation: 0,
                            color: const Color(0xFFFEF4F0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30.0,
                                horizontal: 25.0,
                              ), 
                              child: Row(
                                children: [
                                  
                                  Image.asset(
                                    'assets/illustration.png',
                                    height: 100,
                                    width: 100, 
                                    fit: BoxFit
                                        .contain,
                                  ),
                                  const Spacer(),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        right: 25.0), 
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end, 
                                      children: [
                                        Text(
                                          'Daily',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Activities',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Development Milestones Card
                          Card(
                            elevation: 0,
                            color: const Color(0xFFF5FAF4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30.0,
                                  horizontal:
                                      25.0),
                              child: Row(
                                children: [
                                
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Development',
                                          style: TextStyle(
                                            fontSize: 24, 
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          'Milestones',
                                          style: TextStyle(
                                            fontSize: 24, 
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                 
                                  Image.asset(
                                    'assets/illustration2.png',
                                    height: 100, 
                                    width: 100, 
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem('assets/home.png', isSelected: true),
                  _buildNavItem('assets/Report.png'),
                  _buildNavItem(
                    'assets/Calendar.png',
                  ),
                  _buildNavItem('assets/Notifications.png'),
                  _buildNavItem(
                    'assets/Profile.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String assetPath, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        // Handle navigation here
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: ImageIcon(
          AssetImage(assetPath),
          color: isSelected ? Color(0xFFCB6CE6) : Colors.grey,
        ),
      ),
    );
  }
}
