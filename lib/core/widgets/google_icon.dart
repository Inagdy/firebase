import 'package:flutter/material.dart';

class GoogleIcon extends StatelessWidget {
  final double size;

  const GoogleIcon({super.key, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint bluePaint = Paint()..color = const Color(0xFF4285F4);
    final Paint redPaint = Paint()..color = const Color(0xFFEA4335);
    final Paint yellowPaint = Paint()..color = const Color(0xFFFBBC05);
    final Paint greenPaint = Paint()..color = const Color(0xFF34A853);

    final Rect rect = Rect.fromLTWH(0, 0, w, h);

    // Blue horizontal bar & right arc
    final Path bluePath = Path()
      ..moveTo(w * 0.5, h * 0.5)
      ..lineTo(w, h * 0.5)
      ..arcTo(rect, 0, -0.785, false)
      ..close();
    canvas.drawPath(bluePath, bluePaint);

    // Green bottom arc
    final Path greenPath = Path()
      ..arcTo(rect, 0.26, 1.3, false)
      ..lineTo(w * 0.5, h * 0.5)
      ..close();
    canvas.drawPath(greenPath, greenPaint);

    // Yellow left arc
    final Path yellowPath = Path()
      ..arcTo(rect, 1.57, 1.3, false)
      ..lineTo(w * 0.5, h * 0.5)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);

    // Red top arc
    final Path redPath = Path()
      ..arcTo(rect, 2.87, 1.3, false)
      ..lineTo(w * 0.5, h * 0.5)
      ..close();
    canvas.drawPath(redPath, redPaint);

    // Inner white cutout circle for G shape
    final Paint whitePaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.3, whitePaint);

    // Re-draw Blue bar extending to center
    final Rect barRect = Rect.fromLTWH(w * 0.45, h * 0.4, w * 0.55, h * 0.2);
    canvas.drawRect(barRect, bluePaint);

    // Cutout right-upper quadrant of inner circle to open the G
    final Path cutout = Path()
      ..moveTo(w * 0.5, h * 0.5)
      ..lineTo(w * 0.5, h * 0.4)
      ..lineTo(w, h * 0.4)
      ..lineTo(w * 0.5, h * 0.5)
      ..close();
    canvas.drawPath(cutout, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
