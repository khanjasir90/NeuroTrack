import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:therapist/core/theme/theme.dart';
import './provider/session_provider.dart';
import './provider/auth_provider.dart';
import './provider/home_provider.dart';
import './provider/therapist_provider.dart';
import './provider/consultation_provider.dart';
import './repository/supabase_consultation_repository.dart';
import './presentation/home/home_screen.dart';
import './presentation/widget/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  
  // Create the repository for consultations
  final consultationRepository = SupabaseConsultationRepository(
    supabaseClient: null,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SessionProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => TherapistDataProvider()),
        // Add the consultation provider
        ChangeNotifierProvider(
          create: (context) => ConsultationProvider(
            SupabaseConsultationRepository(supabaseClient: null),
          )..fetchConsultationRequests(),
        ),
      ],
      child: TherapyApp(),
    );
  );
}

class TherapyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get authentication state
    final authProvider = Provider.of<AuthProvider>(context);
    
    return MaterialApp(
      title: 'Therapist Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(), // Using your theme
      home: authProvider.isAuthenticated ? const HomeScreen() : SplashScreen(),
    );
  }
}