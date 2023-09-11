import 'dart:async';

import 'package:arcon/app.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class EventCountdown extends StatefulWidget {
  const EventCountdown({Key? key}) : super(key: key);

  @override
  State<EventCountdown> createState() => _EventCountdownState();
}

class _EventCountdownState extends State<EventCountdown> {
  Duration duration = Duration(
      seconds: DateTime(2023, 09, 11, 09, 00, 0, 0, 0).difference(DateTime.now()).inSeconds
  );

  Timer timer = Timer(const Duration(seconds: 1), () {});

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateDuration());
  }
  
  void stopTimer() {
    timer.cancel();
  }

  void updateDuration() {
    final int seconds;

    seconds = duration.inSeconds - 1;

    if (seconds < 0) {
      timer.cancel();
    } else {
      if(mounted){
        setState(() {
          duration = Duration(seconds: seconds);
        });
      }
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds);

    if(duration.inMilliseconds.isNegative){
      dateTime = DateTime(2023, 09, 00, 00, 00, 0, 0, 0);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        return Row(
          children: [
            timeWidget("DAYS", duration.inMilliseconds.isNegative ? "0" : dateTime.day.toString(), maxWidth),

            const Expanded(child: SizedBox()),

            colon(maxWidth),

            const Expanded(child: SizedBox()),

            timeWidget("HOURS", dateTime.hour.toString(), maxWidth),

            const Expanded(child: SizedBox()),

            colon(maxWidth),

            const Expanded(child: SizedBox()),

            timeWidget("MINUTES", dateTime.minute.toString(), maxWidth),

            const Expanded(child: SizedBox()),

            colon(maxWidth),

            const Expanded(child: SizedBox()),

            timeWidget("SECONDS", dateTime.second.toString(), maxWidth),

          ],
        );
      }
    );
  }

  Widget timeWidget(String identifier, String value, double maxWidth) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
              Radius.circular(12)
          ),
          child: Shimmer(
            child: Container(
                height: ResponsiveWidget.isExtraSmallScreen()
                    ? App.screenHeight * .10 : ResponsiveWidget.isSmallScreen()
                    ? App.screenHeight * .13 : ResponsiveWidget.isMediumScreen()
                    ? App.screenHeight * .18 : App.screenHeight * .21,
                width: maxWidth * 0.18,
                decoration: BoxDecoration(
                    color: CustomColors.grey[3]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12)
                )
            ),
          ),
        ),

        Column(
          children: [
            CustomText(
                value,
                style: TextStyle(
                    fontFamily: "TomatoGroteskBold",
                    fontSize: maxWidth * 0.18 * 0.375,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.3,
                    color: CustomColors.grey[5]
                )
            ),

            SizedBox(height: Dimen.verticalMarginHeight * 0.25),

            CustomText(
                identifier,
                style: TextStyle(
                    fontFamily: "TomatoGroteskBold",
                    fontSize: maxWidth * 0.18 * 0.135,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                    color: CustomColors.grey[5]
                )
            ),
          ],
        )
      ],
    );
  }

  Widget colon(double maxWidth) {
    return CustomText(
        ":",
        style: TextStyle(
            fontFamily: "TomatoGroteskBold",
            fontSize: maxWidth * 0.18 * 0.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.3,
            color: CustomColors.grey[5]
        )
    );
  }
}
