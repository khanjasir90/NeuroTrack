import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:therapist/provider/consultation_provider.dart';
import 'package:therapist/provider/session_provider.dart'; // Add this import
import 'package:therapist/repository/supabase_consultation_repository.dart';

import 'presentation/splash_screen.dart';
import 'provider/auth_provider.dart';
import 'provider/home_provider.dart';
import 'provider/therapist_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Create the repository for consultations
  final consultationRepository = SupabaseConsultationRepository(
    supabaseClient: Supabase.instance.client, // Pass the actual client
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => TherapistDataProvider()),
        ChangeNotifierProvider(
          create: (context) => ConsultationProvider(consultationRepository),
        ),
        // Add SessionProvider
        ChangeNotifierProvider(create: (context) => SessionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Therapist App',
      theme: ThemeData.light(),
      home: const SplashScreen(),
    );
  }
}
