import 'package:arcon/app.dart';
import 'package:arcon/config/colors.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  final List<CalendarElement> elements;
  const CalendarItem ({Key? key, required this.elements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12)
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: App.screenHeight * 0.025
            ),
            child: Row(
              children: [

                const Expanded(flex: 1, child: SizedBox()),

                Expanded(
                  flex: 25,
                  child: Column(
                    children: elements,
                  ),
                ),

                const Expanded(flex: 1, child: SizedBox()),

              ],
            ),
          ),
        )
      ),
    );
  }
}

class CalendarElement extends StatelessWidget {
  final CalendarElementType type;
  final List<String> content;
  const CalendarElement({
    Key? key,
    this.type = CalendarElementType.lecture,
    this.content = const []
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8)
        ),
        color: getColor(type)
      ),
      padding: EdgeInsets.symmetric(
        vertical: App.screenHeight * 0.017
      ),
      margin: EdgeInsets.only(
        bottom: App.screenHeight * 0.01
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          if(type == CalendarElementType.lectureHeader){
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: text(text: "TIME", maxWidth: maxWidth)
                ),

                Expanded(
                  flex: 3,
                  child: text(text: "SPEAKER", maxWidth: maxWidth)
                ),

                Expanded(
                  flex: 8,
                  child: text(text: "TOPICS", maxWidth: maxWidth)
                ),

                const Expanded(
                  flex: 5,
                  child: SizedBox()
                ),
              ],
            );
          } else if(type == CalendarElementType.lectureHeader2){
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: text(text: "TIME", maxWidth: maxWidth)
                ),

                Expanded(
                  flex: 3,
                  child: text(text: "Chair/Co-Chair/Rapporteur", maxWidth: maxWidth)
                ),

                Expanded(
                  flex: 8,
                  child: text(text: "TOPICS", maxWidth: maxWidth)
                ),

                Expanded(
                  flex: 5,
                  child: text(text: "SPEAKER/SPONSOR", maxWidth: maxWidth)
                ),

              ],
            );
          } else if(type == CalendarElementType.timedEvent){
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: text(text: content[0], maxWidth: maxWidth)
                ),

                Expanded(
                    flex: 14,
                    child: text(text: content[1].toUpperCase(), maxWidth: maxWidth)
                ),

                const Expanded(
                    flex: 2,
                    child: SizedBox()
                ),
              ],
            );
          } else if(type == CalendarElementType.event){
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                    flex: 2,
                    child: SizedBox()
                ),

                Expanded(
                    flex: 14,
                    child: text(text: content[0].toUpperCase(), maxWidth: maxWidth)
                ),

                const Expanded(
                    flex: 2,
                    child: SizedBox()
                ),

              ],
            );
          } else if(type == CalendarElementType.lecture){
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: text(text: content[0], maxWidth: maxWidth)
                ),

                Expanded(
                  flex: 3,
                  child: text(text: content[1], maxWidth: maxWidth)
                ),

                Expanded(
                  flex: 8,
                  child: text(text: content[2], maxWidth: maxWidth)
                ),

                Expanded(
                  flex: 5,
                  child: text(text: content.length > 3 ? content[3] : "", maxWidth: maxWidth)
                ),
              ],
            );
          }


          return const SizedBox();
        },
      ),
    );
  }

  Widget text({required String text, required double maxWidth}){
    return Row(
      children: [
        const Expanded(flex: 1, child: SizedBox()),

        Expanded(
          flex: 18,
          child: Center(
            child: CustomText(
                text,
                style: TextStyle(
                    fontFamily: "TomatoGrotesk",
                    fontSize: App.screenHeight * 0.1 * 0.14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                    color: CustomColors.grey[5]
                ),
                maxLines: 100,
                textAlign: TextAlign.center,
            ),
          ),
        ),

        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }

  Color getColor (CalendarElementType type){
    switch (type) {
      case CalendarElementType.lecture:
        return CustomColors.success.withOpacity(0.7);
      case CalendarElementType.event:
        return CustomColors.secondaryPurple.withOpacity(0.7);
      case CalendarElementType.timedEvent:
        return CustomColors.secondaryOrange.withOpacity(0.7);
      case CalendarElementType.lectureHeader:
        return CustomColors.secondaryYellow.withOpacity(0.7);
      case CalendarElementType.lectureHeader2:
        return CustomColors.secondaryYellow.withOpacity(0.7);
    }
  }
}

enum CalendarElementType {lecture, event, timedEvent, lectureHeader, lectureHeader2}

