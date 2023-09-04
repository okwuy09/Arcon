import 'package:flutter/material.dart';

class CustomColors {

  static const MaterialColor primary = MaterialColor(
    0xFF044B78,
    <int, Color>{
      1: Color(0xFF044B78),
      2: Color(0xFF587FC3),
      3: Color(0xFFE1EDFD)
    },
  );

  static const MaterialColor secondaryPurple = MaterialColor(
    0xFF7465CE,
    <int, Color>{
      1: Color(0xFF7465CE),
      2: Color(0xFF9C8FEA),
      3: Color(0xFFF7F1FF),
      4: Color(0xFFA699F8),
    },
  );

  static const MaterialColor secondaryOrange = MaterialColor(
    0xFFEF8B6E,
    <int, Color>{
      1: Color(0xFFEF8B6E),
      2: Color(0xFFEEB1A0),
      3: Color(0xFFFFF3F0),
      4: Color(0xFFEF8B6E),
      5: Color(0xFFFF6D6D),
    },
  );

  static const MaterialColor secondaryPink = MaterialColor(
    0xFFF497C9,
    <int, Color>{
      1: Color(0xFFF497C9),
      2: Color(0xFFFAC2E0),
      3: Color(0xFFFAF0F5),
      4: Color(0xFFF497C9),
    },
  );

  static const MaterialColor secondaryBlue = MaterialColor(
    0xFF4082F3,
    <int, Color>{
      1: Color(0xFF4082F3),
      2: Color(0xFF99BAF3),
      3: Color(0xFFE1EDFD),
    },
  );

  static const MaterialColor secondaryYellow = MaterialColor(
    0xFFF5B645,
    <int, Color>{
      1: Color(0xFFF5B645),
      2: Color(0xFFFCD692),
      3: Color(0xFFFFF8E7),
    },
  );
  static const MaterialColor secondaryRed = MaterialColor(
    0xFFE6492D,
    <int, Color>{
      1: Color(0xFFE6492D),
    },
  );

  static const MaterialColor info = MaterialColor(
    0xFF3EB8F9,
    <int, Color>{
      1: Color(0xFF3EB8F9)
    },
  );

  static const MaterialColor error = MaterialColor(
    0xFFFB3836,
    <int, Color>{
      1: Color(0xFFFB3836),
      2: Color(0xFFDE0000),
      3: Color(0xFFFFEFEF),
    },
  );

  static const MaterialColor success = MaterialColor(
    0xFF33BB72,
    <int, Color>{
      1: Color(0xFF33BB72),
      2: Color(0xFF00966D),
      3: Color(0xFFF3FCF7),
    },
  );

  static const MaterialColor warning = MaterialColor(
    0xFFF4B740,
    <int, Color>{
      1: Color(0xFFF4B740),
      2: Color(0xFF946200),
      3: Color(0xFFFFD789),
    },
  );

  static const MaterialColor grey = MaterialColor(
    0xFFF4F4F4,
    <int, Color>{
      1: Color(0xFFF4F4F4),
      2: Color(0xFFF7F7FC),
      3: Color(0xFFD2D1D7),
      4: Color(0xFF979797),
      5: Color(0xFF14142B),
      6: Color(0xFF222222),
      7: Color(0xFF9FA2AB)
    },
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF056348),
      Color(0xFF07AC7D)
    ]
  );

  static const LinearGradient greenGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xFF056348),
        Color(0xFFB8EE00),
      ]
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [
      Color(0xFF631298),
      Color(0xFF9144C2)
    ]
  );

  static const LinearGradient blackGradient = LinearGradient(
    colors: [
      Color(0xFF14142B),
      Color(0xFF5F5F5F)
    ]
  );
}