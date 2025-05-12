import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/constant.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../prov/langlocal.dart';

class DialogApp {
  ColorsApp colorsApp = ColorsApp();
  LangLocal langLocal = new LangLocal();

  Future<void> checkdialog(BuildContext context, VoidCallback func) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        // استخدام سياق جديد
        return Consumer<Control>(
          builder: (context, val, child) {
            return Directionality(
              textDirection: val.direction,
              child: AlertDialog(
                backgroundColor: Colors.white,
                shadowColor: Colors.white,
                scrollable: true,
                elevation: 10,
                content: val.data == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [CircularProgressIndicator()],
                      )
                    : Container(
                        padding: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset(
                                val.data['status'] == true
                                    ? "assets/images/success.png"
                                    : "assets/images/error.png",
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              alignment: Alignment.center,
                              child: Text(
                                textAlign: TextAlign.center,
                                val.data['status'] == true
                                    ?     "${langLocal.langLocal['operationSuccess']!['${val.languagebox.get("language")}']}"
                                    :    "${langLocal.langLocal['operationFailed']!['${val.languagebox.get("language")}']}",

                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                height: 1,
                                color: Colors.grey.shade300,
                                thickness: 2,
                                endIndent: 70,
                                indent: 70,
                              ),
                            ),
                          ],
                        ),
                      ),
                actions: <Widget>[
                  Center(
                    child: val.data == null
                        ? const SizedBox()
                        : Column(
                            children: [
                              AppButton(
                                text:
                                    "${langLocal.langLocal['ok']!['${val.languagebox.get("language")}']}",
                                fun: val.data['status'] == true
                                    ? () {
                                        // تأخير تنفيذ `func` لضمان استقرار `context`
                                        Future.microtask(() {
                                          if (context.mounted) {
                                            func();
                                          }
                                        });
                                      }
                                    : () {
                                        if (Navigator.canPop(context)) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> Notificat(BuildContext context, VoidCallback func) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<Control>(builder: (context, val, child) {
          return val.oneNotificat == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.white,
                    scrollable: true,
                    titleTextStyle:
                        TextStyle(fontSize: 20, color: Colors.black),
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("assets/images/logo.png"),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                val.oneNotificat['data']["title"],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        val.oneNotificat['data']["is_read"] == 0
                            ? Icon(
                                Icons.circle,
                                size: 10,
                                color: Colors.blue,
                              )
                            : SizedBox(),
                      ],
                    ),
                    elevation: 10,
                    content: Text(
                      textAlign: TextAlign.center,
                      val.oneNotificat['data']["description"],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    actions: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: AppButton(
                          text:
                              "${langLocal.langLocal['ok']!['${val.languagebox.get("language")}']}",
                          fun: func,
                        ),
                      ),
                    ],
                  ),
                );
        });
      },
    );
  }
}
