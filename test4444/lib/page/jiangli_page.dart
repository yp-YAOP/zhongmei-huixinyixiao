import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class JiangliPage extends StatefulWidget {
  const JiangliPage({Key? key}) : super(key: key);

  @override
  State<JiangliPage> createState() => _JiangliPageState();
}

class _JiangliPageState extends State<JiangliPage> {
  InAppWebViewController? webView;

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
                        '小剧场',
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
                // 中间白色区域，包含WebView
                Expanded(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0), // 根据需要调整 margin
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InAppWebView(
                        initialUrlRequest: URLRequest(url: Uri.parse('https://tv.cctv.com/live/cctv11/')),
                        onWebViewCreated: (controller) {
                          webView = controller;
                        },
                      ),
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
