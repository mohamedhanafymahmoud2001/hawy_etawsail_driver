import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/views/onboarding/widgets/onboarding_view2.dart';

import '../../constant.dart';
import '../../constant.dart' as val;
import 'widgets/button_of_onboarding.dart';
import 'widgets/onboarding_view4.dart';

class OnboardingView1 extends StatelessWidget {
  const OnboardingView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenDark,
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingView4(),
                        ),
                      );
                    },
                    child: Container(
                      width: 64,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.greenWhite,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(
                        child: Text("${langLocal.langLocal['skip']!['${val.languagebox.get(
                            "language")}']}" ,
                            style: AppTextStyles.style12W500(context).copyWith(
                                color: AppColors.white, fontFamily: "VEXA")),
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
                height: MediaQuery.of(context).size.height / 2.1,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    Assets.imagesOnboardingBackground1,
                  ),
                ),
              ),
              SizedBox(
                width: 310,
                child: Image.asset(
                  Assets.imagesOnboarding1,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
    "${langLocal.langLocal['onBoardingTitle1']!['${val.languagebox.get(
    "language")}']}" ,
            textAlign: TextAlign.center,
            style: AppTextStyles.style32W400(context).copyWith(
              color: AppColors.white,
              fontFamily: "VEXA",
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.0),
            child: Text("${langLocal.langLocal['onBoarding1']!['${val.languagebox.get(
                "language")}']}" ,
          textAlign: TextAlign.center,
              style: AppTextStyles.style22W400(context)
                  .copyWith(color: AppColors.white, fontFamily: "VEXA L"),
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
                    width: 24,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.white,
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
                  backgroundColor: AppColors.white,
                  titleColor: AppColors.greenDark,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingView2(),
                      ),
                    );
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
  }
}
