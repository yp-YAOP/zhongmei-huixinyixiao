import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'jiangli_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int currentIndex = 0;
  List<bool> progress = List.generate(10, (index) => false);
  bool hasSelectedImage = false;
  bool canProceed = false;
  List<String> labels = ["狗", "兔子", "西瓜", "乌龟"];
  List<Color> containerColors = List.generate(4, (index) => Colors.white);

  final List<List<String>> fruitGroups = [
    ['assets/svg/boluo.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg'],
    ['assets/svg/chat.svg', 'assets/svg/xin.svg', 'assets/svg/play.svg', 'assets/svg/xin.svg'],
    ['assets/svg/chat.svg', 'assets/svg/photo.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg'],
    ['assets/svg/chat.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg'],
    ['assets/svg/chat.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg'],
    ['assets/svg/chat.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg'],
    ['assets/svg/chat.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg'],
    ['assets/svg/chat.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg'],
    ['assets/svg/chat.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg'],
    ['assets/svg/chat.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg', 'assets/svg/xin.svg'],
  ];

  final List<int> correctAnswers = [3, 3, 0, 1, 2, 3, 0,1,1,2];

  FlutterTts flutterTts = FlutterTts();

  // 示例方法，使用flutter_tts播放文字
  Future<void> playTextVoice(String text) async {
    await flutterTts.setLanguage('zh-CN');
    // await flutterTts.speak(text);
  }

  void checkAnswer(int index) {
    setState(() {
      hasSelectedImage = true;
      if (index == correctAnswers[currentIndex]) {
        progress[currentIndex] = true;
        containerColors[index] = Colors.green;
      } else {
        containerColors[index] = Colors.red;
      }
      canProceed = true;
    });
  }

  void proceedToNext() {
    setState(() {
      if (currentIndex < 9) {
        currentIndex++;
        hasSelectedImage = false;
        canProceed = false;
        containerColors = List.generate(4, (index) => Colors.white);
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('恭喜!'),
            content: Text('你完成了所有题目！'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentIndex = 0;
                    progress = List.generate(10, (index) => false);
                    hasSelectedImage = false;
                    canProceed = false;
                    containerColors = List.generate(4, (index) => Colors.white);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JiangliPage()), // 跳转到JiangliPage页面
                  );
                },
                child: Text('领取奖励'),
              ),
            ],
          ),
        );
      }
    });
  }

  String getCurrentLabel() {
    return labels[currentIndex % labels.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/brakground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
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
                        '游戏',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
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
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "选择对应的图片",
                                    style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 600),
                                  GestureDetector(
                                    onTap: () {
                                      flutterTts.speak(getCurrentLabel()); // 播放当前标签文字的语音
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 0, top: 0),
                                        child: SvgPicture.asset(
                                          'assets/svg/sy.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    getCurrentLabel(),
                                    style: TextStyle(color: Colors.black, fontSize: 25),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 120),
                                      Column(
                                        children: [
                                          for (int i = 0; i < 2; i++)
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                for (int j = 0; j < 2; j++)
                                                  GestureDetector(
                                                    onTap: () {
                                                      checkAnswer(i * 2 + j);
                                                    },
                                                    child: Container(
                                                      width: 280,
                                                      height: 160,
                                                      decoration: BoxDecoration(
                                                        color: containerColors[i * 2 + j],
                                                        borderRadius: BorderRadius.circular(20),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.5),
                                                            spreadRadius: 3,
                                                            blurRadius: 7,
                                                            offset: Offset(0, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      margin: EdgeInsets.all(16),
                                                      padding: EdgeInsets.all(16),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 12, top: 10),
                                                            child: SvgPicture.asset(
                                                              fruitGroups[currentIndex][i * 2 + j],
                                                              width: 100,
                                                              height: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      SizedBox(width: 120),
                                      Column(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: List.generate(10, (index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                child: Icon(
                                                  Icons.circle,
                                                  size: 16.0,
                                                  color: index <= currentIndex ? Colors.green : Colors.grey,
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: canProceed
                                        ? () {
                                      proceedToNext();
                                    }
                                        : null,
                                    child: Container(
                                      width: 450,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: canProceed ? Colors.green : Color(0xffe0dcdc),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      margin: EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 6),
                                          Text(
                                            "继续",
                                            style: TextStyle(color: canProceed ? Colors.white : Color(0xffa3a3a3), fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
