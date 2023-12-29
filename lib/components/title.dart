import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/theme/style.dart';

class TitleComponent extends StatelessWidget {
  TitleComponent({@required this.color, @required this.icon, @required this.text});

  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: EdgeInsets.fromLTRB(0, 0, constraints.maxWidth * 0.1, 0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                color: ColorConstants.shadow,
                blurRadius: ComponentConstants.shadowBlurRadius,
                offset: Offset(
                  ComponentConstants.shadowOffsetX,
                  ComponentConstants.shadowOffsetY
                )
              )
            ],
          ),
          height: ComponentConstants.titleHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ComponentConstants.titlePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  icon,
                  color: ColorConstants.white,
                  size: ComponentConstants.titleIconSize
                ),
                SizedBox(width: ComponentConstants.titlePadding),
                Text(
                  text, 
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: ComponentConstants.titleTextSize
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}