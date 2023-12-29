import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/routes.dart';
import 'package:merchant_mobile_app/theme/style.dart';

class FooterComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      selectedFontSize: ComponentConstants.footerFontSize,
      selectedItemColor: ColorConstants.chicago,
      selectedLabelStyle: TextStyle(color: ColorConstants.chicago),
      showSelectedLabels: true,
      unselectedFontSize: ComponentConstants.footerFontSize,
      unselectedItemColor: ColorConstants.chicago,
      unselectedLabelStyle: TextStyle(color: ColorConstants.chicago),
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home),
          label: AppLocalizations.of(context).footerHomeButton
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.infoCircle),
          label: AppLocalizations.of(context).footerAlertsButton
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.questionCircle),
          label: AppLocalizations.of(context).footerFaqButton
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.comments),
          label: AppLocalizations.of(context).footerContactButton
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamedAndRemoveUntil(context, DASHBOARD_ROUTE, (r) => false);
            break;
          case 1:
            Navigator.pushNamed(context, ALERTS_ROUTE);
            break;
          case 2:
            Navigator.pushNamed(context, DASHBOARD_FAQ_ROUTE);
            break;
          case 3:
            Navigator.pushNamed(context, CONTACT_ROUTE);
            break;
          default:
        }
      },
    );
  }
}
