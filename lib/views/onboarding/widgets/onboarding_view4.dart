import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/onboarding/onboarding_view.dart';
import 'package:hwee_tawseel_driver/views/onboarding/widgets/onboarding_view2.dart';
import 'package:hwee_tawseel_driver/views/onboarding/widgets/onboarding_view5.dart';
import 'package:provider/provider.dart';

import 'button_of_onboarding.dart';

class OnboardingView4 extends StatelessWidget {
  const OnboardingView4({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 1,
                          color: AppColors.border,
                        ),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      Assets.imagesOnboardingBackground2,
                    ),
                  ),
                ),
                SizedBox(
                  width: 330,
                  child: Image.asset(
                    Assets.imagesOnboarding4,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "حدد اللغة المناسبة لك",
              textAlign: TextAlign.center,
              style: AppTextStyles.style32W400(context).copyWith(
                fontFamily: "VEXA",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 16,
            ),
            MaterialButton(
              elevation: 0,
              onPressed: () {
                val.choseLangouge("ar");
              },
              color: AppColors.white,
              minWidth: 260,
              height: 48,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: val.lang == "ar"
                    ? BorderSide(color: Colors.black)
                    : BorderSide(color: AppColors.border),
              ),
              child: Text(
                "اللغة العربية",
                style: AppTextStyles.style16W400(context).copyWith(
                  fontFamily: "VEXA L",
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            MaterialButton(
              elevation: 0,
              onPressed: () {
                val.choseLangouge("en");
              },
              color: AppColors.white,
              minWidth: 260,
              height: 48,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: val.lang == "en"
                    ? BorderSide(color: Colors.black)
                    : BorderSide(color: AppColors.border),
              ),
              child: Text(
                "English",
                style: AppTextStyles.style16W400(context).copyWith(
                  fontFamily: "VEXA L",
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      width: 24,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.greenDark,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.greenWhite,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.greenWhite,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.greenWhite,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.greenWhite,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ]),
                  OnboardingButton(
                    backgroundColor: AppColors.greenDark,
                    titleColor: AppColors.white,
                    title: "التالي",
                    onPressed: () {
                      if (val.lang != "") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingView1(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("اختر اللغة"),
                            duration: Duration(seconds: 1), // تختفي بعد 3 ثوانٍ
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            )
          ],
        ),
      );
    });
  }
}
