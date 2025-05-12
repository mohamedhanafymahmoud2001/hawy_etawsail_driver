import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_form_filed.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/constant.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/auth/location_view.dart';
import 'package:hwee_tawseel_driver/views/auth/register_view.dart';
import 'package:provider/provider.dart';

import '../../../components/app_text_styles.dart';
import '../../../prov/langlocal.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formState = GlobalKey();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  LangLocal langLocal = new LangLocal();

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Form(
        key: formState,
        autovalidateMode: _autovalidateMode,
        child: Column(
          children: [
            Text(
              "${langLocal.langLocal['introText']!['${val.languagebox.get("language")}']}",
              style: AppTextStyles.style16W400(context),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppInputTextFormField(
                    controller: val.api.fname,
                    labelText:
                        "${langLocal.langLocal['firstName']!['${val.languagebox.get("language")}']}",
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
                ),
                SizedBox(width: 8),
                Expanded(
                  child: AppInputTextFormField(
                    controller: val.api.lname,
                    labelText:
                        "${langLocal.langLocal['lastName']!['${val.languagebox.get("language")}']}",
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
                ),
              ],
            ),
            SizedBox(height: 16),
            AppInputTextFormField(
              controller: val.api.phone,
              labelText:
                  "${langLocal.langLocal['phoneNumber']!['${val.languagebox.get("language")}']}",
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
            SizedBox(height: 16),
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
              child:Consumer<Control>(builder: (context, val, child) {
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
                ),
              );})
            ),
            SizedBox(height: 16),
            AppPassInputTextFormField(
              controller: val.api.password,
              labelText:
                  "${langLocal.langLocal['password']!['${val.languagebox.get("language")}']}",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";
                } else if (value.length < 6) {
                  return "${langLocal.langLocal['passwordValidation']!['${val.languagebox.get("language")}']}";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _autovalidateMode = AutovalidateMode.disabled;
                });
              },
            ),
            SizedBox(height: 16),
            AppPassInputTextFormField(
              controller: val.api.confirmPassword,
              labelText:
                  "${langLocal.langLocal['confirmPassword']!['${val.languagebox.get("language")}']}",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";
                } else if (value != val.api.password.text) {
                  return "${langLocal.langLocal['passwordMismatch']!['${val.languagebox.get("language")}']}";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _autovalidateMode = AutovalidateMode.disabled;
                });
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 30,
            ),
            AppButton(
              text:
                  "${langLocal.langLocal['next']!['${val.languagebox.get("language")}']}",
              fun: () {
                if (formState.currentState!.validate()) {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.always;
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterView()));
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
