import 'package:flutter/material.dart';
import 'package:merchant_mobile_app/theme/style.dart';
import 'package:merchant_mobile_app/components/dashboardTile.dart';

const double BANNER_PADDING = 15.0;
const double BANNER_HEIGHT = 60.0;
const Size TILE_SIZE = Size(150.0, 150.0);
const double TILE_SPACING = 15.0;
const double TILE_ICON_SIZE = 75.0;
const double FAB_ICON_SIZE = 35.0;
const double TILE_MARGIN = 5.0;


class TpeTile extends StatelessWidget {

  final String inputText;
  final String inputRoute;
  final String inputImgPath;

  const TpeTile(this.inputText, this.inputRoute, this.inputImgPath);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.fromLTRB(TILE_MARGIN, 0, TILE_MARGIN, 0),
            child: DashboardTile(
              color: ColorConstants.white,
              size: TILE_SIZE,
              icon: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(
                  inputImgPath,
                  width: TILE_ICON_SIZE,
                  height: TILE_ICON_SIZE,
                ),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )
              ),
              text: Text(
                inputText,
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, inputRoute),
            ) // _DashboardTile
        ),
      )
    ;
  }
}

