import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' show Platform;

class AuthProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login() {
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        await _handleWebSignIn();
      } else {
        await _handleMobileSignIn();
      }
      _isAuthenticated = true;
      notifyListeners();
    } catch (error) {
      throw Exception('Sign in failed: $error');
    }
  }

  Future<void> _handleWebSignIn() async {
    final supabaseUrl = dotenv.env['SUPABASE_URL'] ??
        (throw Exception("Supabase URL not found in .env"));

    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: "$supabaseUrl/auth/v1/callback",
      authScreenLaunchMode: LaunchMode.platformDefault,
    );
  }

  Future<void> _handleMobileSignIn() async {
    final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'] ??
        (throw Exception("WEB_CLIENT_ID not found in .env"));
    final iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID'];
    
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS ? iosClientId : null,
      serverClientId: webClientId,
      scopes: ['email', 'profile'],
    );

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw 'Sign in cancelled';

    final GoogleSignInAuthentication googleAuth = 
        await googleUser.authentication;

    if (googleAuth.idToken == null) throw 'No ID Token found';
    if (googleAuth.accessToken == null) throw 'No Access Token found';

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: googleAuth.idToken!,
      accessToken: googleAuth.accessToken,
    );
  }

  String? getFullName() {
    final session = supabase.auth.currentSession;
    if (session == null) return null;
    return session.user.userMetadata?['full_name'] ?? 'User';
  }
}
