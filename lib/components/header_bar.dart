import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/theme/style.dart';

class HeaderBarComponent extends StatefulWidget implements PreferredSizeWidget {
  HeaderBarComponent({Key key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);
  
  @override
  final Size preferredSize;

  @override
  _HeaderBarComponentState createState() => _HeaderBarComponentState();  
}

class _HeaderBarComponentState extends State<HeaderBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: FaIcon(FontAwesomeIcons.chevronLeft, color: ColorConstants.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
