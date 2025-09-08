import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';


class CameraOverlay extends StatelessWidget {
  final Size previewSize;
  final List<DetectedObject> detections;
  final double lineYRatio;


  const CameraOverlay({super.key, required this.previewSize, required this.detections, required this.lineYRatio});


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scaleX = constraints.maxWidth / previewSize.width;
        final scaleY = constraints.maxHeight / previewSize.height;
        return CustomPaint(
          painter: _OverlayPainter(detections: detections, scaleX: scaleX, scaleY: scaleY, lineY: constraints.maxHeight * lineYRatio),
        );
      },
    );
  }
}


class _OverlayPainter extends CustomPainter {
  final List<DetectedObject> detections;
  final double scaleX, scaleY, lineY;


  _OverlayPainter({required this.detections, required this.scaleX, required this.scaleY, required this.lineY});


  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..color = Colors.amber..strokeWidth = 3..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, lineY), Offset(size.width, lineY), linePaint);


    final boxPaint = Paint()..color = Colors.greenAccent..strokeWidth = 2..style = PaintingStyle.stroke;
    final textPainter = (String text, Offset at) {
      final tp = TextPainter(text: TextSpan(style: const TextStyle(color: Colors.white, fontSize: 12), text: text), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, at);
    };


    for (final d in detections) {
      final rect = Rect.fromLTWH(d.boundingBox.left * scaleX, d.boundingBox.top * scaleY, d.boundingBox.width * scaleX, d.boundingBox.height * scaleY);
      canvas.drawRect(rect, boxPaint);
      final label = d.labels.isNotEmpty ? d.labels.first.text : 'ID ${d.trackingId ?? '-'}';
      textPainter(label, rect.topLeft + const Offset(4, -2));
    }
  }


  @override
  bool shouldRepaint(covariant _OverlayPainter oldDelegate) {
    return oldDelegate.detections != detections || oldDelegate.lineY != lineY;
  }
}