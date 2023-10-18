import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:fdzone_helper/app/data/service/initial_binding.dart';
import 'app/data/service/storage_service.dart';
import 'app/routes/app_pages.dart';
import 'core/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "FDZone Helper",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      themeMode: StorageService.instance.loadThemeMode(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    );
  }
}

Future<void> initServices() async {
  debugPrint('starting services ...');
  await Get.putAsync(() => StorageService().init());
  debugPrint('All services started...');
}
