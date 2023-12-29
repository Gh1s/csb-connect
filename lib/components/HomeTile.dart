import 'package:flutter/material.dart';
import 'package:merchant_mobile_app/components/dashboardTile.dart';

const double BANNER_PADDING = 15.0;
const double BANNER_HEIGHT = 60.0;
const Size TILE_SIZE = Size(150.0, 150.0);
const double TILE_SPACING = 15.0;
const double TILE_ICON_SIZE = 75.0;
const double FAB_ICON_SIZE = 35.0;
const double TILE_MARGIN = 5.0;


class HomeTile extends StatelessWidget {

  final String inputText;
  final String inputRoute;
  final Widget icon;
  final Color color;
  final MaterialStateProperty<OutlinedBorder> shape;

  const HomeTile(this.inputText, this.inputRoute, this.icon, this.color, this.shape);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: DashboardTile(
          color: color,
          size: TILE_SIZE,
          icon: icon,
          text: Text(
              inputText),
          onPressed: () =>
              Navigator.pushNamed(context, inputRoute),
          shape: shape,
        ),
      ),
    )
    ;
  }
}