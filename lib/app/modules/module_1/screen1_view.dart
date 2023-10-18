import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'controllers/screen1_controller.dart';

class Screen1TabBarView extends GetView<Screen1Controller> {
  const Screen1TabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      // appBar:
      //     OrdersDraftTabBarAppBar(tabController: tabController, topViewPadding: MediaQuery.of(context).viewPadding.top),
      body: SafeArea(
        child: Text(tr.valueHint, style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
