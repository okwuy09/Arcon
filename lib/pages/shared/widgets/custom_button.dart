import 'package:flutter/material.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/pages/shared/widgets/widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final String? icon;
  final double? iconSize;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.color,
    this.textColor,
    this.borderColor,
    this.margin,
    this.padding,
    this.icon,
    this.iconSize,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height ?? Constants.screenHeight * 0.07,
      width: width ?? Dimen.width * 0.9,
      decoration: BoxDecoration(
        color: color ?? CustomColors.primary,
        borderRadius: const BorderRadius.all(
            Radius.circular(12)
        ),
        border: borderColor != color ? Border.all(
          color: borderColor ?? color ?? CustomColors.primary,
          width: 1,
        ) : null
      ),
      margin: margin ?? EdgeInsets.zero,
      child: MaterialButton(
        height: height ?? Constants.screenHeight * 0.07,
        minWidth: width ?? Dimen.width * 0.9,
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(12)
          ),
        ),
        elevation: 0,
        onPressed: onPressed,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const Expanded(child: SizedBox()),

                  CustomText(
                      text,
                      style: TextStyles(
                          color: textColor ?? Colors.white
                      ).textBodyLarge
                  ),

                  if(icon != null)
                    SizedBox(width: Dimen.horizontalMarginWidth * 0.5),

                  if(icon != null)
                    SVG(
                      icon!,
                      height: iconSize ?? 24,
                      width: iconSize ?? 24,
                      color: textColor ?? Colors.white,
                      semanticsLabel: ""
                    ),

                  const Expanded(child: SizedBox()),

                ],
              )
          ),
        ),
      ),
    );
  }
}
