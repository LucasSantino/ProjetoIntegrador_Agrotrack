import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CadastroCultivo extends StatefulWidget {
  const CadastroCultivo({super.key});

  @override
  State<CadastroCultivo> createState() => _CadastroCultivoState();
}

class _CadastroCultivoState extends State<CadastroCultivo> {
  final _formKey = GlobalKey<FormState>();
  File? _imagemSelecionada;

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataController = TextEditingController();
  final TextEditingController cicloController = TextEditingController();
  final TextEditingController espacamentoController = TextEditingController();
  final TextEditingController colheitaController = TextEditingController();
  final TextEditingController soloController = TextEditingController();

  Future<void> _selecionarImagem() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagem = await picker.pickImage(source: ImageSource.gallery);

    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
      });
    }
  }

  static const Color primaryColor = Color.fromRGBO(0, 150, 136, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Cadastrar Plantação',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: _selecionarImagem,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _imagemSelecionada != null
                        ? FileImage(_imagemSelecionada!)
                        : null,
                    child: _imagemSelecionada == null
                        ? const Icon(Icons.add_a_photo,
                            size: 30, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                  controller: nomeController,
                  label: 'Nome da cultura',
                  icon: Icons.grass),
              _buildTextField(
                  controller: dataController,
                  label: 'Data de plantio',
                  icon: Icons.date_range),
              _buildTextField(
                  controller: cicloController,
                  label: 'Ciclo (dias)',
                  icon: Icons.timelapse),
              _buildTextField(
                  controller: espacamentoController,
                  label: 'Espaçamento',
                  icon: Icons.crop),
              _buildTextField(
                  controller: colheitaController,
                  label: 'Colheita prevista',
                  icon: Icons.event),
              _buildTextField(
                  controller: soloController,
                  label: 'Tipo de solo',
                  icon: Icons.terrain),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Cultura cadastrada com sucesso!')),
                      );
                    }
                  },
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha este campo';
          }
          return null;
        },
      ),
    );
  }
}
