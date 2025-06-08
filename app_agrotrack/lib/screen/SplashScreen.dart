import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _logoOpacity = 0.0;
  double _textOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // 1) Fade-in do logo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _logoOpacity = 1.0;
      });
    });

    // 2) Depois de 2s, inicia fade-out do logo e fade-in do texto
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _logoOpacity = 0.0;
        _textOpacity = 1.0;
      });
    });

    // 3) Depois de mais 2s, navega para a tela de login
    Future.delayed(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: _logoOpacity,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Image.asset(
                'assets/images/logoAgrotrack_sem fundo 2 - Copia.png',
                width: 150,
                height: 150,
              ),
            ),
            AnimatedOpacity(
              opacity: _textOpacity,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: const Text(
                'AgroTrack',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 150, 136, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
