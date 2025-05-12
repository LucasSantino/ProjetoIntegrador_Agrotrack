import 'package:flutter/material.dart';

class Sensores extends StatefulWidget {
  const Sensores({super.key});

  @override
  State<Sensores> createState() => _SensoresState();
}

class _SensoresState extends State<Sensores> {
  double temperatura = 28.0;
  double umidade = 42.0;
  double luminosidade = 700.0;
  double ph = 6.5;
  double qualidadeAr = 55.0;

  void atualizarDados() {
    setState(() {
      temperatura = 26.0 + (2 * (1 - 2 * (DateTime.now().second % 2)));
      umidade = 40.0 + (2 * (DateTime.now().second % 3));
      luminosidade = 680 + (DateTime.now().second % 40);
      ph = 6.0 + ((DateTime.now().second % 10) / 10);
      qualidadeAr = 50.0 + (DateTime.now().second % 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Monitoramento: Sensores',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildSensorExpansionTile(
              icon: Icons.thermostat,
              title: 'Temperatura',
              value: '$temperatura °C',
              color: Colors.red,
              detalhes: [
                'Nível adequado: 22°C a 30°C',
                'Localização: Estufa Principal',
                _buildStatusText(true),
                'Última leitura: Agora',
                'Última calibração: 2 dias atrás',
                'Estado: Bom',
              ],
            ),
            _buildSensorExpansionTile(
              icon: Icons.water_drop,
              title: 'Umidade do Solo',
              value: '$umidade %',
              color: Colors.blue,
              detalhes: [
                'Nível adequado: 40% a 60%',
                'Localização: Horta externa',
                _buildStatusText(true),
                'Última leitura: Agora',
                'Última calibração: 3 dias atrás',
                'Estado: Bom',
              ],
            ),
            _buildSensorExpansionTile(
              icon: Icons.wb_sunny,
              title: 'Luminosidade',
              value: '$luminosidade lux',
              color: Colors.amber,
              detalhes: [
                'Nível adequado: 600 a 800 lux',
                'Localização: Topo da Estufa',
                _buildStatusText(true),
                'Última leitura: Agora',
                'Última calibração: 1 dia atrás',
                'Estado: Precisa de manutenção',
              ],
            ),
            _buildSensorExpansionTile(
              icon: Icons.science,
              title: 'pH da Água',
              value: '$ph',
              color: Colors.purple,
              detalhes: [
                'Nível adequado: 5.5 a 6.5',
                'Localização: Sistema Hidropônico',
                _buildStatusText(true),
                'Última leitura: Agora',
                'Última calibração: 2 dias atrás',
                'Estado: Bom',
              ],
            ),
            _buildSensorExpansionTile(
              icon: Icons.cloud,
              title: 'Qualidade do Ar',
              value: '$qualidadeAr %',
              color: Colors.green,
              detalhes: [
                'Nível adequado: Acima de 50%',
                'Localização: Entrada de Ar',
                _buildStatusText(true),
                'Última leitura: Agora',
                'Última calibração: 4 dias atrás',
                'Estado: Bom',
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: atualizarDados,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  'Atualizar Dados',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildStatusText(bool isAtivo) {
    return isAtivo ? 'Status: Ativo' : 'Status: Desativado';
  }

  Widget _buildSensorExpansionTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required List<String> detalhes,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: detalhes.map((texto) {
          final isStatusLine = texto.contains('Status:');
          final isAtivo = texto.contains('Ativo');

          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '• $texto',
                style: TextStyle(
                  fontSize: 14,
                  color: isStatusLine
                      ? (isAtivo ? Colors.green : Colors.red)
                      : Colors.black87,
                  fontWeight:
                      isStatusLine ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
