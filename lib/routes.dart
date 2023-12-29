import 'package:flutter/material.dart';
import 'package:merchant_mobile_app/screens/alerts.dart';
import 'package:merchant_mobile_app/screens/contact.dart';
import 'package:merchant_mobile_app/screens/dashboard.dart';
import 'package:merchant_mobile_app/screens/dashboard_faq.dart';
import 'package:merchant_mobile_app/screens/dashboard_faq_tpe.dart';
import 'package:merchant_mobile_app/screens/faq_service.dart';
import 'package:merchant_mobile_app/screens/faq_tetra.dart';
import 'package:merchant_mobile_app/screens/faq_telium.dart';
import 'package:merchant_mobile_app/screens/feedback.dart';
import 'package:merchant_mobile_app/screens/legals.dart';
import 'package:merchant_mobile_app/screens/services.dart';
import 'package:merchant_mobile_app/screens/splash.dart';

const String SPLASH_ROUTE = '/';
const String DASHBOARD_ROUTE = '/dashboard';
const String ALERTS_ROUTE = '/alerts';
const String DASHBOARD_FAQ_TPE_ROUTE = '/dashboard-faq-TPE';
const String DASHBOARD_FAQ_ROUTE = '/dashboard-faq';
const String FAQ_POS_TERM_TETRA = '/faq/pos-term-tetra';
const String FAQ_POS_TERM_TELIUM = '/faq/pos-term';
const String FAQ_POS_TERM_SVC_ROUTE = '/faq/pos-term-route';
const String CONTACT_ROUTE = '/contact';
const String SERVICES_ROUTE = '/services';
const String FEEDBACK_ROUTE = '/feedback';
const String FEEDBACK_COMMENT = '/feedback_comment';
const String LEGALS_ROUTE = '/legals';

Map<String, WidgetBuilder> routes() => {
  SPLASH_ROUTE: (context) => SplashScreen(),
  DASHBOARD_ROUTE: (context) => DashboardScreen(),
  ALERTS_ROUTE: (context) => AlertsScreen(),
  DASHBOARD_FAQ_TPE_ROUTE: (context) => DashboardFaqTpeScreen(),
  DASHBOARD_FAQ_ROUTE: (context) => DashboardFaqScreen(),
  FAQ_POS_TERM_TETRA: (context) => FaqTetraScreen(),
  FAQ_POS_TERM_TELIUM: (context) => FaqTeliumScreen(),
  FAQ_POS_TERM_SVC_ROUTE: (context) => FaqServiceScreen(),
  CONTACT_ROUTE: (context) => ContactScreen(),
  SERVICES_ROUTE: (context) => ServicesScreen(),
  FEEDBACK_ROUTE: (context) => FeedbackScreen(pageIndex: 0),
  FEEDBACK_COMMENT: (context) => FeedbackScreen(pageIndex: 1),
  LEGALS_ROUTE: (context) => LegalsScreen(),
};
