import 'package:flutter/material.dart';

class Messsagebailleur1 extends StatefulWidget {
  const Messsagebailleur1({super.key});

  @override
  State<Messsagebailleur1> createState() => _Messsagebailleur1State();
}

class _Messsagebailleur1State extends State<Messsagebailleur1> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String messageText) {
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add({'text': messageText, 'isMe': true});
        messages.add({'text': "Merci pour votre message !", 'isMe': false});
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messagerie Bailleur"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return MessageBubble(
                    text: message['text'],
                    isMe: message['isMe'],
                  );
                },
                shrinkWrap: true, // Ajouté pour éviter les débordements
                physics: NeverScrollableScrollPhysics(), // Désactiver le défilement de ListView
              ),
            ),
          ),
          MessageInputField(
            controller: _controller,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const MessageBubble({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7), // Limiter la largeur
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blueAccent : Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const MessageInputField({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Écrire un message...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10), // Ajuster le remplissage
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => onSend(controller.text),
          ),
        ],
      ),
    );
  }
}
