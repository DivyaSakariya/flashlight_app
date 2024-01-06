import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<CameraDescription> cameras;
  late CameraController _controller;

  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.low);
    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool onClick = false;

  Future<void> toggleFlashlight() async {
    if (_controller.value.isInitialized) {
      if (_controller.value.flashMode == FlashMode.off) {
        onClick = true;
        await _controller.setFlashMode(FlashMode.torch);
      } else {
        onClick = false;
        await _controller.setFlashMode(FlashMode.off);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlashLight"),
      ),
      body: Center(
        child: IconButton(
          icon: onClick == true
              ? const Icon(Icons.flashlight_on_rounded)
              : const Icon(Icons.flashlight_off_rounded),
          onPressed: toggleFlashlight,
        ),
      ),
    );
  }
}
