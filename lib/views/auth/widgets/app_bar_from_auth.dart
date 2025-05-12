import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/app_colors.dart';
import '../../../components/generated/assets.dart';
import '../../../prov/prov.dart';

appBarFromAuth(BuildContext context , {bool isBack = true}) {
  return  AppBar(
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.white,
    elevation: 0,
    leadingWidth: 0,
    leading: SizedBox(),
    title:Consumer<Control>(builder: (context, val, child) {
      return Directionality(
      textDirection: val.direction == TextDirection.rtl
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: isBack,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
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
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            height: 60,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(Assets.imagesLogo),
              ),
            ),
          ),
        ],
      ),
    );})
  );
}
