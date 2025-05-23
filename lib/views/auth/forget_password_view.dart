import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_form_filed.dart';
import 'package:hwee_tawseel_driver/components/app_alert_dialog.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/auth/auth_view.dart';
import 'package:provider/provider.dart';

import '../../../components/app_colors.dart';
import '../../../components/app_text_styles.dart';
import '../../prov/langlocal.dart';
import 'widgets/app_bar_from_auth.dart';
import 'widgets/pinput.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  // int step =
  //     1; // To track the steps (1: Enter Email, 2: Enter Code, 3: Change Password)

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LangLocal langLocal = new LangLocal();

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Consumer<Control>(builder: (context, val, child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: appBarFromAuth(context),
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "${langLocal.langLocal['resetPasswordTitle']!['${val.languagebox.get("language")}']}",
                    style: AppTextStyles.style16W400(context)
                        .copyWith(color: AppColors.accentColor),
                  ),
                  const SizedBox(height: 5),
                  Divider(
                    indent: 150,
                    endIndent: 150,
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (val.step == 1) ...[
                                Text(
                                    "${langLocal.langLocal['enterPhoneNumber']!['${val.languagebox.get("language")}']}",
                                    style: AppTextStyles.style12W500(context)),
                                const SizedBox(height: 24),
                                AppInputTextFormField(
                                  labelText:
                                      "${langLocal.langLocal['phoneNumber']!['${val.languagebox.get("language")}']}",
                                  suffixIcon: Icon(Icons.phone_outlined),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";
                                    }
                                  },
                                  controller: val.api.phone,
                                ),
                              ],
                              if (val.step == 2) ...[
                                Text(
                                    "${langLocal.langLocal['confirmationSent2']!['${val.languagebox.get("language")}']}",
                                    style: AppTextStyles.style12W500(context)),
                                const SizedBox(height: 24),
                                PinInputStyles.buildPinInput(
                                  onCompleted: (pin) {
                                    //  print("User entered PIN: $pin");
                                  },
                                ),
                                SizedBox(height: 12),
                                TextButton(
                                  onPressed: () {
                                    val.PhoneReset();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const ForgetPasswordView(),
                                    //   ),
                                    // );
                                  },
                                  child: Text(
                                      "${langLocal.langLocal['resendCode']!['${val.languagebox.get("language")}']}",
                                      style: AppTextStyles.style10W700(context)
                                          .copyWith(
                                        color: AppColors.accentColor,
                                        fontFamily: "Noto Kufi Arabic",
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.accentColor,
                                      )),
                                ),
                              ],
                              if (val.step == 3) ...[
                                Text(
                                    "${langLocal.langLocal['enterNewPassword']!['${val.languagebox.get("language")}']}",
                                    style: AppTextStyles.style12W500(context)),
                                const SizedBox(height: 24),
                                AppPassInputTextFormField(
                                  labelText:
                                      "${langLocal.langLocal['password']!['${val.languagebox.get("language")}']}",
                                  controller: val.api.passwordReset,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";
                                    }
                                  },
                                ),
                                const SizedBox(height: 24),
                                AppPassInputTextFormField(
                                  labelText:
                                      "${langLocal.langLocal['password']!['${val.languagebox.get("language")}']}",
                                  controller:
                                      val.api.password_confirmationReset,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";
                                    }
                                    if (value != val.api.passwordReset.text) {
                                      return "${langLocal.langLocal['passwordMismatch']!['${val.languagebox.get("language")}']}";
                                    }
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        AppButton(
                          text:
                              "${langLocal.langLocal['next']!['${val.languagebox.get("language")}']}",
                          fun: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              setState(() {
                                if (val.step == 1) {
                                  val.PhoneReset();
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AppAlertDialog(fun: () {
                                      Navigator.of(context).pop();
                                      val.changeresetpass(2);
                                    }),
                                  );
                                } else if (val.step == 2) {
                                  val.Verfy();
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AppAlertDialog(fun: () {
                                      Navigator.of(context).pop();
                                      val.changeresetpass(3);
                                    }),
                                  );
                                } else {
                                  val.PassReset();
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AppAlertDialog(fun: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => AuthView()),
                                        (Route<dynamic> route) => false,
                                      );
                                    }),
                                  );
                                }
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
