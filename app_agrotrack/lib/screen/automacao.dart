import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Automacao extends StatefulWidget {
  const Automacao({super.key});

  @override
  _AutomacaoState createState() => _AutomacaoState();
}

class _AutomacaoState extends State<Automacao> {
  bool bombaLigada = false;
  bool carregando = false;

  List<String> historicoAcao = [
    "Bomba acionada automaticamente às 06:00 - Umidade: 28%",
    "Bomba desligada automaticamente às 07:00 - Umidade: 32%",
  ];

  final Map<String, bool> sensoresAtivos = {
    'Temperatura': true,
    'Umidade do Solo': true,
    'Luminosidade': true,
    'pH': true,
    'Qualidade do Ar': true,
  };

  Future<void> _controlarBomba(bool ligar) async {
    setState(() {
      carregando = true;
    });

    final url = Uri.parse(
      'https://apiintegradoresp-production.up.railway.app/bomba',
    );
    final estado = ligar ? 1 : 0;

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'estado': estado}),
      );

      if (response.statusCode == 200) {
        final agora = DateTime.now();
        final dataFormatada =
            "${agora.day.toString().padLeft(2, '0')}/${agora.month.toString().padLeft(2, '0')}/${agora.year} ${agora.hour.toString().padLeft(2, '0')}:${agora.minute.toString().padLeft(2, '0')}";

        setState(() {
          bombaLigada = ligar;
          historicoAcao.insert(
            0,
            "Bomba ${ligar ? 'ligada' : 'desligada'} manualmente em $dataFormatada",
          );
        });
      } else {
        _mostrarErro(
          "Erro ao alterar estado da bomba. Código: ${response.statusCode}",
        );
      }
    } catch (e) {
      _mostrarErro("Erro de conexão: $e");
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
    );
  }

  Widget _buildSistemaIrrigacaoCard() {
    bool todosAtivos = sensoresAtivos.values.every((ativo) => ativo);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.water, color: Colors.teal),
              title: Text(
                'Bomba de Irrigação (Principal)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                bombaLigada ? 'Status: Ativado' : 'Status: Desativado',
                style: TextStyle(
                  color: bombaLigada ? Colors.green : Colors.red,
                ),
              ),
              trailing:
                  carregando
                      ? CircularProgressIndicator()
                      : Switch(
                        value: bombaLigada,
                        onChanged: (valor) => _controlarBomba(valor),
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.red[200],
                      ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Icon(Icons.sensors, color: Colors.teal),
                  const SizedBox(width: 8),
                  Text(
                    'Sensores Conectados',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            for (var entry in sensoresAtivos.entries)
              Padding(
                padding: const EdgeInsets.only(left: 32, bottom: 2),
                child: Text(
                  '${entry.key}: ${entry.value ? "Ativo" : "Desativado"}',
                  style: TextStyle(
                    color: entry.value ? Colors.green : Colors.red,
                  ),
                ),
              ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(
                todosAtivos
                    ? "Todos os sensores estão ativos"
                    : "Alguns sensores estão desativados",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegrasCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.rule, color: Colors.teal),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("- Umidade do solo < 30% → Ativar bomba"),
            Text("- Temperatura > 35°C → Ativar bomba"),
            Text("- pH da água fora de 6.0–7.5 → Desativar bomba"),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoricoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.history, color: Colors.teal),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var acao in historicoAcao)
              Text(acao, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Monitoramento do Sistema',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildSistemaIrrigacaoCard(),
              const SizedBox(height: 24),
              Text(
                'Regras de Irrigação',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildRegrasCard(),
              const SizedBox(height: 24),
              Text(
                'Histórico de Ações',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildHistoricoCard(),
            ],
          ),
        ),
      ),
    );
  }
}
