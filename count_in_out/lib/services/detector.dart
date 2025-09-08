import 'dart:ui' show Size;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

/// Wraps detected objects
class ObjectDetectionResult {
  final List<DetectedObject> detections;
  ObjectDetectionResult(this.detections);
}

/// Stable ML Kit Object Detector
class DetectorService {
  late final ObjectDetector _detector;

  DetectorService() {
    _detector = ObjectDetector(
      modelPath: '', // empty = default on-device model
      options: LocalObjectDetectorOptions(
        mode: DetectionMode.stream,
        classifyObjects: true,     // enable classification (person, etc.)
        multipleObjects: true,
        enabl// detect multiple people
        enableClassification: true, modelPath: '',
      ),
    );
  }

  /// Processes a single camera image and returns detected objects
  Future<ObjectDetectionResult> processCameraImage(
      CameraImage image, int sensorRotation) async {
    try {
      // Convert camera planes to bytes
      final WriteBuffer allBytes = WriteBuffer();
      for (final plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final imageSize = Size(image.width.toDouble(), image.height.toDouble());

      final imageRotation =
          InputImageRotationValue.fromRawValue(sensorRotation) ??
              InputImageRotation.rotation0deg;

      final inputImageFormat =
          InputImageFormatValue.fromRawValue(image.format.raw) ??
              InputImageFormat.nv21;

      final inputImageData = InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        bytesPerRow: image.planes[0].bytesPerRow,
      );

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: inputImageData,
      );

      final objects = await _detector.processImage(inputImage);

      // Debug: print detected labels
      for (var obj in objects) {
        for (var label in obj.labels) {
          print('Detected label: ${label.text} (${label.confidence?.toStringAsFixed(2)})');
        }
      }

      return ObjectDetectionResult(objects);
    } catch (e) {
      print('DetectorService error: $e');
      return ObjectDetectionResult([]);
    }
  }

  /// Close detector to free resources
  void dispose() {
    try {
      _detector.close();
    } catch (e) {
      print('Error disposing detector: $e');
    }
  }
}
