import 'package:arcon/pages/onboarding/view/reset_password/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:arcon/app.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:arcon/config/config.dart';
import 'package:arcon/controllers/controllers.dart';
import 'package:arcon/pages/shared/shared.dart';

import 'sign_in.dart';
import 'sign_up.dart';

class Onboarding extends StatelessWidget {
  final String pageName;

  Onboarding({Key? key, required this.pageName}) : super(key: key){
    Get.put(OnboardingController());
  }

  final images = [
    "a",
    "b",
  ];

  final texts = [
    'We strive to set and promote ethical and scientific standards in the study'
        ' of cancer awareness around our environment',
    'Birth ideas on developing a robust and competent cancer-free health care'
        ' system in Nigeria and international bodies',
  ];

  final pages = [
    "sign_up",
    "sign_in",
    "forgot_password",
  ];

  @override
  Widget build(BuildContext context) {

    final CarouselController carouselController = CarouselController();
    final controller = Get.find<OnboardingController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: App.screenHeight,
              child: Builder(
                  builder: (context) {
                    return Row(
                      children: [

                        Expanded(
                          child: LoadingWrapper(
                            child: IndexedStack(
                              index: pages.indexOf(Get.currentRoute.split('/').last),
                              children: [
                                SignUp(),
                                SignIn(),
                                const ResetPassword(),
                              ],
                            ),
                          ),
                        ),

                        Builder(
                            builder: (context) {
                              if(ResponsiveWidget.isLargeScreen(maxWidth: maxWidth)
                                  || ResponsiveWidget.isMediumScreen(maxWidth: maxWidth)){
                                return Expanded(
                                    child: Container(
                                      height: App.screenHeight,
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimen.horizontalMarginWidth * 1.5,
                                          vertical: App.screenHeight * 0.05
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color(0xFF044B78).withOpacity(0.2),
                                                  offset: const Offset(13, 18),
                                                  blurRadius: 24
                                              )
                                            ],
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(24)
                                            ),
                                            color: Colors.white
                                        ),
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              return Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  SizedBox(
                                                      width: constraints.maxWidth,
                                                      height: double.infinity,
                                                      child: ClipRRect(
                                                        borderRadius: const BorderRadius.all(
                                                            Radius.circular(24)
                                                        ),
                                                        child: CarouselSlider.builder(
                                                            carouselController: carouselController,
                                                            itemCount: images.length,
                                                            itemBuilder: (context, index, int2) {
                                                              return Column(
                                                                children: [
                                                                  Container(
                                                                    height: App.screenHeight * 0.65,
                                                                    width: Dimen.width,
                                                                    decoration: const BoxDecoration(
                                                                      borderRadius: BorderRadius.all(
                                                                          Radius.circular(24)
                                                                      ),
                                                                      color: Colors.white,
                                                                    ),
                                                                    child: ClipRRect(
                                                                      borderRadius: const BorderRadius.all(
                                                                          Radius.circular(24)
                                                                      ),
                                                                      child: Image.asset(
                                                                        'assets/images/${images[index]}.jpg',
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  SizedBox(
                                                                    height: (Dimen.verticalMarginHeight * 2) + 10,
                                                                  ),

                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: Dimen.horizontalMarginWidth * 1.5,
                                                                        vertical: Dimen.verticalMarginHeight
                                                                    ),
                                                                    child: CustomText(
                                                                      texts[index],
                                                                      style: TextStyles(
                                                                        color: CustomColors.grey[5],
                                                                      ).textBodyExtraLarge,
                                                                      maxLines: 10,
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  )

                                                                ],
                                                              );
                                                            },
                                                            options: CarouselOptions(
                                                                height: App.screenHeight,
                                                                disableCenter: true,
                                                                initialPage: 0,
                                                                enableInfiniteScroll: true,
                                                                autoPlay: true,
                                                                autoPlayInterval: const Duration(seconds: 5),
                                                                viewportFraction: 1,
                                                                onPageChanged: (index, reason){
                                                                  controller.changeActiveIndex(index);
                                                                }
                                                            )
                                                        ),
                                                      )
                                                  ),


                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [

                                                      SizedBox(
                                                        height: App.screenHeight * 0.65,
                                                      ),

                                                      SizedBox(height: Dimen.verticalMarginHeight * 1.25),

                                                      SizedBox(
                                                        height: 10,
                                                        child: Center(
                                                          child: GetX<OnboardingController>(
                                                              builder: (controller) {
                                                                return buildIndicator(controller.activeIndex);
                                                              }
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(height: Dimen.verticalMarginHeight * 1.25),

                                                      const Expanded(child: SizedBox()),
                                                    ],
                                                  )

                                                ],
                                              );
                                            }
                                        ),
                                      ),
                                    )
                                );
                              } else {
                                return const SizedBox();
                              }
                            }
                        ),
                      ],
                    );
                  }
              ),
            ),
          ),
        );
      }
    );
  }

  Widget buildIndicator(int activeIndex) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: images.length,
      duration: const Duration(milliseconds: 500),
      effect: WormEffect(
          dotColor: CustomColors.primary,
          activeDotColor: CustomColors.primary[2]!,
          spacing: 12,
          dotHeight: 10,
          dotWidth: 10,
          radius: 20
      ),
    );
  }
}
