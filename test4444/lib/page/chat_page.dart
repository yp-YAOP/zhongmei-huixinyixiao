import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage(String text) async {
    setState(() {
      messages.add(Message(content: text, isMe: true));
    });
    _controller.clear();

    // 等待渲染完成后滚动到底部
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    try {
      print("Sending message to server: $text");

      var response = await http.post(
        Uri.parse('http://192.168.1.194:8000/api/chat/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": text}),
      );

      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Response data: $responseData");
        setState(() {
          messages.add(Message(content: responseData['response'], isMe: false));
        });

        // 等待渲染完成后滚动到底部
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      } else {
        print("Error: Unable to process text. Server responded with status code ${response.statusCode}");
        setState(() {
          messages.add(Message(content: "Error: Unable to process text", isMe: false));
        });

        // 等待渲染完成后滚动到底部
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      }
    } catch (e) {
      print("Exception caught: $e");
      setState(() {
        messages.add(Message(content: "Error: Unable to process text", isMe: false));
      });

      // 等待渲染完成后滚动到底部
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('慧心一孝'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_alert_rounded),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "输入消息...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String content;
  final bool isMe;

  Message({required this.content, required this.isMe});
}

class ChatBubble extends StatelessWidget {
  final Message message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!message.isMe)
            CircleAvatar(
              child: Text("AI"),
            ),
          SizedBox(width: 10,),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: message.isMe ? Colors.green[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                message.content,
                softWrap: true,
              ),
            ),
          ),
          SizedBox(width: 10,),
          if (message.isMe)
            CircleAvatar(
              child: Text("我"),
            ),
        ],
      ),
    );
  }
}
