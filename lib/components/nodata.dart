import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/constant.dart';
import 'package:provider/provider.dart';

import '../constant.dart' as val;
import '../prov/prov.dart';

class NoData extends StatelessWidget {
  ColorsApp colorsApp = new ColorsApp();
  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Directionality(
      textDirection: val.direction,
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: colorsApp.colorgreen2.withOpacity(0.1),
                ),
                Container(
                    height: 136, child: Image.asset("assets/images/nodata.png")),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                textAlign: TextAlign.center,
                "${langLocal.langLocal['noData']!['${val.languagebox.get("language")}']}",

                style: TextStyle(
                    fontFamily: "Cairo",
                    color: colorsApp.colorgreen2,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );});
  }
}
