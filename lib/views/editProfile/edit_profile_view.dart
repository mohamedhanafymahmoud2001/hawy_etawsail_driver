import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_form_filed.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/auth/location_view.dart';
import 'package:hwee_tawseel_driver/views/auth/widgets/app_bar_from_auth.dart';
import 'package:hwee_tawseel_driver/views/editProfile/edit_data.dart';
import 'package:hwee_tawseel_driver/views/editProfile/edit_location_view.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../prov/langlocal.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Control>(context, listen: false).getPosition();
    });
    super.initState();
  }

  final GlobalKey<FormState> formState = GlobalKey();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  LangLocal langLocal = new LangLocal();
  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarFromAuth(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formState,
              child: Column(
                spacing: 16,
                children: [
                   Text(
                    "${langLocal.langLocal['editProfile']!['${val.languagebox.get("language")}']}",

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [   Expanded(
                      child: AppInputTextFormField(
                        controller: val.api.fname,
                        labelText: "${langLocal.langLocal['firstName']!['${val.languagebox.get("language")}']}"
                        ,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";
                            ;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _autovalidateMode = AutovalidateMode.disabled;
                          });
                        },
                      ),
                    ),

                      SizedBox(width: 8),
                      Expanded(
                        child: AppInputTextFormField(
                          controller: val.api.lname,
                          labelText:    "${langLocal.langLocal['lastName']!['${val.languagebox.get("language")}']}",

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return    "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _autovalidateMode = AutovalidateMode.disabled;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  AppInputTextFormField(
                    controller: val.api.phone,
                    labelText: "${langLocal.langLocal['phoneNumber']!['${val.languagebox.get("language")}']}"
                    ,
                    keyboardType: TextInputType.phone,
                    suffixIcon: Icon(Icons.phone_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";

                      }

                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _autovalidateMode = AutovalidateMode.disabled;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      val.getPosition();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyLocation(),
                        ),
                      );
                    },
                    child: Consumer<Control>(builder: (context, val, child) {
                      return Directionality(
                        textDirection: val.direction == TextDirection.rtl
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        child: Container(
                          // height: 56,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.border,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                          ),
                          child: Row(children: [
                            Image.asset(
                              Assets.imagesGoogleMaps,
                              width: 16,
                              height: 16,
                            ),
                            // Spacer(),
                            Expanded(
                              child: Container(
                                child: Text(
                                  textAlign: TextAlign.end,
                                  val.city == ""
                                      ? "${langLocal.langLocal['location']!['${val.languagebox.get("language")}']}"
                                      : "${val.city} - ${val.neighbor} ",
                                  style: AppTextStyles.style12W700(context).copyWith(
                                      color: AppColors.border,
                                      fontFamily: "Noto Kufi Arabic"),
                                ),
                              ),
                            ),
                          ]),
                        ),);})
                  ),
                  AppPassInputTextFormField(
                    controller: val.api.current_password,
                    labelText: "${langLocal.langLocal['currentPassword']!['${val.languagebox.get("language")}']}",
                    validator: (value) {
                      if (value!.trim().isEmpty &&
                          (val.api.password.text.trim().isNotEmpty ||
                              val.api.confirmPassword.text.trim().isNotEmpty)) {
                        return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";

                      }

                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _autovalidateMode = AutovalidateMode.onUserInteraction;
                      });
                    },
                  ),
                  AppPassInputTextFormField(
                    controller: val.api.password,
                    labelText: "${langLocal.langLocal['enterNewPassword']!['${val.languagebox.get("language")}']}",
                    validator: (value) {
                      if (value!.trim().isEmpty &&
                          (val.api.current_password.text.trim().isNotEmpty ||
                              val.api.confirmPassword.text.trim().isNotEmpty)) {
                        return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";

                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _autovalidateMode = AutovalidateMode.onUserInteraction;
                      });
                    },
                  ),
                  AppPassInputTextFormField(
                    controller: val.api.confirmPassword,
                    labelText:"${langLocal.langLocal['confirmPassword']!['${val.languagebox.get("language")}']}",
                    validator: (value) {
                      if (value!.trim().isEmpty &&
                          (val.api.password.text.trim().isNotEmpty ||
                              val.api.current_password.text
                                  .trim()
                                  .isNotEmpty)) {
                        return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";

                      }
                      if (value.trim().isNotEmpty &&
                          value != val.api.password.text) {
                        return "${langLocal.langLocal['passwordMismatch']!['${val.languagebox.get("language")}']}";

                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _autovalidateMode = AutovalidateMode.onUserInteraction;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  AppButton(
                      text:
                          "${langLocal.langLocal['next']!['${val.languagebox.get("language")}']}",
                      fun: () {
                        if (formState.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditDataView(),
                            ),
                          );
                        }
                      }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
