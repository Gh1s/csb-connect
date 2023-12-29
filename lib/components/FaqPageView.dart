import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merchant_mobile_app/components/header.dart';
import 'package:merchant_mobile_app/components/title.dart';
import 'package:merchant_mobile_app/theme/style.dart';
import 'package:url_launcher/url_launcher.dart';

const double ACCORDION_PADDING = 15.0;
const double ACCORDION_MARGIN = 15.0;
const double ACCORDION_BORDER_RADIUS = 5.0;

const double TEXT_PADDING_VERTICAL = 5.0;
const double TEXT_PADDING_HORIZONTAL = 10.0;

const double TILE_PADDING = 10.0;

const double VIDEO_PLAYER_HEIGHT = 240.0;

const int DOT_COUNT = 2;
const double DOT_SIZE = 15.0;


/// Represents the page view of the screen.
/// It enables gestures detection to swipe pages horizontaly.
class FaqPageView extends StatefulWidget {
  final TitleComponent title;
  final String whichFaq;

  FaqPageView({@required this.title, @required this.whichFaq});


  @override
  FaqPageViewState createState() => FaqPageViewState(
    title: title,
    whichFaq: whichFaq
  );
}

class FaqPageViewState extends State<FaqPageView> {
  final TitleComponent title;
  final String whichFaq;
  FaqPageViewState({@required this.title, @required this.whichFaq});


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            children: [
              _FaqPosTermPage(title: title, whichFaq: whichFaq),
            ],
          ),
        ),
      ],
    );
  }
}

/// Represents the POS terminal FAQ page.
class _FaqPosTermPage extends StatelessWidget {

  _FaqPosTermPage({@required this.title, @required this.whichFaq});

  final TitleComponent title;
  final String whichFaq;

  @override
  Widget build(BuildContext context) {
    final messages = AppLocalizations.of(context);
    return ListView(
      children: [
        HeaderComponent(),
        title,
        SizedBox(height: TILE_PADDING),
        Padding(
            padding: EdgeInsets.symmetric(vertical: TEXT_PADDING_VERTICAL, horizontal: TEXT_PADDING_HORIZONTAL),
            child: Text(messages.faqScreenPosTermContentIntro, textAlign: TextAlign.justify)
        ),
        FutureBuilder<List<_FaqArticle>>(
          future: _FaqArticle.fromAssets(context, whichFaq),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // Loading the JSON asset shouldn't take too long,
              // that's why we return an empty container while it loads.
              return Container(color: ColorConstants.white);
            } else {
              return _FaqAccordion(articles: snapshot.data);
            }
          },
        ),
      ],
    );
  }
}

