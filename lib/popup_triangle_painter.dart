import 'package:flutter/material.dart';

/// 绘制三角形
class PopTrianglePainter extends CustomPainter {
  /// 填充颜色
  Color color;

  /// 是否显示阴影
  final bool isShadow;

  PopTrianglePainter({
    this.color = const Color.fromRGBO(75, 75, 75, 1.0),
    this.isShadow = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 1.0 //线宽
      ..color = color;

    Path _path = Path();

    final baseX = size.width * 0.5;
    final baseY = size.height * 0.5;
    //起点
    _path.moveTo(0, baseY * 2);
    _path.lineTo(baseX, 0.4 * baseY);
    _path.lineTo(baseX * 2, baseY * 2);
    canvas.drawPath(_path, _paint);
    if (isShadow == true) {
      canvas.drawShadow(_path, Colors.black, 0.5, false);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
