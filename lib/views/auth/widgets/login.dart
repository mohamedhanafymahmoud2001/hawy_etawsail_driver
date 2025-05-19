import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_alert_dialog.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_form_filed.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/prov/langlocal.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/main/main_view.dart';
import 'package:provider/provider.dart';

import '../forget_password_view.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  LangLocal langLocal = new LangLocal();

  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Form(
        key: _formKey,
        autovalidateMode: _autovalidateMode,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12),
              Text(
                "${langLocal.langLocal['introText']!['${val.languagebox.get("language")}']}",
                style: AppTextStyles.style16W400(context),
              ),
              SizedBox(height: 20),
              AppInputTextFormField(
                controller: val.api.phoneSignin,
                labelText:
                    "${langLocal.langLocal['phoneNumber']!['${val.languagebox.get("language")}']}",
                keyboardType: TextInputType.phone,
                suffixIcon: Icon(Icons.phone_outlined),
                onChanged: (value) {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.disabled;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";
                  }
                  // else if (value.length != 11) {
                  //   return "${langLocal.langLocal['phoneValidation']!['${val.languagebox.get("language")}']}";
                  // }
                  return null;
                },
              ),
              SizedBox(height: 16),
              AppPassInputTextFormField(
                controller: val.api.passSignin,
                labelText:
                    "${langLocal.langLocal['password']!['${val.languagebox.get("language")}']}",
                onChanged: (value) {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.disabled;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "${langLocal.langLocal['requiredField']!['${val.languagebox.get("language")}']}";
                  } else if (value.length < 6) {
                    return "${langLocal.langLocal['passwordValidation']!['${val.languagebox.get("language")}']}";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPasswordView(),
                    ),
                  );
                },
                child: Text(
                    "${langLocal.langLocal['forgotPassword']!['${val.languagebox.get("language")}']}",
                    style: AppTextStyles.style10W700(context).copyWith(
                      color: AppColors.accentColor,

                      /// The button to navigate to the forget password view
                      fontFamily: "Noto Kufi Arabic",
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.accentColor,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              AppButton(
                text:
                    "${langLocal.langLocal['login']!['${val.languagebox.get("language")}']}",
                fun: () {
                  if (_formKey.currentState!.validate()) {
                    val.Login();
                    print("hai");
                    _autovalidateMode = AutovalidateMode.always;
                    showDialog(
                      context: context,
                      builder: (context) => AppAlertDialog(fun: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => MainView()),

                          /// The button to submit the form
                          (Route<dynamic> route) => false,
                        );
                      }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
