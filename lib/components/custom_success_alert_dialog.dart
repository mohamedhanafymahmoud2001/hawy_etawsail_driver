import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/constant.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';
import '../prov/langlocal.dart';
import 'app_button.dart';
import 'app_text_styles.dart';
import 'generated/assets.dart';

class CustomSuccessAlertDialog extends StatefulWidget {
  final Function() onPressedOk;
  const CustomSuccessAlertDialog({
    super.key,
    required this.onPressedOk,
  });

  @override
  State<CustomSuccessAlertDialog> createState() =>
      _CustomSuccessAlertDialogState();
}

class _CustomSuccessAlertDialogState extends State<CustomSuccessAlertDialog> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void showConfetti() {
    _confettiController.play();
  }

  LangLocal langLocal = new LangLocal();
  @override
  Widget build(BuildContext context) {
    showConfetti();
    return Consumer<Control>(builder: (context, val, child) {
      if (val.data == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Directionality(
          textDirection: val.direction,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                val.data['status'] == true
                    ? "assets/images/success.png"
                    : "assets/images/error.png",
                width: 60,
              ),
            ),
            titlePadding: const EdgeInsets.all(16),
            content: SizedBox(
              height: 120,
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  val.data['status'] == true
                      ? ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirectionality: BlastDirectionality.explosive,
                          shouldLoop: false,
                          colors: [
                            Colors.red,
                            Colors.blue,
                            Colors.green,
                            Colors.yellow,
                            Colors.orange
                          ],
                        )
                      : SizedBox(),
                  Text(
                    val.data['message'].toString(),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.style14W400(context),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  AppButton(
                    text:
                        "${langLocal.langLocal['ok']!['${val.languagebox.get("language")}']}",
                    fun:
                        //  val.data['status'] == true
                        //     ?
                        widget.onPressedOk
                    // :
                    // () {}
                    ,
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
