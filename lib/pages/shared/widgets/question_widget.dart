import 'package:arcon/config/config.dart';
import 'package:arcon/pages/shared/shared.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final String selectedValue;
  final bool hasError;
  final List<String> values;
  final void Function(String? value) onValueChanged;
  final bool splitColumn;
  const QuestionWidget({Key? key, required this.question, required this.selectedValue,
    required this.hasError, required this.values, required this.onValueChanged, this.splitColumn = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = List.generate(
        values.length,
        (index) {
          return SizedBox(
            height: 45,
            child: MaterialButton(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(12)
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: Dimen.horizontalMarginWidth,
                vertical: Dimen.verticalMarginHeight * 0.25
              ),
              onPressed: () {
                onValueChanged(values[index]);
              },
              child: Row(
                children: [

                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: hasError && selectedValue == "" ? CustomColors.error
                              : values[index] == selectedValue ? CustomColors.primary
                              : CustomColors.grey[5]!
                        )
                    ),
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: values[index] == selectedValue ? CustomColors.primary
                            : Colors.transparent,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),

                  SizedBox(width: Dimen.horizontalMarginWidth),

                  CustomText(
                    values[index],
                    style: TextStyles(
                        color: CustomColors.grey[5]
                    ).textSubtitleLarge,
                  ),
                ],
              ),
            ),
          );
        }
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          question,
          style: TextStyles(
              color: CustomColors.grey[5]
          ).textSubtitleLarge,
          maxLines: 4,
          textAlign: TextAlign.start,
        ),

        SizedBox(height: Dimen.verticalMarginHeight * 0.15),

        Builder(
          builder: (context) {
            if(splitColumn) {
              int evenLength = 0;
              int oddLength = 0;

              for(int i = 0; i < values.length; i++){
                if(i.isEven) evenLength++;
                if(i.isOdd) oddLength++;
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: List.generate(
                          evenLength,
                          (index) {
                            return children[index * 2];
                          }),
                    )
                  ),

                  Expanded(
                    child: Column(
                      children: List.generate(
                          oddLength,
                          (index) {
                            return children[(index * 2) + 1];
                          }),
                    )
                  )
                ],
              );
            }

            return Column(
              children: children,
            );
          }
        ),
      ],
    );
  }
}
