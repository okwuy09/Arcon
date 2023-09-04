import 'package:arcon/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:arcon/controllers/controllers.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;
  final double size;

  const LoadingWrapper({required this.child, this.size = 80.0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,

        GetX<UserController>(
            builder: (controller) {
              if (controller.isLoading) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.grey[6]!.withOpacity(0.25),
                      ),
                    ),

                    SpinKitWaveSpinner(
                      color: CustomColors.primary,
                      size: size,
                    ),

                  ],
                );
              }else{
                return const SizedBox();
              }
            }
        ),
      ],
    );
  }
}
