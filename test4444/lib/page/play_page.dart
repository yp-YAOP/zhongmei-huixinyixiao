import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chat_page.dart';
import 'draw_page.dart';
import 'game_page.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.home, size: 40,color: Colors.white,),),
                    // 可以更改为你需要的图标
                    SizedBox(width: 80,),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GamePage()),
                      );
                    },
                    child: Container(
                      width: 350,
                      height: 480,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20), // 设置圆角
                      ),
                      margin: EdgeInsets.all(16),
                      // 设置边距
                      padding: EdgeInsets.all(16),
                      // 设置内边距
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 0),
                            child: SvgPicture.asset(
                              'assets/svg/game.svg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "游戏",
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
                        MaterialPageRoute(builder: (context) => DrawPage()),
                      );
                    },
                    child: Container(
                        width: 350,
                        height: 480,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20), // 设置圆角
                        ),
                        margin: EdgeInsets.all(16),
                        // 设置边距
                        padding: EdgeInsets.all(16),
                        // 设置内边距
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 0),
                              child: SvgPicture.asset(
                                'assets/svg/draw.svg',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "智绘",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xfff27777)),
                            )
                          ],
                        )),
                  ),
                ]),
              ],
            )));
  }
}
