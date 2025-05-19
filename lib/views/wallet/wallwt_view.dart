import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_alert_dialog.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/nodata.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';
import '../../components/generated/assets.dart';
import '../../constant.dart';
import 'widgets/item_wallel.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      if (val.walet == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (val.walet['status'] == false) {
          return Center(child: NoData());
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 165,
                  decoration: BoxDecoration(
                    color: Color(0xff303030),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        Assets.imagesShapesCards,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          Assets.imagesNoiseBackground,
                          fit: BoxFit.fill,
                          height: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${langLocal.langLocal['current_balance']!['${val.languagebox.get("language")}']}",
                                    style: AppTextStyles.style10W500(context)
                                        .copyWith(
                                            color: AppColors.white,
                                            fontFamily: "Lemonada"),
                                  ),
                                  Image.asset(
                                    Assets.imagesGroupCart,
                                    width: 35,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${val.walet['data']['currency']}",
                                      style: AppTextStyles.style12W500(context)
                                          .copyWith(
                                              color: AppColors.white,
                                              fontFamily: "Lemonada"),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${val.walet['data']['wallet'][val.walet['data']['wallet'].length - 2]}${val.walet['data']['wallet'][val.walet['data']['wallet'].length - 1]}.",
                                      style: AppTextStyles.style16W400(context)
                                          .copyWith(
                                              color: AppColors.white,
                                              fontFamily: "Lemonada"),
                                    ),
                                    Text(
                                      "${double.parse(val.walet['data']['wallet']).toInt()}",
                                      style: AppTextStyles.style32W400(context)
                                          .copyWith(
                                              color: AppColors.white,
                                              fontFamily: "Lemonada"),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "${val.namebox.get("name")}",
                                    style: AppTextStyles.style10W500(context)
                                        .copyWith(
                                            color: AppColors.white,
                                            fontFamily: "Lemonada"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                MaterialButton(
                  onPressed: () {
                    val.GetMony();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AppAlertDialog(
                              fun: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  padding: EdgeInsetsDirectional.zero,
                  color: AppColors.greenDark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                          "${langLocal.langLocal['withdraw_request']!['${val.languagebox.get("language")}']}",
                          style: AppTextStyles.style14W400(context).copyWith(
                            color: AppColors.white,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 38,
                        height: 38,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greenWhite),
                        child: Center(
                            child: Icon(
                          Icons.north_east,
                          color: Colors.white,
                          size: 20,
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: val.direction == TextDirection.rtl
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    "${langLocal.langLocal['recent_cash_transactions']!['${val.languagebox.get("language")}']}",
                    style: AppTextStyles.style14W400(context).copyWith(
                      color: AppColors.greenDark,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: val.walet['data']['withdraws'].length,
                    itemBuilder: (context, i) {
                      String updateAt = val.walet['data']['withdraws'][i]
                              ['updated_at'] ??
                          "2000-01-01T00:00:00.000000Z";
                      DateTime dateTime = DateTime.parse(updateAt);
                      return ItemWallet(
                        type: val.walet['data']['withdraws'][i]['status'] ==
                                "pending"
                            ? "${langLocal.langLocal['withdrawalrequest']!['${val.languagebox.get("language")}']} "
                            : val.walet['data']['withdraws'][i]['status'] ==
                                    "rejected"
                                ? "${langLocal.langLocal['Withdrawalrejection']!['${val.languagebox.get("language")}']} "
                                : "${langLocal.langLocal['withdrawalacceptance']!['${val.languagebox.get("language")}']} ",
                        date:
                            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}",
                        price:
                            "${val.walet['data']['withdraws'][i]['amount']}  ${val.walet['data']['currency']}",
                        color: val.walet['data']['withdraws'][i]['status'] ==
                                "pending"
                            ? const Color.fromARGB(255, 151, 151, 8)
                            : val.walet['data']['withdraws'][i]['status'] ==
                                    "rejected"
                                ? const Color.fromARGB(255, 191, 18, 18)
                                : Colors.green,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 16);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }
    });
  }
}