/// Represents the accordion that expand & collapse FAQ article.
class _FaqAccordion extends StatelessWidget {
  final List<_FaqArticle> articles;
  final Map<String, Widget Function(BuildContext, _FaqBlock)> _blockBuilders = {
    "html": (context, block) => Html(data: block.content),
    "video": (context, block) => Container(
      height: VIDEO_PLAYER_HEIGHT,
      margin: EdgeInsets.fromLTRB(0, 0, 0, TILE_PADDING),
      child: _FaqWebView(url: block.content),
    ),
    "image": (context, block) => CachedNetworkImage(
        imageUrl: block.content,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => FaIcon(FontAwesomeIcons.exclamationCircle)
    ),
    "linkButton": (context, block) => ElevatedButton(
        child: Text(block.content),
        onPressed:  () async => await launch(block.sub_content)
    ),
    "localImage": (context, block) => Image.asset(block.content),
    "tableau": (context, block) => Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.greyLight),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (block.tab_header!= null &&block.tab_header.isNotEmpty)
            Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorConstants.greyLight, // changer la couleur en hexadécimal
              )),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Html(data: block.tab_header)
                    ),
                  ),
                ),

              ],
            ),
          ),
          if (block.sub_header != null && block.sub_header.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ColorConstants.greyLight, // changer la couleur en hexadécimal
                )),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      child: Center(
                          child: Html(data: block.sub_header)
                      ),
                    ),
                  ),

                ],
              ),
            ),
          SizedBox(height: 8),
          /*** Si une valeur est dans "float" dans le fichier json ***/
          if (block.float!= null &&block.float.isNotEmpty)
            ...block.tabcontent.map((subBlock) =>
              Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorConstants.greyLight)),
            ),

            child: Row(
              children: [
                if (subBlock['description'] != null &&subBlock['description'].isNotEmpty)
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Html(data: subBlock['description']),
                      ),
                    ),
                if (subBlock['image'] != null &&subBlock['image'].isNotEmpty)
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                        child: Image.asset(
                          subBlock['image'],
                          height: 150, // augmenter la hauteur de l'image
                          fit: BoxFit.contain, // ajuster l'image à la taille du conteneur
                        ),
                      ),
                    ),
              ],
            ),
          )).toList(),
          /*** Si il n'y a pas de valeur dans "float" dans le fichier json ***/
          if (block.float == null || block.float.isEmpty)
            ...block.tabcontent.map((subBlock) =>
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: ColorConstants.greyLight)),
                  ),
                  child: Row(
                    children: [
                        if (subBlock['image'] != null &&subBlock['image'].isNotEmpty)
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                              child: Image.asset(
                                subBlock['image'],
                                height: 150, // augmenter la hauteur de l'image
                                fit: BoxFit.contain, // ajuster l'image à la taille du conteneur
                              ),
                            ),
                          ),
                      if (subBlock['description'] != null &&subBlock['description'].isNotEmpty)
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Html(data: subBlock['description']),
                          ),
                        ),
                      if (subBlock['description_icon'] != null && subBlock['description_icon'].isNotEmpty)
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: subBlock['description_icon']
                                  .map<Widget>((icon) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Html(data: icon['valeur']),
                                  if (icon['assets'] != null && icon['assets'].isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                                      child: Image.asset(
                                        icon['assets'],
                                        height: 35, // augmenter la hauteur de l'image
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                ],
                              ))
                                  .toList(),
                            ),
                          ),
                        ),
                    ],
                  ),
                )).toList(),
        ],
      ),
    ),
    "tableauText": (context, block) => Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.greyLight),
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 20.0), // Ajout de la marge
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...block.tabcontent.map((subBlock) => Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorConstants.greyLight)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Html(data: subBlock['libelle']),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Html(data: subBlock['cause']),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    ),
  };

  _FaqAccordion({@required this.articles});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: articles
          .map((a) =>
          Container(
            margin: EdgeInsets.fromLTRB(
                ACCORDION_MARGIN,
                ACCORDION_MARGIN,
                ACCORDION_MARGIN,
                0
            ),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstants.grey),
            ),
            child: ExpansionTile(
              title: Text(a.title),
              backgroundColor: ColorConstants.white,
              collapsedBackgroundColor: ColorConstants.greyLight,
              initiallyExpanded: a.isExpanded,
              children: [
                Padding(
                  padding: EdgeInsets.all(TILE_PADDING),
                  child: Column(
                    children: a.blocks
                        .map((b) => _blockBuilders[b.type](context, b))
                        .toList(),
                  ),
                )
              ],
            ),
          )
      )
          .toList(),
    );
  }
}

/// Represents a web view that can display Youtube videos.
class _FaqWebView extends StatefulWidget {
  final String url;

  _FaqWebView({@required this.url});

  @override
  _FaqWebViewState createState() => _FaqWebViewState(url: url);
}

class _FaqWebViewState extends State<_FaqWebView> {
  final String url;
  bool isLoading = true;

  _FaqWebViewState({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          onLoadStop: (controller, url) => setState(() => isLoading = false),
        ),
        isLoading ? Center( child: CircularProgressIndicator()) : Stack(),
      ],
    );
  }
}

/// A data object that models a FAQ article.
class _FaqArticle {
  final String title;
  final List<_FaqBlock> blocks;
  bool isExpanded = false;

  _FaqArticle({this.title, this.blocks});

  _FaqArticle.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        blocks = (json['blocks'] as List<dynamic>)
            .map((e) => _FaqBlock.fromJson(e))
            .toList();

  static Future<List<_FaqArticle>> fromAssets(BuildContext context, String asset) async {
    final Locale locale = Localizations.localeOf(context);
    final String json = await DefaultAssetBundle
        .of(context)
        .loadString("assets/faq/${asset}_${locale.languageCode}.json");
    return (jsonDecode(json) as List<dynamic>)
        .map((e) => _FaqArticle.fromJson(e))
        .toList();
  }
}

/// A data object that models a block of content in a FAQ article.
/// It can either be :
/// - html: Html content.
/// - video : A Youtube video.
/// - image : An image loaded from an external source.
class _FaqBlock {
  final String type;
  final String content;
  final List<String> headers;
  final List<dynamic> tabcontent;
  final String tab_header;
  final String sub_header;
  final List<dynamic> htmlcontent;
  final String float;
  final String image;
  final String description;
  final String sub_content;

  _FaqBlock({this.type, this.content, this.headers,  this.tabcontent, this.tab_header, this.sub_header, this.htmlcontent, this.float, this.image, this.description, this.sub_content});

  _FaqBlock.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        content = json['content'],
        headers = json['headers'],
        tabcontent = json['tabcontent'],
        tab_header = json['tab_header'],
        sub_header = json['sub_header'],
        htmlcontent = json['htmlcontent'],
        float = json['float'],
        image = json['image'],
        description = json['description'],
        sub_content = json['sub_content'];
}
