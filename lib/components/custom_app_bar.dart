import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/components/image.dart';
import '../constant.dart' as val;
import '../prov/langlocal.dart';
import 'app_colors.dart';

AppBar customAppBar(BuildContext context, String name, String image) {
  LangLocal langLocal = new LangLocal();
  return AppBar(
    leadingWidth: 0,
    leading: SizedBox(),
    elevation: 0,
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.white,
    title: Directionality(
      textDirection: val.direction,
      child: Row(
        spacing: 8,
        children: [
          // Container(
          //   height: 48,
          //   padding: EdgeInsets.only(
          //       right: val.direction == TextDirection.rtl ? 2 : 24,
          //       left: val.direction == TextDirection.rtl ? 24 : 2),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(50),
          //     border: Border.all(
          //       width: 1,
          //       color: AppColors.greenWhite,
          //     ),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Container(
          //           width: 44,
          //           height: 44,
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //           ),
          //           child: ClipRRect(
          //               borderRadius: BorderRadius.circular(50),
          //               child: ImageView(image: image))
          //
          //           //Image.asset(Assets.imagesTest1),
          //           ),
          //       SizedBox(width: 8),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //       "${langLocal.langLocal['hello']!['${val.languagebox.get("language")}']}",
          //
          //             style: AppTextStyles.style10W500(context).copyWith(
          //               color: AppColors.greenWhite,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 4,
          //           ),
          //           Text("${name}", style: AppTextStyles.style10W500(context)),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
           Spacer(),
          // Container(
          //   width: 40,
          //   height: 40,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Color(0xFFF9F9F9),
          //   ),
          //   child: IconButton(
          //     onPressed: () {
          //      // val.shwatchLanguage();
          //     },
          //     icon: Center(
          //         child: Text(
          //           "${val.languagebox.get("language")}",
          //           style: AppTextStyles.style10W500(context),
          //         )),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF9F9F9),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
