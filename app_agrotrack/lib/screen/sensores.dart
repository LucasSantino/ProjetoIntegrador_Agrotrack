import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
              'Monitoramento dos Sensores',
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
              dadosGrafico: [
                FlSpot(0, 26),
                FlSpot(1, 27),
                FlSpot(2, 28),
                FlSpot(3, 29),
                FlSpot(4, 27),
                FlSpot(5, 28),
                FlSpot(6, temperatura),
              ],
              corGrafico: Colors.red,
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
              dadosGrafico: [
                FlSpot(0, 38),
                FlSpot(1, 40),
                FlSpot(2, 42),
                FlSpot(3, 41),
                FlSpot(4, 43),
                FlSpot(5, 42),
                FlSpot(6, umidade),
              ],
              corGrafico: Colors.blue,
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
              dadosGrafico: [
                FlSpot(0, 670),
                FlSpot(1, 680),
                FlSpot(2, 690),
                FlSpot(3, 700),
                FlSpot(4, 710),
                FlSpot(5, 700),
                FlSpot(6, luminosidade),
              ],
              corGrafico: Colors.amber,
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
              dadosGrafico: [
                FlSpot(0, 6.0),
                FlSpot(1, 6.1),
                FlSpot(2, 6.2),
                FlSpot(3, 6.3),
                FlSpot(4, 6.4),
                FlSpot(5, 6.3),
                FlSpot(6, ph),
              ],
              corGrafico: Colors.purple,
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
              dadosGrafico: [
                FlSpot(0, 50),
                FlSpot(1, 52),
                FlSpot(2, 54),
                FlSpot(3, 56),
                FlSpot(4, 55),
                FlSpot(5, 54),
                FlSpot(6, qualidadeAr),
              ],
              corGrafico: Colors.green,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
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
    required List<FlSpot> dadosGrafico,
    required Color corGrafico,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          ...detalhes.map((texto) {
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
                    color:
                        isStatusLine
                            ? (isAtivo ? Colors.green : Colors.red)
                            : Colors.black87,
                    fontWeight:
                        isStatusLine ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Histórico (útimos 7 dias)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: corGrafico,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY:
                    dadosGrafico
                        .map((e) => e.y)
                        .reduce((a, b) => a > b ? a : b) *
                    1.3,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, _) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      getTitlesWidget: (value, _) {
                        const labels = [
                          '6d',
                          '5d',
                          '4d',
                          '3d',
                          '2d',
                          '1d',
                          'Hoje',
                        ];
                        return Text(
                          labels[value.toInt()],
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black26),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: dadosGrafico,
                    isCurved: true,
                    color: corGrafico,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                      show: true,
                      color: corGrafico.withOpacity(0.2),
                    ),
                    dotData: FlDotData(show: true),
                  ),
                ],
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.black.withOpacity(0.7),
                    tooltipRoundedRadius: 10,
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> buscarDadosApi() async {
    try {
      final response = await http.get(
        Uri.parse('https://apiintegradoresp-production.up.railway.app/dados'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> dados = json.decode(response.body);

        if (dados.isNotEmpty) {
          final ultimo = dados.last;
          setState(() {
            temperatura =
                double.tryParse(ultimo['temperatura'].toString()) ??
                temperatura;
            umidade =
                double.tryParse(ultimo['umidadeSolo'].toString()) ?? umidade;
          });
        }
      } else {
        debugPrint('Erro na API: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Erro ao buscar dados: $e');
    }
  }

  void atualizarDados() {
    buscarDadosApi(); // temperatura e umidade reais

    // sensores simulados
    setState(() {
      luminosidade = 680 + (DateTime.now().second % 40);
      ph = 6.0 + ((DateTime.now().second % 10) / 10);
      qualidadeAr = 50.0 + (DateTime.now().second % 10);
    });
  }

  @override
  void initState() {
    super.initState();
    buscarDadosApi(); // carregar dados na abertura
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
              'Monitoramento dos Sensores',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildSensorExpansionTile(
              icon: Icons.thermostat,
              title: 'Temperatura',
              value: '${temperatura.toStringAsFixed(1)} °C',
              color: Colors.red,
              detalhes: [
                'Nível adequado: 22°C a 30°C',
                'Localização: Estufa Principal',
                _buildStatusText(true),
                'Última leitura: Agora',
                'Última calibração: 2 dias atrás',
                'Estado: Bom',
              ],
              dadosGrafico: [
                FlSpot(0, 26),
                FlSpot(1, 27),
                FlSpot(2, 28),
                FlSpot(3, 29),
                FlSpot(4, 27),
                FlSpot(5, 28),
                FlSpot(6, temperatura),
              ],
              corGrafico: Colors.red,
            ),
            _buildSensorExpansionTile(
              icon: Icons.water_drop,
              title: 'Umidade do Solo',
              value: '${umidade.toStringAsFixed(1)} %',
              color: Colors.blue,
              detalhes: [
                'Nível adequado: 40% a 60%',
                'Localização: Horta externa',
                _buildStatusText(true),
                'Última leitura: Agora',
                'Última calibração: 3 dias atrás',
                'Estado: Bom',
              ],
              dadosGrafico: [
                FlSpot(0, 38),
                FlSpot(1, 40),
                FlSpot(2, 42),
                FlSpot(3, 41),
                FlSpot(4, 43),
                FlSpot(5, 42),
                FlSpot(6, umidade),
              ],
              corGrafico: Colors.blue,
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
              dadosGrafico: [
                FlSpot(0, 670),
                FlSpot(1, 680),
                FlSpot(2, 690),
                FlSpot(3, 700),
                FlSpot(4, 710),
                FlSpot(5, 700),
                FlSpot(6, luminosidade),
              ],
              corGrafico: Colors.amber,
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
              dadosGrafico: [
                FlSpot(0, 6.0),
                FlSpot(1, 6.1),
                FlSpot(2, 6.2),
                FlSpot(3, 6.3),
                FlSpot(4, 6.4),
                FlSpot(5, 6.3),
                FlSpot(6, ph),
              ],
              corGrafico: Colors.purple,
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
              dadosGrafico: [
                FlSpot(0, 50),
                FlSpot(1, 52),
                FlSpot(2, 54),
                FlSpot(3, 56),
                FlSpot(4, 55),
                FlSpot(5, 54),
                FlSpot(6, qualidadeAr),
              ],
              corGrafico: Colors.green,
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: atualizarDados,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text('Atualizar Dados'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
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
    required List<FlSpot> dadosGrafico,
    required Color corGrafico,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          ...detalhes.map((texto) {
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
                    color:
                        isStatusLine
                            ? (isAtivo ? Colors.green : Colors.red)
                            : Colors.black87,
                    fontWeight:
                        isStatusLine ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Histórico (útimos 7 dias)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: corGrafico,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY:
                    dadosGrafico
                        .map((e) => e.y)
                        .reduce((a, b) => a > b ? a : b) *
                    1.3,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, _) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      getTitlesWidget: (value, _) {
                        const labels = [
                          '6d',
                          '5d',
                          '4d',
                          '3d',
                          '2d',
                          '1d',
                          'Hoje',
                        ];
                        return Text(
                          labels[value.toInt()],
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black26),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: dadosGrafico,
                    isCurved: true,
                    color: corGrafico,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                      show: true,
                      color: corGrafico.withOpacity(0.2),
                    ),
                    dotData: FlDotData(show: true),
                  ),
                ],
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.black.withOpacity(0.7),
                    tooltipRoundedRadius: 10,
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
 */