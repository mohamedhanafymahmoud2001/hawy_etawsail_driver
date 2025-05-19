import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';

import '../../../constant.dart';
import '../../../constant.dart' as val;

class ItemWallet extends StatelessWidget {
  const ItemWallet({
    super.key,
    required this.type,
    required this.date,
    required this.price,
    required this.color,
  });

  final String type;

  final String date;

  final String price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${langLocal.langLocal['transaction_type_label']!['${val.languagebox.get("language")}']}",
                  style: AppTextStyles.style12W700(context),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      type,
                      style: AppTextStyles.style12W700(context).copyWith(
                        color: color,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xffFFDBC8),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    children: [
                      Text(
                        date,
                        style: AppTextStyles.style10W500(context)
                            .copyWith(fontFamily: "Lemonada"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.calendar_month,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${langLocal.langLocal['amount_label']!['${val.languagebox.get("language")}']}",
                  style: AppTextStyles.style12W500(context)
                      .copyWith(color: AppColors.greenDark),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(price, style: AppTextStyles.style12W500(context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
