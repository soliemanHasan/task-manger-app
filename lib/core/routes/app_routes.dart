// import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:task_manger_app/modules/auth/presentation/routes/login_route.dart';

import '../../modules/home/presentation/routes/items_pagination_route.dart';

/// The [AppRoutes] class defines a static router instance of the GoRouter class,
/// which is a routing solution commonly used in Flutter applications
/// It manages the navigation flow between different screens or pages.
/// The routes parameter specifies the available routes in the application.
/// By commenting out the class, you disable the routing functionality,
/// making it impossible to navigate between screens/pages.
///
/// defaine Route class
/// EX: class FeatureRoute {
///  static const String name = '/route';
///  static GoRoute route = GoRoute(
///    path: name,
///    builder: (context, state) => FeaturesScreen(),
///  );
/// }

class AppRoutes {
  static final router = GoRouter(
    initialLocation: ItemsPaginationRoute.name,
    routes: [
      LoginRoute.route,
      ItemsPaginationRoute.route,
    ],
  );
}
