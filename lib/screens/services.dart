import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/components/header.dart';
import 'package:merchant_mobile_app/components/header_bar.dart';
import 'package:merchant_mobile_app/components/footer.dart';
import 'package:merchant_mobile_app/components/title.dart';
import 'package:merchant_mobile_app/theme/style.dart';
import 'package:url_launcher/url_launcher.dart';

const double TILE_SPACING = 15.0;

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messages = AppLocalizations.of(context);
    return Scaffold(
      appBar: HeaderBarComponent(),
      body: ListView(
        children: [
          HeaderComponent(),
          TitleComponent(
              color: ColorConstants.brown,
              icon: FontAwesomeIcons.solidPaperPlane,
              text: messages.servicesScreenTitle),
          SizedBox(height: TILE_SPACING),
          _ServiceItem(
            title: messages.servicesScreenEpayNCItemTitle,
            imagePath: "assets/images/background_epaync.jpg",
            logoPath: "assets/images/logo_epaync.png",
            onPressed: () => launch("https://www.epaync.nc/")
          ),
          SizedBox(height: TILE_SPACING),
          _ServiceItem(
            title: messages.servicesScreenTydocItemTitle,
            imagePath: "assets/images/background_tydoc.jpg",
              logoPath: "assets/images/logo_tydoc.png",
              onPressed: () => launch("https://www.tydoc-csb.nc/")
          ),
        ],
      ),
      bottomNavigationBar: FooterComponent(),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  _ServiceItem({@required this.title, this.body, this.imagePath, this.onPressed, @required this.logoPath});

  final String title;
  final String imagePath;
  final StatelessWidget body;
  final Function onPressed;
  final String logoPath;

  @override
  Widget build(BuildContext context) {
    final messages = AppLocalizations.of(context);
    return Stack(
      children:[
        Container(
          child: Stack(
            children: [
              Image.asset(this.imagePath),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(color: ColorConstants.black.withOpacity(0.5))
                )
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(color: ColorConstants.atlantis),
          constraints: BoxConstraints.expand(height: 20),
          child: Center(
            child: Text(this.title, style: TextStyle(color: ColorConstants.white))
          )
        ),
        Positioned(
          bottom: 1,
          left: 1,
          child: Column(
            children:[
              Image.asset(this.logoPath, width: 100),
              TextButton(
                child:
                  Text(
                    messages.servicesScreenButtonLabelLearnMore, style: TextStyle(color: ColorConstants.white),
                  ),
                onPressed: this.onPressed,
              ),
            ]
          )
        )       
      ]
    );
  }
}
