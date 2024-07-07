import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test4444/page/photo_page.dart';
import 'package:test4444/page/play_page.dart';

import 'chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/brakground.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text("智能互动机",
                    style: TextStyle(fontSize: 30, color: Colors.black)),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatPage()),
                      );
                    },
                    child: Container(
                      width: 350,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20), // 设置圆角
                      ),
                      margin: EdgeInsets.all(16),
                      // 设置边距
                      padding: EdgeInsets.all(16),
                      // 设置内边距
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 10),
                            child: SvgPicture.asset(
                              'assets/svg/chat.svg',
                              width: 140,
                              height: 140,
                            ),
                          ),
                          Text(
                            "聊天",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Color(0xfff27777),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PhotoPage()),
                      );
                    },
                    child: Container(
                        width: 350,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20), // 设置圆角
                        ),
                        margin: EdgeInsets.all(16),
                        // 设置边距
                        padding: EdgeInsets.all(16),
                        // 设置内边距
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 20),
                              child: SvgPicture.asset(
                                'assets/svg/photo.svg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "拍照",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xfff27777)),
                            )
                          ],
                        )),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlayPage()),
                      );
                    },
                    child: Container(
                        width: 350,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20), // 设置圆角
                        ),
                        margin: EdgeInsets.all(16),
                        // 设置边距
                        padding: EdgeInsets.all(16),
                        // 设置内边距
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 20),
                              child: SvgPicture.asset(
                                'assets/svg/xin.svg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "娱乐",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xfff27777)),
                            )
                          ],
                        )),
                  ),
                  Container(
                      width: 350,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20), // 设置圆角
                      ),
                      margin: EdgeInsets.all(16),
                      // 设置边距
                      padding: EdgeInsets.all(16),
                      // 设置内边距
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 20),
                            child: SvgPicture.asset(
                              'assets/svg/images.svg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "相册",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xfff27777)),
                          )
                        ],
                      )),
                ]),
              ],
            )));
  }
}
