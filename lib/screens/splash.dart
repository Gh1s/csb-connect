import 'dart:io';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:merchant_mobile_app/environment_config.dart';
import 'package:merchant_mobile_app/routes.dart';
import 'package:merchant_mobile_app/screens/dashboard.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => new _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  Future<bool> initBackOfficeConnection() async {
    final storage = FlutterSecureStorage();
    final registrationToken = await FirebaseMessaging.instance.getToken();
    final key = await rootBundle.loadString("assets/security/public.pem");
    final parser = encrypt.RSAKeyParser();
    final publicKey = parser.parse(key);

    final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: publicKey));
    final authToken = encrypter.encrypt(registrationToken);

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    var deviceInfo;
    var manufacturer;
    var model;
    var os;

    if (Platform.isAndroid) {
      deviceInfo = await deviceInfoPlugin.androidInfo;
      manufacturer = deviceInfo.manufacturer;
      model = deviceInfo.model;
      os = "Android ${deviceInfo.version.release}";
    } else if (Platform.isIOS) {
      deviceInfo = await deviceInfoPlugin.iosInfo;
      manufacturer = deviceInfo.identifierForVendor;
      model = deviceInfo.model;
      os = "iOS ${deviceInfo.systemVersion}";
    }
    //TODO: supprimer BadCertificateCallback lorsque les certificats seront valide et non auto-signé
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client
        .putUrl(Uri.parse("${EnvironmentConfig.FTPE_URL_API}/devices")); // TODO the error is here
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json");

    Map body = {
      "registrationToken": "$registrationToken",
      "authToken": "${authToken.base64}",
      "manufacturer": "$manufacturer",
      "model": "$model",
      "os": "$os"
    };
    request.add(utf8.encode(json.encode(body)));
    await request.close();

    storage.write(key: "authToken", value: authToken.base64);
    return true;
  }

  Future<void> _initializeAsyncDependencies() async {
    try {
      // >>> initialize async dependencies <<<
      // >>> register favorite dependency manager <<<
      // >>> reap benefits <<<
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      // The Firebase connection is initialized here, because we need the MaterialApp
      // navigator to be initialized also.
      FirebaseMessaging.instance.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true);
      await FirebaseMessaging.instance
          .subscribeToTopic(EnvironmentConfig.ALERTS_TOPIC);

      FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        Navigator.of(context).pushNamed(ALERTS_ROUTE, arguments: AlertsArguments(message.data['id']));
      });

      var sucess = await initBackOfficeConnection();

      final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        Navigator.of(context).pushNamed(ALERTS_ROUTE,
            arguments: AlertsArguments(initialMessage.data['id'], routeOrigin: "/")
        );
      }else{
        Navigator.of(context).pushReplacementNamed(DASHBOARD_ROUTE);
      }
    } catch (e) {
      Navigator.of(context).pushReplacementNamed(DASHBOARD_ROUTE); //TODO added to prevent network error to stop the app
      await showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
                title: Column(
                    children: [
                      Text("Une erreur s'est produite lors de la connexion", style: TextStyle(fontSize: 14.0)),
                    ]
                )
            );
          }
      );
      Navigator.of(context).pushReplacementNamed(SPLASH_ROUTE);
    }

  }

  @override
  void initState() {
    _initializeAsyncDependencies();
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(child: CircularProgressIndicator())
    );
  }
}