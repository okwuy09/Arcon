import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/config.dart';
import 'controllers/controllers.dart';
import 'pages/shared/shared.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  static double get screenHeight {
    if(Constants.screenHeight.toDouble() < Dimen.height){
      return Dimen.height;
    } else {
      return Constants.screenHeight.toDouble();
    }
  }

  static void startLoading() => Get.find<UserController>().startLoading();

  static void stopLoading() => Get.find<UserController>().stopLoading();
}

class _AppState extends State<App> {

  @override
  void initState() {
    Get.put(UserController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CustomText.referenceSize = Constants.largeScreenSize;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "TomatoGrotesk",
          primaryColor: CustomColors.primary,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: CustomColors.primary,
            selectionColor: CustomColors.primary[2],
            selectionHandleColor: CustomColors.primary,
          ),
          scrollbarTheme: ScrollbarThemeData(
            thumbVisibility: MaterialStateProperty.all<bool>(true),
            thickness: MaterialStateProperty.all<double>(4),
            radius: const Radius.circular(4),
          )
      ),
      title: "Arcon",
      getPages: CustomRouter.pages,
      scrollBehavior: CustomScrollBehavior(),
      initialRoute: splashScreenRoute,
      locale: const Locale('en', ''),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}