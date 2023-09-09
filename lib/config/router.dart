import 'package:arcon/pages/home/home.dart';
import 'package:arcon/pages/onboarding/onboarding.dart';
import 'package:arcon/pages/register/register.dart';
import 'package:arcon/pages/show_qr/show_qr.dart';
import 'package:arcon/pages/calendar/calendar.dart';
import 'package:arcon/pages/show_user_data/show_user_data.dart';
import 'package:arcon/pages/splash_screen/splash_screen.dart';

import 'package:get/get.dart';

class CustomRouter {

  static List<GetPage> get pages =>
      [
        GetPage(name: splashScreenRoute,
            page: () => const SplashScreen(),
            transition: Transition.fadeIn),
        GetPage(name: onboardingRoute,
            page: () => Onboarding(pageName: 'sign_up'),
            transition: Transition.fadeIn),
        GetPage(name: homeRoute,
            page: () => Home(),
            transition: Transition.fadeIn),
        GetPage(name: registrationRoute,
            page: () => Register(),
            transition: Transition.fadeIn),
        GetPage(name: calendarRoute,
            page: () => const Calendar(),
            transition: Transition.fadeIn),
        GetPage(name: qrRoute,
            page: () => const ShowQr(),
            transition: Transition.fadeIn),
        GetPage(name: userDataRoute,
            page: () => const ShowUserData(),
            transition: Transition.fadeIn),
      ];
}

const splashScreenRoute = "/";
const onboardingRoute = "/onboarding/:pageName";
const signInRoute = "/onboarding/sign_in";
const signUpRoute = "/onboarding/sign_up";
const forgotPasswordRoute = "/onboarding/forgot_password";
const homeRoute = "/home";
const registrationRoute = "/register";
const calendarRoute = "/calendar";
const qrRoute = "/qr";
const userDataRoute = "/user_data";