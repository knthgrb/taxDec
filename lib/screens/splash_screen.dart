import 'package:flutter/material.dart';
import 'package:tax/main.dart';
import 'package:tax/screens/home_screen.dart';
import 'package:tax/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);

    final session = supabase.auth.currentSession;

    if (!mounted) return;

    if (session != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder widget while waiting for authentication state
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
