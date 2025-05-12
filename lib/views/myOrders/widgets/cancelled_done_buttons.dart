import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/views/myOrders/confirm_order_view.dart';

import '../../../constant.dart';
import '../../../constant.dart' as val;

class CancelledDoneButtons extends StatelessWidget {
  const CancelledDoneButtons({super.key,
    required this.onPressedOkFromCancelledDoneOrder,
    required this.id,
    required this.status});

  final Function() onPressedOkFromCancelledDoneOrder;
  final int id;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        AppButton(
        color: AppColors.greenWhite,
        text: "${langLocal.langLocal['confirmReturnRequest']!['${val.languagebox.get(
            "language")}']}",

        fun: ()
    {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ConfirmOrderView(
                  onPressedOkFromConfirmOrder:
                  onPressedOkFromCancelledDoneOrder,
                  id: id,
                  status: status,
                ),
          ));
    },)
    ,
    ]
    ,
    );
  }
}
