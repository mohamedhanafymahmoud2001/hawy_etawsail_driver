import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_alert_dialog.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/custom_success_alert_dialog.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/components/image.dart';
import 'package:hwee_tawseel_driver/components/nodata.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/auth/widgets/app_bar_from_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../prov/langlocal.dart';

class EditDataView extends StatefulWidget {
  const EditDataView({super.key});

  @override
  State<EditDataView> createState() => _EditDataView();
}

class _EditDataView extends State<EditDataView> {
  LangLocal langLocal = new LangLocal();

  Widget _buildUploadCard(
      String title, VoidCallback fun, File? image, String imagelink) {
    return Consumer<Control>(builder: (context, val, child) {
      return val.profile == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : val.profile['status'] == false
              ? Center(child: NoData())
              : Container(
                  width: 260,
                  height: 230,
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
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.style14W400(context).copyWith(
                            color: AppColors.border,
                            fontFamily: 'Noto Kufi Arabic',
                          ),
                        ),
                        Spacer(),
                        image != null
                            ? Container(
                                width: 260,
                                height: 125,
                                child: Image.file(image),
                              )
                            : Container(
                                width: 260,
                                height: 125,
                                child: ImageView(
                                    image: "${val.api.ip}/$imagelink")),
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
                );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: appBarFromAuth(context),
        body: val.profile == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : val.profile['status'] == false
                ? Center(child: NoData())
                : SingleChildScrollView(
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
                                Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 1, color: Colors.grey.shade200),
                                  ),
                                  child: val.user_image == null
                                      ? val.profile == null
                                          ? Icon(
                                              Icons.person_2_outlined,
                                              color: Colors.grey,
                                            )
                                          : val.profile['data']['image'] == null
                                              ? Icon(
                                                  Icons.person_2_outlined,
                                                  color: Colors.grey,
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: ImageView(
                                                      image:
                                                          "${val.api.ip}/${val.profile['data']['image']}")

                                                  //  Image.network(
                                                  //   "${val.api.ip}/${val.profile['data']['image']}",
                                                  //   fit: BoxFit.cover,
                                                  // )

                                                  )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.file(
                                            val.user_image!,
                                            fit: BoxFit.cover,
                                          )),
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
                                      onTap: val.upload_User_image,
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
                          val.uploadlicense_image();
                        }, val.license_image,
                            val.profile['data']['license_image']),
                        _buildUploadCard(
                            "${langLocal.langLocal['enterDriverLicenseImage']!['${val.languagebox.get("language")}']}",
                            () {
                          val.uploadlicense_self_image();
                        }, val.license_self_image,
                            val.profile['data']['license_self_image']),
                        _buildUploadCard(
                            "${langLocal.langLocal['enterNationalIdImage']!['${val.languagebox.get("language")}']}",
                            () {
                          val.uploadcard_image();
                        }, val.card_image, val.profile['data']['card_image']),
                        SizedBox(height: 20),
                        AppButton(
                          text:     "${langLocal.langLocal['next']!['${val.languagebox.get("language")}']}",

                          fun: () {
                            val.EditProfile();

                            showDialog(
                                context: context,
                                builder: (context) => CustomSuccessAlertDialog(
                                      onPressedOk: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    )
                                // AppAlertDialog(fun: () {
                                //   Navigator.of(context).pop();
                                //   Navigator.of(context).pop();
                                // }),
                                );
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
