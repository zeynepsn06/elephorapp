import 'package:flutter/material.dart';

class ElephantLogo extends StatelessWidget {
  final double size;
  final Color color;

  const ElephantLogo({super.key, this.size = 32, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ElephantPainter(color: color),
    );
  }
}

class _ElephantPainter extends CustomPainter {
  final Color color;

  _ElephantPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // We use a saveLayer so we can use BlendMode.clear to "cut" the lines out of the shape,
    // making them truly transparent negative space.
    canvas.saveLayer(Rect.fromLTWH(0, 0, w, h), Paint());

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw the main silhouette of the origami elephant
    final path = Path();
    // Forehead top
    path.moveTo(w * 0.35, h * 0.15);
    // Back top
    path.lineTo(w * 0.60, h * 0.18);
    // Rump curve
    path.lineTo(w * 0.85, h * 0.40);
    // Back leg (back edge)
    path.lineTo(w * 0.82, h * 0.80);
    // Back leg (bottom)
    path.lineTo(w * 0.68, h * 0.80);
    // Back leg (front edge)
    path.lineTo(w * 0.65, h * 0.65);
    // Belly
    path.lineTo(w * 0.60, h * 0.60);
    // Front leg (back edge)
    path.lineTo(w * 0.52, h * 0.82);
    // Front leg (bottom)
    path.lineTo(w * 0.38, h * 0.82);
    // Front leg (front edge)
    path.lineTo(w * 0.42, h * 0.60);
    // Chest
    path.lineTo(w * 0.38, h * 0.55);
    // Trunk curve down
    path.lineTo(w * 0.32, h * 0.70);
    // Trunk tip
    path.lineTo(w * 0.22, h * 0.65);
    // Trunk inner curve
    path.lineTo(w * 0.28, h * 0.55);
    // Tusk bottom
    path.lineTo(w * 0.15, h * 0.52);
    // Tusk top / face
    path.lineTo(w * 0.30, h * 0.42);
    // Bridge of nose
    path.lineTo(w * 0.30, h * 0.30);
    path.close();

    canvas.drawPath(path, paint);

    // Now draw the negative space (the geometric cuts)
    final cutPaint = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.04
      ..strokeCap = StrokeCap.square;

    final cuts = Path();
    
    // The X shape cuts
    // Cut 1: Top of head down to belly
    cuts.moveTo(w * 0.48, h * 0.15);
    cuts.lineTo(w * 0.55, h * 0.60);

    // Cut 2: Tusk base crossing the ear
    cuts.moveTo(w * 0.28, h * 0.45);
    cuts.lineTo(w * 0.60, h * 0.35);

    // Eye (a small slanted cut)
    cuts.moveTo(w * 0.35, h * 0.32);
    cuts.lineTo(w * 0.40, h * 0.34);

    canvas.drawPath(cuts, cutPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
