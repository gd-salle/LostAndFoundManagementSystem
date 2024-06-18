import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/lost_item_form.dart';
import '../screens/found_item_form.dart';
import '../screens/turn_over_form.dart';
import '../screens/register_screen.dart';
import '../screens/announcement_report.dart';
import '../screens/view_report.dart';
import '../models/item.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String reportLostItem = '/report-lost-item';
  static const String reportFoundItem = '/report-fount-item';
  static const String turnOverForm = '/turn-over-form';
  static const String announcementReports = '/announcement-reports';
  static const String viewReport = '/view-report';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => HomeScreen(),
    reportLostItem: (context) => LostItemForm(),
    reportFoundItem: (context) => FoundItemForm(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case announcementReports:
        return MaterialPageRoute(builder: (context) => AnnouncementReports());
      case viewReport:
        final item = settings.arguments as Item;
        return MaterialPageRoute(builder: (context) => ViewReport(item: item));
      case turnOverForm:
        final item = settings.arguments as Item;
        return MaterialPageRoute(builder: (context) => TurnOverForm(item: item));
      default:
        return MaterialPageRoute(builder: (context) => AnnouncementReports());
    }
  }
}
