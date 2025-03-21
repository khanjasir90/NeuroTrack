

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient/presentation/widgets/google_signin_button.dart';
import '../widgets/welcome_header.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient/presentation/auth/personal_details_screen.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;
  final supabase = Supabase.instance.client;
  StreamSubscription<AuthState>? _authSubscription;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: 'assets/illustration.png',
      title: 'Daily Activities',
      description: 'Personalized Daily Activities, Tracked Effortlessly!',
    ),
    OnboardingContent(
      image: 'assets/illustration1.png',
      title: 'Therapy Goals',
      description: 'Set and achieve your therapy goals with ease!',
    ),
    OnboardingContent(
      image: 'assets/illustration2.png',
      title: 'Health Tracking',
      description: 'Monitor your health metrics with ease and accuracy!',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _initializeAuthListener();
  }

  void _initializeAuthListener() {
    _authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final session = supabase.auth.currentSession;
      if (session != null && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleSuccessfulAuth(session);
        });
      }
    });
  }

  void _handleSuccessfulAuth(Session session) {
    final fullName = session.user.userMetadata?['full_name'];
    final email = session.user.email ?? 'Unknown User';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signed in as ${fullName ?? email}'),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const PersonalDetailsScreen(),
      ),
    );
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _contents.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WelcomeHeader(),
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _contents.length,
                  onPageChanged: (int page) {
                    setState(() => _currentPage = page);
                  },
                  itemBuilder: (context, index) => _buildCarouselItem(_contents[index]),
                ),

                Positioned(
                  bottom: 120,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _contents.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                ),

                const Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: GoogleSignInButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(OnboardingContent content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(content.image, height: 200),
        const SizedBox(height: 35),
        Text(
          content.title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            content.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 60),

      ],
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blueAccent : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}
