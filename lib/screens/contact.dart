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
const double TILE_ICON_SIZE = 50.0;
const double TILE_FONT_SIZE = 18.0;

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final messages = AppLocalizations.of(context);
    return Scaffold(
      appBar: HeaderBarComponent(),
      body: ListView(
        children: [
          HeaderComponent(),
          TitleComponent(
            color: ColorConstants.wasabi,
            icon: FontAwesomeIcons.comments,
            text: messages.contactScreenTitle
          ),
          LayoutBuilder(
            builder: (context, constraints) => Padding(
              padding: EdgeInsets.fromLTRB(
                constraints.maxWidth * 0.1,
                TILE_SPACING,
                constraints.maxWidth * 0.1,
                TILE_SPACING
              ),
              child: Column(
                children: [
                  _ContactTile(
                    icon: FontAwesomeIcons.envelope, 
                    text: messages.contactScreenMailTile_0,
                    children: [
                      Text(messages.contactScreenMailTile_1)
                    ],
                    onPressed: () async => await launch("mailto:${messages.contactScreenMailTile_1}"),
                  ),
                  SizedBox(height: TILE_SPACING),
                  _ContactTile(
                    icon: FontAwesomeIcons.phone, 
                    text: messages.contactScreenPhoneTile_0,
                    children: [
                      Text(messages.contactScreenPhoneTile_1)
                    ],
                    onPressed: () async => await launch("tel:${messages.contactScreenPhoneTile_1}"),
                  ),
                  SizedBox(height: TILE_SPACING),
                  _ContactTile(
                    icon: FontAwesomeIcons.mapMarkerAlt, 
                    text: messages.contactScreenAddressTile_0,
                    children: [
                      Text(messages.contactScreenAddressTile_1),
                      Text(messages.contactScreenAddressTile_2)
                    ],
                    onPressed: () async => await launch(messages.contactScreenAddressTile_3),
                  ),
                  SizedBox(height: TILE_SPACING),
                  _ContactTile(
                    icon: FontAwesomeIcons.clock, 
                    text: messages.contactScreenOpeningHoursTile_0,
                    children: [
                      Text(messages.contactScreenOpeningHoursTile_1),
                      Text(messages.contactScreenOpeningHoursTile_2),
                      Text(messages.contactScreenOpeningHoursTile_3)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FooterComponent(),
    );
  }
}

class _ContactTile extends StatelessWidget {
  _ContactTile({@required this.icon, @required this.text, this.children, this.onPressed});
  
  final IconData icon;
  final String text;
  final List<Widget> children;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.shadow,
                  blurRadius: ComponentConstants.shadowBlurRadius,
                  offset: Offset(
                    ComponentConstants.shadowOffsetX,
                    ComponentConstants.shadowOffsetY
                  )
                )
              ]
            ),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ColorConstants.atlantis),
                foregroundColor: MaterialStateProperty.all(ColorConstants.white),
                shape: MaterialStateProperty.all(ContinuousRectangleBorder()),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, size: TILE_ICON_SIZE),
                  SizedBox(height: TILE_SPACING),
                  Text(
                    text, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TILE_FONT_SIZE,
                    )
                  ),
                  ...(children ?? [])
                ],
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    );
  }
}
