import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {'text': 'Tipos de solos agrícolas', 'isMe': true, 'time': '5:20 PM'},
    {'text': 'Calcário, Argiloso', 'isMe': true, 'time': '5:18 PM'},
    {
      'text': 'Qual a melhor semente para plantar em maio?',
      'isMe': false,
      'time': '5:28 PM',
    },
    {'text': 'Chatbot', 'isMe': false, 'time': '5:30 PM'},
    {'text': 'AgroIoT', 'isMe': false, 'time': '5:38 PM'},
  ];

  // API LANGFLOW
  void _sendMessage() async {
    final userMessage = _controller.text.trim();
    String url =
        "https://rsvictor-chat-bot.hf.space/api/v1/run/c86f7bc8-bbed-48a8-8a74-af9dd2d6f779";

    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'text': userMessage,
        'isMe': true,
        // pega a data e hora da mensagem digitada
        'time': TimeOfDay.now().format(context),
      });
      _controller.clear();
    });
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "input_value": userMessage,
          "output_type": "chat",
          "input_type": "chat",
        }),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        print("Resposta a API: $decoded");
        final botReply =
            decoded["outputs"]?[0]?["outputs"]?[0]?["results"]?["message"]?["text"] ??
            "Não consegui entender";
        setState(() {
          _messages.add({
            'text': botReply,
            'isMe': false,
            'time': TimeOfDay.now().format(context),
          });
        });
      } else {
        setState(() {
          _messages.add({
            'text': 'Erro ao obter resposta do assistente',
            'isMe': false,
            'time': TimeOfDay.now().format(context),
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'text': 'Erro de conexão $e',
          'isMe': false,
          'time': TimeOfDay.now().format(context),
        });
      });
    }
  }

  void _clearMessages() {
    setState(() {
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Permite que o corpo vá atrás da AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logoAgrotrack_sem fundo 2 - Copia.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Agrotrack Chatbot',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return MessageBubble(
                    text: msg['text'],
                    isMe: msg['isMe'],
                    time: msg['time'],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Digite sua mensagem',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                    color: Colors.teal,
                  ),
                  IconButton(
                    onPressed: _clearMessages,
                    icon: const Icon(Icons.clear),
                    color: Colors.teal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;

  const MessageBubble({
    required this.text,
    required this.isMe,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isMe ? Colors.green[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(text),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              time,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {'text': 'Tipos de solos agrícolas', 'isMe': true, 'time': '5:20 PM'},
    {'text': 'Calcário, Argiloso', 'isMe': true, 'time': '5:18 PM'},
    {
      'text': 'Qual a melhor semente para plantar em maio?',
      'isMe': false,
      'time': '5:28 PM',
    },
    {'text': 'Chatbot', 'isMe': false, 'time': '5:30 PM'},
    {'text': 'AgroIoT', 'isMe': false, 'time': '5:38 PM'},
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'text': _controller.text.trim(),
        'isMe': true,
        'time': TimeOfDay.now().format(context),
      });
      _controller.clear(); // Limpa o campo após o envio
    });
  }

  void _clearMessages() {
    setState(() {
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.chat_bubble_outline, color: Colors.teal),
            ),
            SizedBox(width: 10),
            Text(
              'Agrotrack Chatbot',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return MessageBubble(
                  text: msg['text'],
                  isMe: msg['isMe'],
                  time: msg['time'],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 10,
            ), // Aumentei o espaçamento inferior
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Bordas arredondadas
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(
                            0,
                            4,
                          ), // Sombra mais abaixo para dar um toque de profundidade
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Digite sua mensagem',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send),
                  color: Colors.teal,
                ),
                IconButton(
                  onPressed: _clearMessages,
                  icon: Icon(Icons.clear),
                  color: Colors.teal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;

  const MessageBubble({
    required this.text,
    required this.isMe,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isMe ? Colors.green[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(text),
          ),
          Text(time, style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

*/
