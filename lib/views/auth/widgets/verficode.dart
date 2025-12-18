import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_alert_dialog.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_form_filed.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/auth/auth_view.dart';
import 'package:hwee_tawseel_driver/views/auth/forget_password_view.dart';
import 'package:hwee_tawseel_driver/views/auth/widgets/app_bar_from_auth.dart';
import 'package:hwee_tawseel_driver/views/auth/widgets/pinput.dart';
import 'package:provider/provider.dart';
import '../../../prov/langlocal.dart';

class VerfiCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerfiCode();
  }
}

class _VerfiCode extends State<VerfiCode> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LangLocal langLocal = new LangLocal();

  @override
  Widget build(BuildContext context) {
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
                  "${langLocal.langLocal['activateAccount']!['${val.languagebox.get("language")}']}",
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
                            Text(
                                "${langLocal.langLocal['confirmationSent']!['${val.languagebox.get("language")}']}",
                                style: AppTextStyles.style12W500(context)),
                            const SizedBox(height: 24),
                            PinInputStyles.buildPinInput(
                              onCompleted: (pin) {
                                //  print("User entered PIN: $pin");
                              },
                            ),
                            SizedBox(height: 12),
                            TextButton(
                              onPressed: () {},
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
                        ),
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                        text:
                            "${langLocal.langLocal['next']!['${val.languagebox.get("language")}']}",
                        fun: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            val.Verfy();
                            showDialog(
                              context: context,
                              builder: (context) => AppAlertDialog(
                                fun: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => AuthView()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            );
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
  }
}
