import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_alert_dialog.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/bottomSheetApp.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/auth/widgets/app_bar_from_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../prov/langlocal.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  LangLocal langLocal = new LangLocal();
  BottomSheetApp bottomSheetApp = BottomSheetApp();

  Widget _buildUploadCard(String title, VoidCallback fun, File? image) {
    return Consumer<Control>(builder: (context, val, child) {
      return InkWell(
        onTap: fun,
        child: Container(
          width: 260,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: image != null
                ? Container(
                    width: 260,
                    height: 160,
                    child: Image.file(image),
                  )
                : Column(
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.style14W400(context).copyWith(
                          color: AppColors.border,
                          fontFamily: 'Noto Kufi Arabic',
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        Assets.imagesPhoto,
                        width: 32,
                        height: 32,
                      ),
                      TextButton(
                        onPressed: fun,
                        child: Text(
                          "${langLocal.langLocal['insertImageHere']!['${val.languagebox.get("language")}']}",
                          style: AppTextStyles.style12W500(context).copyWith(
                            color: AppColors.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: appBarFromAuth(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Assets.imagesShap1,
                      ),
                      Image.asset(
                        Assets.imagesShap2,
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Color(0xffEDEDED),
                        backgroundImage: val.user_image != null
                            ? FileImage(val.user_image as dynamic)
                            : null,
                        child: val.user_image == null
                            ? Icon(Icons.person_outlined,
                                color: AppColors.black, size: 40)
                            : null,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.white,
                          border: Border.all(
                            width: 1,
                            color: AppColors.border,
                          ),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              // val.upload_User_image();

                              bottomSheetApp.showPicker(context, "profile");
                            },
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildUploadCard(
                  "${langLocal.langLocal['enterCarLicenseImage']!['${val.languagebox.get("language")}']}",
                  () {
                // val.uploadlicense_image();
                bottomSheetApp.showPicker(context, "license");
              }, val.license_image),
              _buildUploadCard(
                  "${langLocal.langLocal['enterDriverLicenseImage']!['${val.languagebox.get("language")}']}",
                  () {
                // val.uploadlicense_self_image();

                bottomSheetApp.showPicker(context, "license_self");
              }, val.license_self_image),
              _buildUploadCard(
                  "${langLocal.langLocal['enterNationalIdImage']!['${val.languagebox.get("language")}']}",
                  () {
                // val.uploadcard_image();

                bottomSheetApp.showPicker(context, "card");
              }, val.card_image),
              SizedBox(height: 20),
              AppButton(
                text:
                    "${langLocal.langLocal['next']!['${val.languagebox.get("language")}']}",
                fun: () {
                  if (val.card_image != null &&
                      val.user_image != null &&
                      val.license_image != null &&
                      val.license_self_image != null) {
                    val.Register();
                    showDialog(
                      context: context,
                      builder: (context) => AppAlertDialog(fun: () {
                        Navigator.of(context).pushNamed("VerfiCode");
                      }),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${langLocal.langLocal['completeData']!['${val.languagebox.get("language")}']}",
                        ),
                        duration: Duration(seconds: 1), // تختفي بعد 3 ثوانٍ
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
  }
}
