import 'package:flutter/material.dart';
import 'package:popup_widget/src/popup_triangle_painter.dart';

/// 气泡UI
class PopupTip extends StatelessWidget {
  final Offset positionXy;
  final String text;
  final Color textColor;
  final Color bgColor;
  final bool isShadow;
  final Color shadowColor;

  PopupTip({
    this.positionXy = Offset.zero,
    this.text = "",
    this.textColor = Colors.white,
    this.bgColor = const Color.fromRGBO(75, 75, 75, 1.0),
    this.isShadow = false,
    this.shadowColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    Size sz = _getTextSize(text, TextStyle(fontSize: 13));
    double textWidth = sz.width;

    // double ww = 20;
    // double left = ww; // 左右默认间距
    // double right = ww;
    // print("$textWidth-${positionXy.dx}-$screenW");
    // if (positionXy.dx + textWidth >= screenW) {
    //   left = screenW - right - textWidth - 40; // 40是文字与容器的左右距离和
    //   print("$left");
    // } else {
    //   right = screenW - left - textWidth - 40;
    // }

    double padding = 20;
    double minX = positionXy.dx - textWidth / 2 - padding;
    double maxX = positionXy.dx + textWidth / 2 + padding;
    double left = minX;
    double right = screenW - maxX;
    if (right < padding) {
      right = padding;
      left = screenW - right - textWidth - padding * 2;
      if (left < padding) {
        left = padding;
      }
    }
    if (left < padding) {
      left = padding;
      right = screenW - left - textWidth - padding * 2;
    }

    double triangleW = padding;
    double triangleL = positionXy.dx - triangleW / 2;
    if (triangleL < triangleW + 10) {
      // print("===L$triangleL");
      triangleL = triangleW + 10;
    }

    return new Material(
      type: MaterialType.transparency, // Material类型设置
      child: new GestureDetector(
        child: new Stack(
          children: <Widget>[
            Container(
              // 设置一个容器组件，是整屏幕的。
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Positioned(
              top: positionXy.dy + 15 - triangleW,
              left: triangleL,
              width: triangleW,
              height: triangleW,
              child: CustomPaint(
                painter: PopTrianglePainter(color: bgColor, isShadow: isShadow),
              ),
            ),
            Positioned(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: padding, vertical: 10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    if (isShadow)
                      BoxShadow(
                          offset: Offset(.5, 3),
                          color: shadowColor,
                          blurRadius: 3)
                  ],
                ),
                child: Text(text,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor, fontSize: 13)),
              ),
              top: positionXy.dy + 15,
              left: left,
              right: right,
            )
          ],
        ),
        onTap: () => Navigator.of(context).pop(), //点击空白处直接返回
      ),
    );
  }

  // 获取字体Size
  Size _getTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
