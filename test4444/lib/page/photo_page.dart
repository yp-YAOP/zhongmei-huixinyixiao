import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;
  bool isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    // 初始化摄像头控制器
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    firstCamera = isFrontCamera ? cameras.last : cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  void toggleCamera() async {
    if (_controller != null) {
      await _controller.dispose();
    }
    setState(() {
      isFrontCamera = !isFrontCamera;
    });
    await initializeCamera();
  }


  @override
  void dispose() {
    // 释放摄像头控制器
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('智能抓拍'),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: CameraPreview(_controller),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await _initializeControllerFuture;
                              final image = await _controller.takePicture();
                              if (!mounted) return;
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DisplayPictureScreen(
                                    imagePath: image.path,
                                  ),
                                ),
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                          icon: Icon(Icons.camera),
                          label: Text('拍照'),
                        ),
                        ElevatedButton.icon(
                          onPressed: toggleCamera,
                          icon: Icon(Icons.switch_camera),
                          label: Text('切换摄像头'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('拍摄的照片')),
      body: Image.file(File(imagePath)),
    );
  }
}
