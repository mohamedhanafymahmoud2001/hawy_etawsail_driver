import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/custom_success_alert_dialog.dart';
import 'package:hwee_tawseel_driver/components/dilaogApp.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class ReservedOrderButtons extends StatelessWidget {
  ReservedOrderButtons(
      {super.key, required this.onPressedOk, required this.id});

  final Function() onPressedOk;
  final int id;

  DialogApp dialogApp = new DialogApp();

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppButton(
            color: AppColors.greenWhite,
            text:
                "${langLocal.langLocal['confirmOrder']!['${val.languagebox.get("language")}']}",
            fun: () {
              val.UpdateOrder(id, "receiveOrder");
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSuccessAlertDialog(
                    onPressedOk: () {
                      Navigator.of(context).pop();
                      onPressedOk();
                    },
                  );
                },
              );
            },
          ),
          SizedBox(width: 8),
          AppButton(
            color: AppColors.greenDark,
            text:
                "${langLocal.langLocal['cancelOrderBooking']!['${val.languagebox.get("language")}']}",
            fun: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              Assets.imagesError,
                              width: 20,
                            ),
                          ),
                        ),
                        titlePadding: EdgeInsetsDirectional.all(16),
                        content: SizedBox(
                          height: 120,
                          width: 300,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${langLocal.langLocal['confirmCancelOrderBooking']!['${val.languagebox.get("language")}']}",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.style14W400(context),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              AppButton(
                                text:
                                    "${langLocal.langLocal['ok']!['${val.languagebox.get("language")}']}",
                                fun: () {
                                  Navigator.of(context).pop();
                                  val.CancelOrder(id);
                                },
                              )
                            ],
                          ),
                        ),
                      ));
            },
          ),
        ],
      );
    });
  }
}
