import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../prov/langlocal.dart';
import 'generated/assets.dart';
import 'app_button.dart';
import 'app_text_styles.dart';

class AppAlertDialog extends StatelessWidget {
  AppAlertDialog({
    super.key,
    required this.fun,
  });

  final VoidCallback fun;
  LangLocal langLocal = new LangLocal();

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      if (val.data == null) {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      } else {
        return Directionality(
          textDirection: val.direction,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                val.data['status'] == true
                    ? Assets.imagesSuccess
                    : Assets.imagesError,
                width: 60,
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
                    // val.data['status'] == true
                    // ?
                    // title :
                    val.data['message'],
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.style14W400(context),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AppButton(
                    text:
                        "${langLocal.langLocal['ok']!['${val.languagebox.get("language")}']}",
                    fun: val.data['status'] == true
                        ? fun
                        : () {
                            Navigator.pop(context);
                          },
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
