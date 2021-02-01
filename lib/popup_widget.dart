library popup_widget;

/*
 * @Author: lin minjing
 * @version: 0.1.0
 * @Date: 2021-02-01 16:30:19
 * @Descripttion: 气泡弹出
 */
import 'package:flutter/material.dart';
import 'package:popup_widget/pop_route.dart';
import 'package:popup_widget/popup_tip.dart';

class PopupWidget extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 文本字符串
  final String text;

  /// 文本颜色
  final Color textColor;

  /// 背景色
  final Color bgColor;

  /// 是否显示阴影
  final bool isShadow;

  /// 阴影颜色
  final Color shadowColor;

  /// child 尺寸帮助精确定位，不传的话，位置会一直变动
  final Offset contentSize;

  PopupWidget({
    this.child,
    @required this.text,
    this.textColor = Colors.white,
    this.bgColor = const Color.fromRGBO(75, 75, 75, 1.0),
    this.isShadow = false,
    this.shadowColor = Colors.grey,
    this.contentSize = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTapDown: (detail) {
        print("${detail.localPosition}-${detail.globalPosition}");

        double xx = detail.globalPosition.dx - detail.localPosition.dx;
        double yy = detail.globalPosition.dy - detail.localPosition.dy;

        // 使用路由跳转方式
        Navigator.push(
          context,
          new PopRoute(
            child: PopupTip(
              positionXy: Offset(xx + contentSize.dx / 2, yy + contentSize.dy),
              text: text,
              textColor: textColor,
              bgColor: bgColor,
              isShadow: true,
              shadowColor: shadowColor,
            ),
          ),
        );
      },
    );
  }
}
