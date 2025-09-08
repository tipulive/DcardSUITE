import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';


class LineCounter {
  double lineYRatio = 0.6;
  final Map<int, double> _lastYById = {};
  final Set<int> _countedThisFrame = {};
  int inCount = 0;
  int outCount = 0;
  List<DetectedObject> lastDetectionsForOverlay = const [];


  void reset() {
    inCount = 0;
    outCount = 0;
    _lastYById.clear();
  }


  void updateFromDetections(List<DetectedObject> detections, double frameW, double frameH) {
    lastDetectionsForOverlay = detections;
    _countedThisFrame.clear();


    final lineY = frameH * lineYRatio;


    for (final d in detections) {
      final id = d.trackingId;
      if (id == null) continue;


      final centerY = d.boundingBox.top + d.boundingBox.height / 2;
      final lastY = _lastYById[id];


// Virtual IR beam check
      final intersectsBeam = d.boundingBox.top <= lineY && d.boundingBox.bottom >= lineY;


      if (lastY != null && !_countedThisFrame.contains(id) && intersectsBeam) {
        if (centerY > lastY) {
          outCount += 1;
        } else {
          inCount += 1;
        }
        _countedThisFrame.add(id);
      }


      _lastYById[id] = centerY;
    }
  }
}