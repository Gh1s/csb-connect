import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:merchant_mobile_app/components/header.dart';
import 'package:merchant_mobile_app/components/header_bar.dart';
import 'package:merchant_mobile_app/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/components/title.dart';
import 'package:merchant_mobile_app/components/footer.dart';
import 'package:url_launcher/url_launcher.dart';


const double TILE_SPACING = 15.0;
const double TILE_ICON_SIZE = 50.0;
const double TILE_FONT_SIZE = 18.0;
class LegalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messages = AppLocalizations.of(context);
    return Scaffold(
      appBar: HeaderBarComponent(),
      body: Column(
        children: [
          HeaderComponent(),
          TitleComponent(
            color: ColorConstants.wasabi,
            icon: FontAwesomeIcons.balanceScale,
            text: messages.legalsScreenTitle
          ),
          TextButton(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: TILE_SPACING),
                  Text(
                    messages.legalsScreenToSButtonText, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TILE_FONT_SIZE,
                    )
                  ),
                ],
              ),
            onPressed: () async => await launch("https://www.csb.nc/conditions-generales-dutilisation-appli/"),
          ),
          TextButton(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: TILE_SPACING),
                  Text(
                    messages.legalsScreenPrivacyPolicyButtonText, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TILE_FONT_SIZE,
                    )
                  ),
                ],
              ),
            onPressed: () async => await launch("https://www.csb.nc/politique-de-confidentialite-appli/"),
          ),
          TextButton(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: TILE_SPACING),
                  Text(
                    messages.legalsScreenLegalNoticeButtonText, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TILE_FONT_SIZE,
                    )
                  ),
                ],
              ),
            onPressed: () async => await launch("https://www.csb.nc/mentions-legales-appli/"),
          )
        ],
      ),
      bottomNavigationBar: FooterComponent(),
    );
  }
}