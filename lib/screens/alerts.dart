import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:merchant_mobile_app/components/header.dart';
import 'package:merchant_mobile_app/components/title.dart';
import 'package:merchant_mobile_app/environment_config.dart';
import 'package:merchant_mobile_app/screens/dashboard.dart';
import 'package:merchant_mobile_app/theme/style.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:merchant_mobile_app/components/header_bar.dart';
import 'package:merchant_mobile_app/components/footer.dart';

import '../routes.dart';

class AlertsScreen extends StatefulWidget {

  AlertsScreen();

  @override
  _AlertsScreenState createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {

  _AlertsScreenState();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as AlertsArguments;
    return Scaffold(
      appBar: args != null && args.routeOrigin == SPLASH_ROUTE ? 
        AppBar(
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.chevronLeft, color: ColorConstants.white),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(DASHBOARD_ROUTE);
            },
          ),
        ) 
        : HeaderBarComponent(),
      body: PagedAlertListView(),
      bottomNavigationBar: FooterComponent(),
    );
  }
}

class PagedAlertListView extends StatefulWidget {
  @override
  _PagedAlertListViewState createState() => _PagedAlertListViewState();
}

class _PagedAlertListViewState extends State<PagedAlertListView> {
  final storage = FlutterSecureStorage();
  static const _pageSize = 10;
  final _pagingController = PagingController<int, AlertGroup>(firstPageKey: -1);

  @override
  void initState() {      
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if(pageKey == -1){
        var list = [AlertGroup(key: "-2", alerts: null, endAt: null, startAt: null), AlertGroup(key: "-1", alerts: null, endAt: null, startAt: null)];
        _pagingController.appendPage(list, 0);
      }else{
        var authToken = await storage.read(key: "authToken"); 
        //TODO: remplacer l'IP lorsque le serveur sera disponible et que l'encryption sera faite
        //TODO: supprimer BadCertificateCallback lorsque les certificats seront valide et non auto-signé
        HttpClient client = new HttpClient();
        client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

        HttpClientRequest request = await client.getUrl(Uri.parse("${EnvironmentConfig.FTPE_URL_API}/alerts?skip=$pageKey&take=$_pageSize"));
        request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
        request.headers.set(HttpHeaders.acceptHeader, "application/json");
        request.headers.set(HttpHeaders.authorizationHeader, "AuthToken $authToken");

        HttpClientResponse response = await request.close();
        String reply = await response.transform(utf8.decoder).join();

        final responseJson = AlertResponse.fromJson(jsonDecode(reply));
        final newItems = responseJson.groups;
        final isLastPage = responseJson.size < _pageSize;
        
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + responseJson.size;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh()
      ),
      child: PagedListView.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<AlertGroup>(
          itemBuilder: (context, item, index) => AlertGroupTile(alertGroup: item, headerBuild: item.key == "-2", titleBuild:  item.key == "-1"),
        ), 
        separatorBuilder: (context, index) => SizedBox(
          height: 16,
        ),
      ),
    );
  }
}

class AlertGroupTile extends StatelessWidget {
  final AlertGroup alertGroup;
  final bool headerBuild;
  final bool titleBuild;

  AlertGroupTile({this.alertGroup, this.headerBuild, this.titleBuild});

  @override
  Widget build(BuildContext context) {
    if(headerBuild){
      return HeaderComponent();
    }else{
      if(titleBuild){
        final messages = AppLocalizations.of(context);
        return TitleComponent(
          color: ColorConstants.seaBuckthorn,
          icon: FontAwesomeIcons.infoCircle,
          text: messages.dashboardScreenAlertsTile
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,0,16,0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          color: Color(0xff989898),
          indicatorTheme: IndicatorThemeData(
            position: 0,
            size: 20.0,
          ),
          connectorTheme: ConnectorThemeData(
            thickness: 2.5,
          )
        ),
        builder: TimelineTileBuilder.connected(
          itemCount: alertGroup.alerts.length,
          connectionDirection: ConnectionDirection.before,
          contentsBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AlertTile(alert: alertGroup.alerts[index]),
                  SizedBox(height: 10)
                ],
              ),
            );
          },
          indicatorBuilder: (_, __) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: OutlinedDotIndicator(
                color: ColorConstants.atlantis,
                borderWidth: 2.5,
              )
            );
          },
          connectorBuilder: (_, index, __) => SolidLineConnector(
            color: ColorConstants.atlantis,
          ),
        ),
      ),
    );
  }
}

class AlertTile extends StatelessWidget {

  final Alert alert;

  AlertTile({this.alert});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as AlertsArguments;
    return Container(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: (args != null && args.id == alert.id) ? true:false,
          title: Text(alert.title,
            style: TextStyle(
            fontSize: 18.0
            ),
          ),
          subtitle: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.parse(alert.createdAt).toLocal()),
              style: TextStyle(fontStyle: FontStyle.italic)
            )
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Text(alert.body,
                textAlign: TextAlign.justify
              )
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: ColorConstants.greyLight,
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
    );
  }
}

class Alert{
  final String id;
  final String title;
  final String body;
  final String createdAt;
  final String groupKey;

  Alert({this.id, this.title, this.body, this.createdAt, this.groupKey});

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json["id"], 
      title: json["title"],
      body: json["body"],
      createdAt: json["createdAt"],
      groupKey: json["groupKey"]
    );
  }

  static List<Alert> parseList(List<dynamic> list) {
    return list.map((i) => Alert.fromJson(i)).toList();
  }
}

class AlertGroup{
  final String key;
  final String startAt;
  final String endAt;
  final List<Alert> alerts;

  AlertGroup({this.key, this.startAt, this.endAt, this.alerts});

    factory AlertGroup.fromJson(Map<String, dynamic> json) {
    return AlertGroup(
      key: json["key"], 
      startAt: json["startAt"],
      endAt: json["endAt"],
      alerts:  (json["alerts"] as List).map((e) => Alert.fromJson(e)).toList()
    );
  }

  static List<AlertGroup> parseList(List<dynamic> list) {
    return list.map((i) => AlertGroup.fromJson(i)).toList();
  }
}

class AlertResponse{
  final int skip;
  final int take;
  final int size;
  final int total;
  final List<AlertGroup> groups;

  AlertResponse({this.skip, this.take, this.size, this.total, this.groups});

  factory AlertResponse.fromJson(Map<String, dynamic> json) {
    return AlertResponse(
      skip: json["skip"], 
      take: json["take"],
      size: json["size"],
      total: json["total"],
      groups:  (json["groups"] as List).map((e) => AlertGroup.fromJson(e)).toList()
    );
  }

  static List<AlertResponse> parseList(List<dynamic> list) {
    return list.map((i) => AlertResponse.fromJson(i)).toList();
  }
}