import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:merchant_mobile_app/components/TpeTile.dart';
import 'package:merchant_mobile_app/components/header.dart';
import 'package:merchant_mobile_app/routes.dart';

const double BANNER_PADDING = 15.0;
const double BANNER_HEIGHT = 60.0;
const Size TILE_SIZE = Size(150.0, 150.0);
const double TILE_SPACING = 15.0;
const double TILE_ICON_SIZE = 75.0;
const double FAB_ICON_SIZE = 35.0;
const double TILE_MARGIN = 5.0;


class DashboardFaqTpeScreen extends StatefulWidget {

  @override
  _DashboardFaqTpeScreenState createState() => _DashboardFaqTpeScreenState();
}

class _DashboardFaqTpeScreenState extends State<DashboardFaqTpeScreen> {
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
                //SizedBox(width: TILE_SPACING),

                TpeTile(
                      AppLocalizations.of(context).dashboardFaqScreenTitle,
                      FAQ_POS_TERM_TELIUM,
                      "assets/images/TPE_ICT_220_Fixe_Telium_II_IP.jpg"
                    ),
                SizedBox(width: TILE_SPACING),

                TpeTile(
                          AppLocalizations.of(context).dashboardFaqScreenTitle2,
                          FAQ_POS_TERM_TETRA,
                          "assets/images/TPE_Desk_5000_EM.jpg"
                      )
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

