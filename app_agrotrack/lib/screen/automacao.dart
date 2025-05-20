import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Automacao extends StatefulWidget {
  @override
  _AutomacaoState createState() => _AutomacaoState();
}

class _AutomacaoState extends State<Automacao> {
  bool bombaLigada = true;

  // Histórico de ações automáticas (exemplo)
  List<String> historicoAcao = [
    "Bomba acionada automaticamente às 06:00 - Umidade: 28%",
    "Bomba desligada automaticamente às 07:00 - Umidade: 32%",
  ];

  // Agendamento manual (exemplo)
  String horarioAgendamento = "Irrigação agendada para: 06:00";
  String url = "apiprojetointegrador-production-99a0.up.railway.app/bomba";

  // Simulação do estado dos sensores
  final Map<String, bool> sensoresAtivos = {
    'Temperatura': true,
    'Umidade do Solo': true,
    'Luminosidade': true,
    'pH': true,
    'Qualidade do Ar': true,
  };

  void _toggleBomba() async{
    setState(() {
      bombaLigada = !bombaLigada;
       final response = await http.post(
        Uri.parse('https://apiintegradoresp-production.up.railway.app/bomba'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'estado': bombaLigada}),
        
      );
    });
    print("Bomba ${bombaLigada}");
  }

  Widget _buildAtuadorCard({
    required IconData icon,
    required String titulo,
    required bool ativo,
    required VoidCallback onPressed,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(titulo, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          ativo ? 'Status: Ativado' : 'Status: Desativado',
          style: TextStyle(color: ativo ? Colors.green : Colors.red),
        ),
        trailing: Switch(
          value: ativo,
          onChanged: (_) => onPressed(),
        ),
      ),
    );
  }

  Widget _buildSensorStatusCard() {
    bool todosAtivos = sensoresAtivos.values.every((ativo) => ativo);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.sensors, color: Colors.teal),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var entry in sensoresAtivos.entries)
              Text(
                '${entry.key}: ${entry.value ? "Ativo" : "Desativado"}',
                style:
                    TextStyle(color: entry.value ? Colors.green : Colors.red),
              ),
            const SizedBox(height: 6),
            Text(
              todosAtivos
                  ? "Todos os sensores estão ativos"
                  : "Alguns sensores estão desativados",
              style: TextStyle(fontWeight: FontWeight.bold),
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
              Text(
                acao,
                style: TextStyle(fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgendamentoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.schedule, color: Colors.teal),
        subtitle: Text(horarioAgendamento),
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
              const SizedBox(height: 24), // espaçamento entre o título e o card

              _buildAtuadorCard(
                icon: Icons.water,
                titulo: 'Bomba de Irrigação (Principal)',
                ativo: bombaLigada,
                onPressed: _toggleBomba,
              ),
              const SizedBox(height: 24), // espaçamento entre o título e o card
              Text(
                'Sensores Conectados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildSensorStatusCard(),
              const SizedBox(height: 24), // espaçamento entre o título e o card
              Text(
                'Regras de Irrigação',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildRegrasCard(),
              const SizedBox(height: 24), // espaçamento entre o título e o card
              Text(
                'Histórico de Ações Automáticas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildHistoricoCard(),
              const SizedBox(height: 24), // espaçamento entre o título e o card
              Text(
                'Agendamento de Irrigação',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildAgendamentoCard(),
            ],
          ),
        ),
      ),
    );
  }
}
