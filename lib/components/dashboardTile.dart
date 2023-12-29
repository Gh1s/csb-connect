import 'package:flutter/material.dart';
import 'package:merchant_mobile_app/theme/style.dart';


class DashboardTile extends StatelessWidget {
  DashboardTile({this.color, this.size, this.icon, this.text, this.onPressed, this.shape});

  final Color color;
  final Size size;
  final Widget icon;
  final Widget text;
  final Function onPressed;
  final MaterialStateProperty<OutlinedBorder> shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorConstants.shadow,
              blurRadius: ComponentConstants.shadowBlurRadius,
              offset: Offset(ComponentConstants.shadowOffsetX,
                  ComponentConstants.shadowOffsetY),
            )
          ]),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          foregroundColor:
          MaterialStateProperty.all<Color>(ColorConstants.white),
          minimumSize: MaterialStateProperty.all<Size>(size),
          shape: shape,
        ),
        child: Column(children: [icon, text]),
        onPressed: onPressed,
      ),
    );
  }
}

