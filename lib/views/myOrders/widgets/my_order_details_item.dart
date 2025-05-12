import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';

class MyOrderDetailsItem extends StatelessWidget {
  const MyOrderDetailsItem({
    super.key,
    required this.title,
    required this.value,
    this.isWhite = true,
    this.isCall = false,
  });

  final bool isWhite;
  final bool isCall;

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        color: isWhite ? AppColors.white : Color(0xffF1F1F1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.style12W500(context).copyWith(
                fontFamily: "Noto Kufi Arabic",
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  textAlign: TextAlign.end,
                  value,
                  style: AppTextStyles.style10W500(context).copyWith(
                    fontFamily: "Noto Kufi Arabic",
                  ),
                ),
              ),
            ),
            isCall == true
                ? Container(
                    margin: EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: () {
                          val.call(value);
                        },
                        child: Icon(
                          Icons.call_outlined,
                          color: Colors.black,
                        )),
                  )
                : SizedBox()
          ],
        ),
      );
    });
  }
}
