import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/custom_success_alert_dialog.dart';
import 'package:hwee_tawseel_driver/components/image.dart';
import 'package:hwee_tawseel_driver/components/nodata.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/auth/auth_view.dart';
import 'package:hwee_tawseel_driver/views/auth/widgets/login.dart';
import 'package:provider/provider.dart';
import '../../components/generated/assets.dart';
import '../../constant.dart';
import '../editProfile/edit_profile_view.dart';
import 'widgets/profile_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      if (val.profile == null) {
        return Center(
              child: CircularProgressIndicator(),
            );
      } else {
        if (val.profile['status'] == false) {
          return Center(child: NoData());
        } else {
          return Directionality(
                  textDirection: val.direction,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Directionality(
                              textDirection: val.direction == TextDirection.rtl ?TextDirection.ltr: TextDirection.rtl ,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(Assets.imagesShap2),
                                    Image.asset(Assets.imagesShap1),
                                  ]),
                            ),
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                        radius: 65,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: ImageView(
                                              image:
                                                  "${val.profile['data']['image']}"),
                                        )),
                                    Positioned(
                                      bottom: 4,
                                      right: 4,
                                      child: Container(
                                        width: 26,
                                        height: 26,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade200),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            Assets.imagesCamera,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                    "${langLocal.langLocal['welcome']!['${val.languagebox.get(
                                        "language")}']}" ,
                                  style: TextStyle(
                                    color: AppColors.greenDark,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${val.profile['data']['first_name']} ${val.profile['data']['last_name']}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        val.inputEdit();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EditProfileView(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade200),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            Assets.imagesEdit,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade200),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12.0),
                                              child: Align(
                                                alignment:val.direction ==TextDirection.rtl?Alignment.centerRight : Alignment.centerLeft,
                                                child: Text(
                                                  "${val.profile['data']['first_name']} ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey.shade200),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12.0),
                                              child: Align(
                                                alignment:val.direction ==TextDirection.rtl?Alignment.centerRight : Alignment.centerLeft,

                                                child: Text(
                                                  "${val.profile['data']['last_name']} ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ]),
                              const SizedBox(height: 8),
                              ProfileItem(
                                label: "${langLocal.langLocal['phoneNumber']!['${val.languagebox.get(
                                    "language")}']}" ,
                                value: "${val.profile['data']['phone']} ",
                              ),
                              ProfileItem(
                                label:  "${langLocal.langLocal['country']!['${val.languagebox.get(
                                    "language")}']}" ,
                                value: "${val.profile['data']['country']} ",
                              ),
                              ProfileItem(
                                label: "${langLocal.langLocal['location']!['${val.languagebox.get(
                                    "language")}']}" ,
                                value:
                                    "${val.profile['data']['city']} - ${val.profile['data']['neighborhood']}",
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  val.LogOut();
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CustomSuccessAlertDialog(
                                            onPressedOk: () {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AuthView()),
                                                (Route<dynamic> route) => false,
                                              );
                                            },
                                          ));
                                },
                                color: AppColors.greyDarker,
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                height: 42,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(120),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      "${langLocal.langLocal['logout']!['${val.languagebox.get(
                                          "language")}']}" ,
                                      style: AppTextStyles.style12W500(context)
                                          .copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                    SvgPicture.asset(Assets.imagesSignOut),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              MaterialButton(
                                onPressed: () {
                                  val.LogOut();
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          CustomSuccessAlertDialog(
                                            onPressedOk: () {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AuthView()),
                                                (Route<dynamic> route) => false,
                                              );
                                            },
                                          ));
                                },
                                color: AppColors.greyDarker,
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                height: 42,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(120),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      "${langLocal.langLocal['deleteaccount']!['${val.languagebox.get(
                                          "language")}']}" ,
                                      style: AppTextStyles.style12W500(context)
                                          .copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                    SvgPicture.asset(Assets.imagesSignOut),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }
      }
    });
  }
}
