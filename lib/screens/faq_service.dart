import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/components/FaqPageView.dart';
import 'package:merchant_mobile_app/components/header_bar.dart';
import 'package:merchant_mobile_app/components/footer.dart';
import 'package:merchant_mobile_app/components/title.dart';
import 'package:merchant_mobile_app/theme/style.dart';


class FaqServiceScreen extends StatelessWidget {

  FaqServiceScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBarComponent(),
      body: FaqPageView(
          title: TitleComponent(
              color: ColorConstants.tradeWind,
              icon: FontAwesomeIcons.solidCreditCard,
              text: AppLocalizations.of(context).faqScreenPosTermServicesTitle
          ),
          whichFaq: "pos_term_services"
      ),
      //body: _FaqServicePageView(),
      bottomNavigationBar: FooterComponent(),
    );
  }
}

