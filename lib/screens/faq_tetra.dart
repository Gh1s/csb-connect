import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/components/header_bar.dart';
import 'package:merchant_mobile_app/components/footer.dart';
import 'package:merchant_mobile_app/components/title.dart';
import 'package:merchant_mobile_app/theme/style.dart';

import '../components/FaqPageView.dart';


class FaqTetraScreen extends StatelessWidget {

  FaqTetraScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBarComponent(),
      body: FaqPageView(
          title: TitleComponent(
              color: ColorConstants.mandy, //TODO
              icon: FontAwesomeIcons.creditCard,
              text: AppLocalizations.of(context).faqScreenPosTermTitle //TODO
          ),
          whichFaq: "pos_term_tetra"
      ),
      //body: _FaqServicePageView(),
      bottomNavigationBar: FooterComponent(),
    );
  }
}
