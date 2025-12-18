import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_form_filed.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/custom_app_bar.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/auth/widgets/pinput.dart';
import 'package:provider/provider.dart';
import '../../components/custom_success_alert_dialog.dart';
import '../../constant.dart';

class ConfirmOrderView extends StatelessWidget {
  ConfirmOrderView(
      {super.key,
      required this.onPressedOkFromConfirmOrder,
      required this.id,
      required this.status});

  final Function() onPressedOkFromConfirmOrder;
  final int id;
  final String status;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: customAppBar(context, val.namebox.get("name"),
            "${val.imagebox.get('image')}"),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.1,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  Assets.imagesOnboardingBackground2,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  Text(
                    "${langLocal.langLocal['confirmDelivery']!['${val.languagebox.get("language")}']}",
                    style: AppTextStyles.style22W400(context)
                        .copyWith(fontFamily: "VEXA"),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Text(
                    "${langLocal.langLocal['enterOrderConfirmationCode']!['${val.languagebox.get("language")}']}",
                    style: AppTextStyles.style12W500(context),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  PinInputStyles.buildPinInput(
                    length: 4,
                    onCompleted: (pin) {
                      // print("User entered PIN: $pin");
                    },
                  ),
                  SizedBox(height: 42),
                  AppButton(
                    text:
                        "${langLocal.langLocal['ok']!['${val.languagebox.get("language")}']}",
                    fun: () {
                      if (formKey.currentState!.validate()) {
                        status == "finished"
                            ? val.UpdateOrder(id, "$status")
                            : val.UpdateOrder(id, "$status");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomSuccessAlertDialog(
                              onPressedOk: () {
                                status == "finished"
                                    ? val.GetOrderByStatus("$status")
                                    : val.GetOrderByStatus("$status");
                                Navigator.of(context).pop();
                                onPressedOkFromConfirmOrder();
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
