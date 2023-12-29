import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_mobile_app/components/HomeTile.dart';
import 'package:merchant_mobile_app/components/header.dart';
import 'package:merchant_mobile_app/routes.dart';
import 'package:merchant_mobile_app/theme/style.dart';

const double BANNER_PADDING = 15.0;
const double BANNER_HEIGHT = 60.0;
const Size TILE_SIZE = Size(165.0, 165.0);
const double TILE_SPACING = 20.0;
const double TILE_ICON_SIZE = 75.0;
const double FAB_ICON_SIZE = 35.0;
const double MARGIN = 10.0;
const double TILE_PADDING = 35.0;

MaterialStateProperty<OutlinedBorder> faqShape = MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0)));

class DashboardFaqScreen extends StatefulWidget {

  @override
  _DashboadFaqScreenState createState() => _DashboadFaqScreenState();
}

class _DashboadFaqScreenState extends State<DashboardFaqScreen> {
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
        margin: new EdgeInsets.fromLTRB(MARGIN, 0, MARGIN, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeTile(
                    AppLocalizations.of(context).dashboardScreenFaq1Tile,
                    DASHBOARD_FAQ_TPE_ROUTE,
                    Padding(
                      padding: const EdgeInsets.all(TILE_PADDING),
                      child: SvgPicture.asset(
                          "assets/images/logo_button_calculator.svg",
                          width: TILE_ICON_SIZE,
                          height: TILE_ICON_SIZE,
                          color: Colors.white),
                    ),
                    ColorConstants.mandy,
                    faqShape),


                SizedBox(width: TILE_SPACING),
                HomeTile(
                    AppLocalizations.of(context).dashboardScreenFaq2Title,
                    FAQ_POS_TERM_SVC_ROUTE,
                    Padding(
                      padding: const EdgeInsets.all(TILE_PADDING),
                      child: SvgPicture.asset("assets/images/logo_button_TPE.svg",
                          width: TILE_ICON_SIZE,
                          height: TILE_ICON_SIZE,
                          color: Colors.white),
                    ),
                    ColorConstants.tradeWind,
                    faqShape),
              ],
            ),
          ],
        ),
      ),
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
    );
  }
}

