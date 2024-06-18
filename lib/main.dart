import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost and Found Management System',
      theme: appTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        _CustomNavigatorObserver(),
      ],
    );
  }
}

class _CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    // Ensure the back stack remains empty
    if (previousRoute != null) {
      Navigator.of(route.navigator!.context).popUntil((route) => false);
    }
  }
}
