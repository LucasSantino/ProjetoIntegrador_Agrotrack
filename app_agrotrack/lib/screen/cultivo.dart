import 'package:flutter/material.dart';
import 'cadastrocultivo.dart'; // importe a nova tela

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Plantações em Andamento',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle,
                      color: Color.fromRGBO(0, 150, 136, 1), size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CadastroCultivo()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (var cultura in culturasCadastradas)
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  // Ajuste do padding interno do ListTile para dar mais espaço geral
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  // Adiciona padding extra ao ícone para aumentar distância das informações
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(cultura['imagem'], color: Colors.green, size: 32),
                  ),
                  title: Text(cultura['nome'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
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
            const Text('Sugestões de Plantio',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            for (var sugestao in sugestoesPlantio)
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  leading: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.spa, color: Colors.teal, size: 32),
                  ),
                  title: Text(sugestao['cultura']!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
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
