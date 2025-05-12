import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/dilaogApp.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';

import '../../../components/app_button.dart';
import '../../../components/app_colors.dart';
import '../../../components/app_text_styles.dart';
import '../../../components/generated/assets.dart';
import '../../../constant.dart';
import '../confirm_order_view.dart';

class ConfirmedOrderButtons extends StatelessWidget {
  ConfirmedOrderButtons({
    super.key,
    required this.onPressedOkFromConfirmOrder,
    required this.id,
    required this.status,
  });
  final Function() onPressedOkFromConfirmOrder;

  final int id;
  final String status;
  DialogApp dialogApp = new DialogApp();
  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppButton(
            color: AppColors.greenWhite,
            text: "${langLocal.langLocal['deliverRequest']!['${val.languagebox.get(
                "language")}']}",
            fun: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmOrderView(
                      onPressedOkFromConfirmOrder: onPressedOkFromConfirmOrder,
                      id: id,
                      status: status,
                    ),
                  ));
            },
          ),
          SizedBox(width: 8),
          AppButton(
            text: "${langLocal.langLocal['returnRequest']!['${val.languagebox.get(
                "language")}']}",
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
                                "${langLocal.langLocal['confirmReturnPrompt']!['${val.languagebox.get(
                                    "language")}']}",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.style14W400(context),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              AppButton(
                                text:  "${langLocal.langLocal['ok']!['${val.languagebox.get(
                                    "language")}']}",

                                fun: () {
                                  Navigator.of(context).pop();
                                  val.UpdateOrder(id, "back");
                                  dialogApp.checkdialog(context, () {});
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
