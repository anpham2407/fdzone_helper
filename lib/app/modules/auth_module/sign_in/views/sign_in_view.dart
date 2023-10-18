import 'dart:io';

import 'package:fdzone_helper/app/data/models/components/adaptive_button.dart';
import 'package:fdzone_helper/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:fdzone_helper/app/data/service/storage_service.dart';
import 'package:fdzone_helper/app/modules/components/adaptive_back_button.dart';
import 'package:fdzone_helper/app/modules/components/adaptive_icon.dart';
import 'package:fdzone_helper/app/modules/components/error_widget.dart';
import 'package:fdzone_helper/core/utils/fdzone_icons_icons.dart';
import '../components/sign_in_components.dart';
import '../controllers/sign_in_controller.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final tr = AppLocalizations.of(context)!;
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;
    const space = SizedBox(height: 12.0);
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;

    // Since there no app bar, annotated region is used to apply theme ui overlay
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle!,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () {
                            return Align(
                              alignment: isRTL ? Alignment.topRight : Alignment.topLeft,
                              child: Hero(
                                tag: 'closeReset',
                                child: AdaptiveIcon(
                                  iosPadding: const EdgeInsets.all(16.0),
                                  androidPadding: const EdgeInsets.all(16.0),
                                  onPressed: () async => await controller.changeThemeMode(),
                                  icon: Icon(themeIcon(controller.themeMode.value)),
                                ),
                              ),
                            );
                          },
                        ),
                        // Align(
                        //   alignment: isRTL ? Alignment.topLeft : Alignment.topRight,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        //     child: AdaptiveButton(
                        //       onPressed: () async => await showBarModalBottomSheet(
                        //         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        //         context: context,
                        //         builder: (context) => const LanguageSelectionView(),
                        //       ),
                        //       child: Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           const Icon(Icons.language),
                        //           const SizedBox(width: 4.0),
                        //           Text(LanguageService.languageModel.nativeName),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          controller.animate.value = !controller.animate.value;
                        },
                        child: Hero(
                          tag: 'fdzone',
                          child: Image.asset(
                            'assets/images/fdzone.png',
                            scale: 5,
                          ).animate(
                            effects: [const RotateEffect()],
                            target: controller.animate.value ? 1 : 0,
                            autoPlay: false,
                          ),
                        ),
                      );
                    }),
                    // Column(
                    //   children: [
                    //     Text(
                    //       tr.welcome,
                    //       style: Theme.of(context).textTheme.displayLarge,
                    //     ),
                    //     Text(
                    //       tr.greatToSeeYou,
                    //       style: Theme.of(context).textTheme.titleMedium,
                    //     ),
                    //     Text(
                    //       tr.loginBelow,
                    //       style: Theme.of(context).textTheme.titleMedium,
                    //     ),
                    //   ],
                    // ),
                    space,
                    GestureDetector(
                      onTap: () => controller.errorMessage.value = '',
                      child: errorMessage(
                        errorMessage: controller.errorMessage,
                        context: context,
                        emptyChildHeight: 0,
                        horizontalPadding: 12.0,
                      ),
                    ),
                    space,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          Hero(
                              tag: 'email',
                              child: EmailTextField(
                                controller: controller.emailCtrl,
                                validator: (val) {
                                  if (val?.isEmpty ?? true) {
                                    return 'Email is required';
                                  }

                                  if (!val!.isEmail) {
                                    return 'Invalid Email';
                                  }

                                  return null;
                                },
                              )),
                          const SizedBox(height: 12.0),
                          Hero(
                            tag: 'password',
                            child: PasswordTextField(
                              controller: controller.passwordCtrl,
                              validator: (val) {
                                if (val != null && val.isEmpty) {
                                  return 'Password is required';
                                }
                                if (val!.length < 8) {
                                  return 'Password should be at least 8 characters long';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                            width: context.width / 2,
                            child: CheckboxListTile(
                              value: false,
                              onChanged: (val) {},
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                'Remember me',
                                style: smallTextStyle,
                              ),
                            )),
                        Padding(
                          padding: Platform.isAndroid ? const EdgeInsets.symmetric(horizontal: 12.0) : EdgeInsets.zero,
                          child: AdaptiveButton(
                            child: Text(
                              tr.resetPassword,
                            ),
                            onPressed: () {
                              if (controller.errorMessage.value.isNotEmpty) {
                                controller.errorMessage.value = '';
                              }
                              Get.toNamed(Routes.RESET_PASSWORD);
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Hero(
                        tag: 'continue',
                        child: SignInButton(
                          onPressed: () async => await controller.signIn(context),
                          label: tr.cont,
                          buttonWidth: double.maxFinite,
                        ),
                      ),
                    ),
                    space,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: AdaptiveButton(
                        onPressed: () async {
                          await showBarModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const UrlUpdateView();
                              });
                        },
                        child: const Text('Change url'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData themeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return FdZoneIcons.sun;
      case ThemeMode.dark:
        return FdZoneIcons.moon;
    }
  }
}

class UrlUpdateView extends StatefulWidget {
  const UrlUpdateView({super.key});

  @override
  State<UrlUpdateView> createState() => _UrlUpdateViewState();
}

class _UrlUpdateViewState extends State<UrlUpdateView> {
  final formKey = GlobalKey<FormState>();
  final textCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final smallTextStyle = Theme.of(context).textTheme.titleSmall;
    final bottomPadding =
        MediaQuery.of(context).viewPadding.bottom == 0 ? 20.0 : MediaQuery.of(context).viewPadding.bottom;

    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              leading: const AdaptiveBackButton(),
              title: const Text('Update url'),
              actions: [
                TextButton(
                    onLongPress: () async => await StorageService.instance.updateUrl(textCtrl.text).then(
                          (result) {
                            Get.back();
                            if (result) {
                              Get.snackbar('Success', 'Url updated, restart the app');
                            } else {
                              Get.snackbar('Failure', 'Could not update url');
                            }
                          },
                        ),
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      final result = await StorageService.instance.updateUrl(textCtrl.text);
                      if (result) {
                        Get.snackbar('Success', 'Url updated, restart the app');
                      } else {
                        Get.snackbar('Failure', 'Could not update url');
                      }
                      Get.back();
                    },
                    child: const Text('Save'))
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, MediaQuery.of(context).viewInsets.bottom + 8.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      textCtrl.text = StorageService.baseUrl;
                    },
                    child: Text('Current url : ${StorageService.baseUrl}', style: smallTextStyle),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: textCtrl,
                    style: smallTextStyle,
                    decoration: const InputDecoration(hintText: 'https://fdzone.com/admin'),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Field is required';
                      }

                      if (!val.isURL) {
                        return 'Invalid url';
                      }

                      if (!val.contains('admin')) {
                        return 'Url must end with /admin';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: bottomPadding),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
