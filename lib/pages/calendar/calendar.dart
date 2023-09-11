import 'package:arcon/app.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: App.screenHeight,
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 1,
              maxScale: 2,
              child: SizedBox(
                height: App.screenHeight,
                width: constraints.maxWidth,
                child: FittedBox(
                  child: Image.asset(
                    "assets/images/arcon_calendar.png",
                    height: App.screenHeight,
                    width: constraints.maxWidth,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
