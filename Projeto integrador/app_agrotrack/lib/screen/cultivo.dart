import 'package:flutter/material.dart';

class Cultivo extends StatelessWidget {
  final List<Map<String, dynamic>> culturasCadastradas = [
    {
      'nome': 'Milho',
      'dataPlantio': '10/03/2025',
      'ciclo': '120 dias',
      'espacamento': '50 cm',
      'colheita': 'Julho',
      'solo': 'Argiloso',
      'imagem': Icons.grass,
    },
    {
      'nome': 'Tomate',
      'dataPlantio': '15/04/2025',
      'ciclo': '90 dias',
      'espacamento': '40 cm',
      'colheita': 'Julho',
      'solo': 'Arenoso',
      'imagem': Icons.local_florist,
    },
    {
      'nome': 'Feijão',
      'dataPlantio': '01/03/2025',
      'ciclo': '90 dias',
      'espacamento': '45 cm',
      'colheita': 'Junho',
      'solo': 'Arenoso',
      'imagem': Icons.eco,
    },
    {
      'nome': 'Batata',
      'dataPlantio': '20/02/2025',
      'ciclo': '110 dias',
      'espacamento': '30 cm',
      'colheita': 'Junho',
      'solo': 'Argiloso',
      'imagem': Icons.yard,
    },
    {
      'nome': 'Alface',
      'dataPlantio': '05/05/2025',
      'ciclo': '45 dias',
      'espacamento': '25 cm',
      'colheita': 'Junho',
      'solo': 'Orgânico',
      'imagem': Icons.spa,
    },
  ];

  final List<Map<String, String>> sugestoesPlantio = [
    {
      'cultura': 'Cenoura',
      'solo': 'Arenoso',
      'epoca': 'Março a Junho',
      'espacamento': '25 cm',
    },
    {
      'cultura': 'Couve',
      'solo': 'Argiloso',
      'epoca': 'Maio a Setembro',
      'espacamento': '35 cm',
    },
    {
      'cultura': 'Rabanete',
      'solo': 'Leve e arenoso',
      'epoca': 'Abril a Julho',
      'espacamento': '15 cm',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text('Plantações em Andamento',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            for (var cultura in culturasCadastradas)
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(cultura['imagem'], color: Colors.green),
                  title: Text(cultura['nome'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data de plantio: ${cultura['dataPlantio']}'),
                      Text('Ciclo: ${cultura['ciclo']}'),
                      Text('Espaçamento: ${cultura['espacamento']}'),
                      Text('Colheita prevista: ${cultura['colheita']}'),
                      Text('Tipo de solo: ${cultura['solo']}'),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
            Text('Sugestões de Plantio',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            for (var sugestao in sugestoesPlantio)
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Icon(Icons.spa, color: Colors.teal),
                  title: Text(sugestao['cultura']!,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Solo ideal: ${sugestao['solo']}'),
                      Text('Época ideal: ${sugestao['epoca']}'),
                      Text('Espaçamento: ${sugestao['espacamento']}'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
