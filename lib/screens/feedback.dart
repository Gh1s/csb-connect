import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/components/header.dart';
import 'package:merchant_mobile_app/components/header_bar.dart';
import 'package:merchant_mobile_app/components/footer.dart';
import 'package:merchant_mobile_app/components/title.dart';
import 'package:merchant_mobile_app/environment_config.dart';
import 'package:merchant_mobile_app/theme/style.dart';
import 'package:launch_review/launch_review.dart';
import 'package:merchant_mobile_app/routes.dart';

const double TILE_PADDING = 20.0;
const double TEXT_PADDING_VERTICAL = 5.0;
const double TEXT_PADDING_HORIZONTAL = 10.0;
const SMAILS_ENDPOINT_API = "${EnvironmentConfig.FTPE_URL_API}/feedback";

class FeedbackScreen extends StatelessWidget {
  final int pageIndex;

  FeedbackScreen({this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBarComponent(),
      body: _FeedbackPageView(pageIndex: pageIndex),
      bottomNavigationBar: FooterComponent(),
    );
  }
}

/// Represents the page view of the screen.
/// It enables gestures detection to swipe pages horizontaly.
class _FeedbackPageView extends StatefulWidget {
  final int pageIndex;

  _FeedbackPageView({@required this.pageIndex});

  @override
  _FeedbackViewState createState() => _FeedbackViewState(pageIndex: pageIndex);
}

class _FeedbackViewState extends State<_FeedbackPageView> {
  int pageIndex;
  PageController pageController;
  
  _FeedbackViewState({@required this.pageIndex});

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: pageIndex,
      keepPage: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = AppLocalizations.of(context);
    return ListView(
      children: [
        HeaderComponent(),
        TitleComponent(
          color: ColorConstants.wasabi,
          icon: FontAwesomeIcons.lightbulb,
          text: messages.feedbackScreenTitle
        ),
        SizedBox(height: TILE_PADDING),
        Padding(
          padding: EdgeInsets.symmetric(vertical: TEXT_PADDING_VERTICAL, horizontal: TEXT_PADDING_HORIZONTAL),
          child: Text(messages.feedbackScreenContentBody, textAlign: TextAlign.justify)
        ),
        SizedBox(height: TILE_PADDING),
        Padding(
          padding: EdgeInsets.symmetric(vertical: TEXT_PADDING_VERTICAL, horizontal: TEXT_PADDING_HORIZONTAL),
          child: Text(messages.feedbackScreenQuestion, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: ColorConstants.wasabi,
              fontSize: 18
            )
          ),
        ),
        Container(
          height: 225,
          child: PageView(
            controller: pageController,
            children: [
              FeedbackScreenList1(),
              FeedbackScreenList2()
            ],
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}

class FeedbackScreenList1 extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final messages = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.all(TILE_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FeedbackListItemButton(
            buttonTitle: messages.feedbackScreenButtonTitle_1, 
            buttonSubtitle: messages.feedbackScreenButtonSubtitle_1,
            colorBackground: ColorConstants.tradeWind,
            onPressed: () => LaunchReview.launch(),
          ),
          SizedBox(height: TILE_PADDING),
          _FeedbackListItemButton(
            buttonTitle: messages.feedbackScreenButtonTitle_2, 
            buttonSubtitle: messages.feedbackScreenButtonSubtitle_2,
            colorBackground: ColorConstants.seaBuckthorn,
            onPressed: () => Navigator.pushNamed(context, FEEDBACK_COMMENT),
          ),
        ],
      ),
    );
  }
}

class FeedbackScreenList2 extends StatefulWidget {

  @override
  _FeedbackScreenList2State createState() => _FeedbackScreenList2State();
}

class _FeedbackScreenList2State extends State<FeedbackScreenList2> {
  final userInputFeedbackController = TextEditingController();
  final storage = FlutterSecureStorage();
  
  @override
  Widget build(BuildContext context) {
    final messages = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.all(TILE_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FeedbackListItemButton(
            buttonTitle: messages.feedbackScreenButtonTitle_2, 
            buttonSubtitle: messages.feedbackScreenButtonSubtitle_2,
            colorBackground: ColorConstants.seaBuckthorn
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: messages.feedbackScreen2TextFieldLabel
            ),
            maxLines: null,
            controller: userInputFeedbackController,
          ),
          ElevatedButton(onPressed: () => sendEmail(userInputFeedbackController.text), child: Text(messages.feedbackScreen2ButtonTitle)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    userInputFeedbackController.dispose();
    super.dispose();
  }

  Future<void> sendEmail(String content) async {
    final messages = AppLocalizations.of(context);
    var authToken = await storage.read(key: "authToken");
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client.postUrl(Uri.parse(SMAILS_ENDPOINT_API));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
    request.headers.set(HttpHeaders.authorizationHeader, "AuthToken $authToken");

    Map body = {
      "parametres": "$content"
    };
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(response.statusCode == HttpStatus.created ? messages.feedbackScreen2FeedbackSent : messages.feedbackScreen2FeedbackError),
        actions: [
          TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text(messages.feedbackScreen2PopupClose))
        ],
      )
    );
  }
}

class _FeedbackListItemButton extends StatelessWidget{
  final String buttonTitle;
  final String buttonSubtitle;
  final Color colorBackground;
  final Function onPressed;

  _FeedbackListItemButton({@required this.buttonTitle, @required this.buttonSubtitle, this.onPressed, @required this.colorBackground});

  @override
  Widget build(BuildContext context){
    return TextButton(
      //TODO Check ios store
      onPressed:  this.onPressed, 
      child: Column(
        children: [
          Text(this.buttonTitle, 
            style: TextStyle(
              color: ColorConstants.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
          Text(this.buttonSubtitle,
            style: TextStyle(
              color: ColorConstants.white,
              fontSize: 14
            ),
          ),
        ],
      ),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(this.colorBackground),
        shape: MaterialStateProperty.all(ContinuousRectangleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(TILE_PADDING)),
      ),
    );
  }
}