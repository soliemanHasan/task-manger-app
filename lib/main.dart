
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manger_app/core/routes/app_routes.dart';
import 'package:task_manger_app/core/services/cache_storage_services.dart';
import 'package:task_manger_app/core/services/service_locator.dart';
import 'package:task_manger_app/core/themes/app_theme.dart';
import 'package:task_manger_app/core/translations/app_local.dart';

import 'generated/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheStorageServices.init();
  ServicesLocator().init();
  await EasyLocalization.ensureInitialized();
  

  // set up easy_localization lib
  runApp(
    EasyLocalization(
      supportedLocales: AppLocale().supportedLocaless,
      fallbackLocale: AppLocale().english,
      path: 'resources/langs',
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
 // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (context, child) {
          return MaterialApp.router(
            theme: AppTheme().lightTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Base project v2',
            routerConfig: AppRoutes.router,
          );
        });
  }
}

