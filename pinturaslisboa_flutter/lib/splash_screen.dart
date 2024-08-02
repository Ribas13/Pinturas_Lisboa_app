import 'package:flutter/material.dart';
import 'package:pinturaslisboa_flutter/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Pinturas Lisboa')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 96, 165),
      body: Center(
        child: Image.asset('assets/pinturas_lisboa.png', width: 300, height: 300),
      ),
    );
  }
}