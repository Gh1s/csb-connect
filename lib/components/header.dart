import 'package:flutter/cupertino.dart';
import 'package:merchant_mobile_app/theme/style.dart';
import 'package:flutter/material.dart';


class HeaderComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: ComponentConstants.headerPaddingVertical,
            horizontal: constraints.maxWidth * 0.25
          ),
          child: Image.asset(
            "assets/images/logo_csb.jpg",
            bundle: DefaultAssetBundle.of(context),
          ),
        );
      },
    );
  }
}

class _DashboardTile extends StatelessWidget {
  _DashboardTile({this.color, this.size, this.icon, this.text, this.onPressed});

  final Color color;
  final Size size;
  final Widget icon;
  final Widget text;
  final Function onPressed;

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
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )
          ),
        ),
        child: Column(children: [icon, text]),
        onPressed: onPressed,
      ),
    );
  }
}
