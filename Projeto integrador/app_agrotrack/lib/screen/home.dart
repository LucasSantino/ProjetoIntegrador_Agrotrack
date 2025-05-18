import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Ativa rolagem
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Bem-vindo ao Agrotrack!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              Text(
                'Status do Sistema:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),

              // Card agrupado do sistema
              _buildGroupedCard([
                _buildItem(
                    icon: Icons.check_circle_outline,
                    title: 'Status Geral',
                    value: 'Tudo funcionando normalmente',
                    color: Colors.green),
                _buildItem(
                    icon: Icons.warning_amber_outlined,
                    title: 'Alerta',
                    value: 'Nenhum alerta no momento',
                    color: Colors.orange),
                _buildItem(
                    icon: Icons.water,
                    title: 'Bomba de Irrigação',
                    value: 'Ligada',
                    color: Colors.blue),
                _buildItem(
                    icon: Icons.autorenew,
                    title: 'Funcionamento da Bomba',
                    value: 'Automático',
                    color: Colors.teal),
              ]),

              const SizedBox(height: 24),
              Text(
                'Sensores em tempo real:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),

              // Card agrupado dos sensores
              _buildGroupedCard([
                _buildItem(
                  icon: Icons.thermostat,
                  title: 'Temperatura',
                  value: '28°C',
                  color: Colors.red,
                ),
                _buildItem(
                  icon: Icons.water_drop,
                  title: 'Umidade do Solo',
                  value: '42%',
                  color: Colors.blue,
                ),
                _buildItem(
                  icon: Icons.wb_sunny,
                  title: 'Luminosidade',
                  value: '700 lux',
                  color: Colors.amber,
                ),
                _buildItem(
                  icon: Icons.science,
                  title: 'pH da água',
                  value: '6.5',
                  color: Colors.purple,
                ),
                _buildItem(
                  icon: Icons.cloud,
                  title: 'Qualidade do Ar',
                  value: '55%',
                  color: Colors.green,
                ),
              ]),

              const SizedBox(height: 24),
              Text(
                'Plantas Cultivadas:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),

              // Card agrupado das plantas
              _buildGroupedCard([
                _buildItem(
                    icon: Icons.eco, title: 'Alface', value: 'Em crescimento'),
                _buildItem(
                    icon: Icons.eco,
                    title: 'Tomate',
                    value: 'Pronta para colheita'),
                _buildItem(
                    icon: Icons.eco,
                    title: 'Cenoura',
                    value: 'Plantada recentemente'),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupedCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String title,
    required String value,
    Color color = Colors.teal,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
