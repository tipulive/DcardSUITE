import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'services/detector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(cameras: cameras),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const HomePage({super.key, required this.cameras});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraController? _controller;
  DetectorService? _detector;
  Size? _cameraPreviewSize;
  int _inCount = 0;
  int _outCount = 0;

  bool _isProcessing = false;
  int _frameCounter = 0;

  Map<int, double> _objectLastY = {};

  @override
  void initState() {
    super.initState();
    _detector = DetectorService();
    _initCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _detector?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    final cam = widget.cameras.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => widget.cameras.first,
    );

    _controller = CameraController(
      cam,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    try {
      if (await Permission.camera.isGranted) {
        await _startCameraStream();
      } else {
        final status = await Permission.camera.request();
        if (status.isGranted) await _startCameraStream();
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<void> _startCameraStream() async {
    if (_controller == null) return;

    try {
      await _controller!.initialize();

      setState(() {
        _cameraPreviewSize = _controller!.value.previewSize != null
            ? Size(
          _controller!.value.previewSize!.height,
          _controller!.value.previewSize!.width,
        )
            : null;
      });

      await _controller!.startImageStream(_safeProcessCameraImage);
    } catch (e) {
      debugPrint('Camera stream error: $e');
    }
  }

  // Throttled and safe processing
  void _safeProcessCameraImage(CameraImage image) async {
    if (_isProcessing) return; // skip if busy
    _frameCounter++;
    if (_frameCounter % 3 != 0) return; // process 1 out of 3 frames

    _isProcessing = true;

    try {
      final result = await _detector!.processCameraImage(
        image,
        _controller!.description.sensorOrientation,
      );

      _updateCounters(result);
    } catch (e) {
      debugPrint('ML Kit processing error: $e');
    } finally {
      _isProcessing = false;
    }
  }

  // Update IN/OUT counters using persistent tracking IDs
  void _updateCounters(ObjectDetectionResult result) {
    final irLineY = _cameraPreviewSize!.height / 2;
    Map<int, double> currentFrameObjects = {};

    for (var obj in result.detections) {
      if (obj.trackingId == null) continue;
      final objId = obj.trackingId!;
      final centerY = (obj.boundingBox.top + obj.boundingBox.bottom) / 2;

      double? lastY = _objectLastY[objId];
      if (lastY != null) {
        if (lastY < irLineY && centerY >= irLineY) _inCount++;
        if (lastY > irLineY && centerY <= irLineY) _outCount++;
      }

      currentFrameObjects[objId] = centerY;
    }

    _objectLastY = currentFrameObjects;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Person Counter')),
      body: Stack(
        children: [
          if (_controller != null && _controller!.value.isInitialized)
            CameraPreview(_controller!),
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('IN: $_inCount',
                    style: const TextStyle(color: Colors.green, fontSize: 24)),
                Text('OUT: $_outCount',
                    style: const TextStyle(color: Colors.red, fontSize: 24)),
              ],
            ),
          ),
          Positioned(
            top: _cameraPreviewSize != null
                ? _cameraPreviewSize!.height / 2
                : 200,
            left: 0,
            right: 0,
            child: Container(height: 2, color: Colors.yellow),
          ),
        ],
      ),
    );
  }
}
