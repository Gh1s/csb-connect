
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/components/header.dart';
import 'package:merchant_mobile_app/routes.dart';
import 'package:merchant_mobile_app/theme/style.dart';
import 'package:merchant_mobile_app/components/HomeTile.dart';

const double BANNER_PADDING = 15.0;
const double BANNER_HEIGHT = 60.0;
const Size TILE_SIZE = Size(160.0, 160.0);
const double TILE_SPACING = 25.0;
const double TILE_ICON_SIZE = 75.0;
const double ICON_PADDING = 10.0;
const double FAB_ICON_SIZE = 35.0;
MaterialStateProperty<OutlinedBorder> homeShape = MaterialStateProperty.all<OutlinedBorder>(ContinuousRectangleBorder());

class DashboardScreen extends StatefulWidget {
  @override
  _DashboadScreenState createState() => _DashboadScreenState();
}

class _DashboadScreenState extends State<DashboardScreen> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    // We can't apply the async operator to the initState method.
    // Instead, we can call an async function to do the async stuff.
  }

  Widget _banner(BuildContext context) {
    return Container();
    // return Container(
    //   decoration: BoxDecoration(
    //     color: ColorConstants.seaBuckthorn,
    //     boxShadow: [
    //       BoxShadow(
    //         color: ColorConstants.shadow,
    //         blurRadius: ComponentConstants.shadowBlurRadius,
    //         offset: Offset(ComponentConstants.shadowOffsetX, ComponentConstants.shadowOffsetY)
    //       )
    //     ]
    //   ),
    //   height: BANNER_HEIGHT,
    //   child: Padding(
    //     padding: EdgeInsets.all(BANNER_PADDING),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         FaIcon(FontAwesomeIcons.exclamationTriangle, color: ColorConstants.white),
    //         SizedBox(width: BANNER_PADDING),
    //         Text("Work in progess!", style: TextStyle(color: ColorConstants.white)),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _tiles(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TILE_SPACING),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeTile(
                    AppLocalizations.of(context).dashboardScreenAlertsTile,
                    ALERTS_ROUTE,
                    FaIcon(FontAwesomeIcons.infoCircle, size: TILE_ICON_SIZE),
                    ColorConstants.seaBuckthorn,
                    homeShape
                ),

                SizedBox(width: TILE_SPACING),

                HomeTile(
                    AppLocalizations.of(context).dashboardScreenFaq1Tile,
                    DASHBOARD_FAQ_TPE_ROUTE,
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset("assets/images/logo_button_calculator.svg",
                          width: TILE_ICON_SIZE,
                          height: TILE_ICON_SIZE,
                          color: Colors.white),
                    ), ColorConstants.mandy,
                    homeShape
                ),
              ],
            ),
            SizedBox(height: TILE_SPACING),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeTile(
                    AppLocalizations.of(context).dashboardScreenFaq2Title,
                    FAQ_POS_TERM_SVC_ROUTE,
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset("assets/images/logo_button_TPE.svg",
                          width: TILE_ICON_SIZE,
                          height: TILE_ICON_SIZE,
                          color: Colors.white),
                    ),
                    ColorConstants.tradeWind,
                    homeShape
                ),

                SizedBox(width: TILE_SPACING),

                HomeTile(
                    AppLocalizations.of(context).dashboardScreenContactTile,
                    CONTACT_ROUTE,
                    FaIcon(FontAwesomeIcons.comments, size: TILE_ICON_SIZE),
                    ColorConstants.wasabi,
                    homeShape
                ),



              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fab(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: SERVICES_ROUTE,
          child: Text(
              AppLocalizations.of(context).dashboardScreenFabMenuOtherServices),
        ),
        PopupMenuItem<String>(
          value: FEEDBACK_ROUTE,
          child:
              Text(AppLocalizations.of(context).dashboardScreenFabMenuFeedback),
        ),
        PopupMenuItem<String>(
          value: LEGALS_ROUTE,
          child:
              Text(AppLocalizations.of(context).dashboardScreenFabMenuLegals),
        ),
      ],
      // ignore: missing_required_param
      child: FloatingActionButton(
        backgroundColor: ColorConstants.atlantis,
        foregroundColor: ColorConstants.white,
        child: Icon(Icons.add, size: FAB_ICON_SIZE),
      ),
      onSelected: (route) => Navigator.pushNamed(context, route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          HeaderComponent(),
          _banner(context),
          _tiles(context),
        ],
      ),
      floatingActionButton: _fab(context),
    );
  }
}

class AlertsArguments {
  final String id;
  final String routeOrigin;
  AlertsArguments(this.id, {this.routeOrigin});
}


