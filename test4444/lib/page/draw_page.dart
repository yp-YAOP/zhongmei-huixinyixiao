import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrawPage extends StatefulWidget {
  const DrawPage({super.key});

  @override
  State<DrawPage> createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  String _text = "按下发送并生成图片";
  Uint8List? _imageData;
  final TextEditingController _controller = TextEditingController();

  Future<void> _sendText() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _text = "生成中...";
      });

      try {
        var response = await http.post(
          Uri.parse('http://192.168.1.194:8000/imagegen/generate_image/'), // 替换为你的后端API URL
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'text': _controller.text,
          }),
        );

        if (response.statusCode == 200) {
          setState(() {
            _text = _controller.text;
            _imageData = response.bodyBytes;
          });
        } else {
          setState(() {
            _text = '生成失败，状态码：${response.statusCode}';
          });
          print('生成失败，状态码：${response.statusCode}');
          print('响应内容：${response.body}');
        }
      } catch (e) {
        setState(() {
          _text = '生成失败，错误信息：$e';
        });
        print('生成失败，错误信息：$e');
      }

      // 清空输入框
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景图片
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/brakground.png'), // 替换为你的图片路径
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 导航栏和页面内容
          SafeArea(
            child: Column(
              children: [
                // 顶部导航栏
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        '智绘',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {
                          // 处理点击事件
                        },
                      ),
                    ],
                  ),
                ),
                // 中间白色区域
                Expanded(
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: _imageData == null
                                ? Text(
                              _text,
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            )
                                : Image.memory(_imageData!),
                          ),
                        ),
                        // 底部输入框和发送按钮
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40.0),
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffffbdbd),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _controller,
                                      decoration: InputDecoration(
                                        hintText: '输入文本...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.send, color: Colors.blue),
                                    onPressed: _sendText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




// // 底部麦克风按钮
// Positioned(
// bottom: 50,
// left: 0,
// right: 0,
// child: Center(
// child: Container(
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// boxShadow: [
// BoxShadow(
// color: Color(0xffffbdbd),
// spreadRadius: 5,
// blurRadius: 7,
// ),
// ],
// ),
// child: GestureDetector(
// onLongPress: _startRecording,
// onLongPressUp: _stopRecording,
// child: IconButton(
// icon: Icon(Icons.mic, size: 36),
// onPressed: (){},
// color: Colors.white,
// ),
// ),
// ),
// ),
// ),