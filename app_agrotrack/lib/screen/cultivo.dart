import 'package:flutter/material.dart';
import 'cadastrocultivo.dart'; // importe a nova tela

class Cultivo extends StatefulWidget {
  @override
  _CultivoState createState() => _CultivoState();
}

class _CultivoState extends State<Cultivo> {
  String? filtroSolo;
  String? filtroMes;

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

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> culturasFiltradas =
        culturasCadastradas.where((cultura) {
          bool soloCond = filtroSolo == null || cultura['solo'] == filtroSolo;
          bool mesCond =
              filtroMes == null ||
              cultura['dataPlantio'].toString().contains(filtroMes!);
          return soloCond && mesCond;
        }).toList();

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
                  icon: const Icon(
                    Icons.add_circle,
                    color: Color.fromRGBO(0, 150, 136, 1),
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CadastroCultivo(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Filtros minimalistas
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: filtroSolo,
                    decoration: InputDecoration(
                      labelText: 'Solo',
                      labelStyle: const TextStyle(color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 150, 136, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                    items:
                        ['Argiloso', 'Arenoso', 'Orgânico']
                            .map(
                              (solo) => DropdownMenuItem(
                                value: solo,
                                child: Text(solo),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        filtroSolo = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: filtroMes,
                    decoration: InputDecoration(
                      labelText: 'Mês de Plantio',
                      labelStyle: const TextStyle(color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 150, 136, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                    items:
                        ['01', '02', '03', '04', '05']
                            .map(
                              (mes) => DropdownMenuItem(
                                value: mes,
                                child: Text('Mês $mes'),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        filtroMes = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            for (var cultura in culturasFiltradas)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      cultura['imagem'],
                      color: Colors.green,
                      size: 32,
                    ),
                  ),
                  title: Text(
                    cultura['nome'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
          ],
        ),
      ),
    );
  }
}
