import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'controllers/screen2_controller.dart';

class Screen2TabBarView extends GetView<Screen2Controller> {
  const Screen2TabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      // appBar:
      //     OrdersDraftTabBarAppBar(tabController: tabController, topViewPadding: MediaQuery.of(context).viewPadding.top),
      body: SafeArea(
        child: Text(tr.welcome, style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
