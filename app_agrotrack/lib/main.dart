import 'package:flutter/material.dart';
import 'package:app_agrotrack/screen/home.dart';
import 'package:app_agrotrack/screen/sensores.dart';
import 'package:app_agrotrack/screen/automacao.dart';
import 'package:app_agrotrack/screen/cultivo.dart';
import 'package:app_agrotrack/screen/chatbot.dart';

void main() {
  runApp(NavBottom());
}

class NavBottom extends StatelessWidget {
  const NavBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: NavScreen());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true, // centraliza o conteúdo do title
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo_AgroTrack.png',
              height: 180,
              color: Colors.white, // deixa a imagem branca
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
      ),
      body: Center(child: _widgetOptions[selectindex]()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectindex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Sensores',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.water), label: 'Automação'),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Cultivo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'Chatbot',
          ),
        ],
        onTap: onItemTapped,
      ),
    );
  }
}

/*  código antigo
import 'package:flutter/material.dart';
import 'package:app_agrotrack/screen/home.dart';
import 'package:app_agrotrack/screen/sensores.dart';
import 'package:app_agrotrack/screen/automacao.dart';
import 'package:app_agrotrack/screen/cultivo.dart';
import 'package:app_agrotrack/screen/chatbot.dart';

void main() {
  runApp(const NavBottom());
}

class NavBottom extends StatelessWidget {
  const NavBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NavScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true, // centraliza o conteúdo do title
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo_AgroTrack.png',
              height: 180,
              color: Colors.white,
            ),
            // Aqui usamos Transform.translate para reduzir o espaçamento com deslocamento negativo
            Transform.translate(
              offset: const Offset(
                -8,
                -0,
              ), // desloca o texto 6 pixels para a esquerda
              child: const Text(
                "Gestão inteligente",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(child: _widgetOptions[selectindex]()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectindex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Sensores',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.water), label: 'Automação'),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Cultivo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'Chatbot',
          ),
        ],
        onTap: onItemTapped,
      ),
    );
  }

*/
