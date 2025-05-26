import 'package:flutter/material.dart';
import 'package:app_agrotrack/screen/home.dart';
import 'package:app_agrotrack/screen/sensores.dart';
import 'package:app_agrotrack/screen/automacao.dart';
import 'package:app_agrotrack/screen/cultivo.dart';
import 'package:app_agrotrack/screen/chatbot.dart';
import 'package:app_agrotrack/screen/login.dart';
import 'package:app_agrotrack/screen/splashscreen.dart'; // << NOVO

void main() {
  runApp(const AgroTrackApp());
}

class AgroTrackApp extends StatelessWidget {
  const AgroTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // << INICIA NA SPLASH
      routes: {
        '/nav': (context) => const NavScreen(),
        '/login': (context) => const Login(),
      },
    );
  }
}

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int selectindex = 0;

  static final List<Widget Function()> _widgetOptions = <Widget Function()>[
    () => Home(),
    () => Sensores(),
    () => Automacao(),
    () => Cultivo(),
    () => Chatbot(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectindex = index;
    });
  }

  static const Color primaryColor = Color.fromRGBO(0, 150, 136, 1);

  void _mostrarDialogoLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            "Deseja finalizar a sua sessão?",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Não", style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Sim", style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo_AgroTrack.png',
              height: 180,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            const Text(
              "",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _mostrarDialogoLogout(context),
          ),
        ],
      ),
      body: Center(child: _widgetOptions[selectindex]()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectindex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Sensores',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.water), label: 'Automação'),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Plantações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'Agrochat',
          ),
        ],
        onTap: onItemTapped,
      ),
    );
  }
}
