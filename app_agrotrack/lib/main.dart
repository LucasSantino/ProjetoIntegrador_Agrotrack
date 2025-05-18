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

  // Tornando _widgetOptions final, já que seu valor não vai mudar
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

  // Definindo a cor padrão única (teal escuro)
  static const Color primaryColor = Color.fromRGBO(0, 150, 136, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AgroTrack - Gestão Inteligente",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: primaryColor,
      ),
      body: Center(
        child:
            _widgetOptions[selectindex](), // Chama a função para instanciar o widget
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectindex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color.fromRGBO(
          0,
          150,
          136,
          1,
        ), // usa a mesma cor da AppBar
        type: BottomNavigationBarType.fixed, // para manter a cor única
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
