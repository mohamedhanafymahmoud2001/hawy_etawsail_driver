import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/custom_app_bar.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/components/image.dart';
import 'package:hwee_tawseel_driver/components/nodata.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/myOrders/widgets/home_order_buttons.dart';
import 'package:hwee_tawseel_driver/views/myOrders/widgets/reserved_order_buttons.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import 'widgets/cancelled_done_buttons.dart';
import 'widgets/confirmed_order_buttons.dart';
import 'widgets/my_order_details_item.dart';

class MyOrderDetails extends StatelessWidget {
  const MyOrderDetails({
    super.key,
    this.reservedOrders = false,
    this.confirmedOrders = false,
    this.homeOrders = false,
    this.cancelledDoneOrders = false,
    required this.onPressedOk,
    required this.onPressedOkFromConfirmOrder,
    required this.onPressedOkFromCancelledDoneOrder,
    required this.onPressedHomeButtonDetails,
  });

  final bool reservedOrders;
  final bool confirmedOrders;
  final bool homeOrders;

  final bool cancelledDoneOrders;
  final Function() onPressedOkFromCancelledDoneOrder;
  final Function() onPressedOk;
  final Function() onPressedOkFromConfirmOrder;
  final Function() onPressedHomeButtonDetails;

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Directionality(
        textDirection: val.direction,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: customAppBar(context, val.namebox.get("name"),
              "${val.api.ip}/${val.imagebox.get('image')}"),
          body: val.orderDetails == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : val.orderDetails['status'] == false
                  ? Center(
                      child: NoData(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 12),
                            // SizedBox(height: 20),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed("MapDetails");
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        child: Image.asset(
                                            "assets/images/map.webp")),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 90,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.pin_drop_outlined,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 120,
                                            ),
                                            Icon(
                                              Icons.pin_drop_outlined,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 60,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.grey.withOpacity(0.6),
                                          ),
                                          child: Text(
                                            "${langLocal.langLocal['map']!['${val.languagebox.get("language")}']}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            // Text(
                            //   "${val.orderDetails['data']['order']['product_name']}",
                            //   style:
                            //       AppTextStyles.style16W600(context).copyWith(
                            //     color: AppColors.greenWhite,
                            //   ),
                            // ),
                            // ImageView(
                            //   image:
                            //       "${val.api.ip}/${val.orderDetails['data']['order']['image']}",
                            // ),
                            SizedBox(height: 8),
                            MyOrderDetailsItem(
                              title:
                                  "${langLocal.langLocal['numorder']!['${val.languagebox.get("language")}']}",
                              value: val.orderDetails['data']['order']
                                  ['orderNumber'],
                              isWhite: false,
                            ),
                            // Container(
                            //   width: double.infinity,
                            //   padding: const EdgeInsets.all(16.0),
                            //   color: Colors.white,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         "${langLocal.langLocal['productDescription']!['${val.languagebox.get("language")}']}",
                            //         style: AppTextStyles.style12W500(context)
                            //             .copyWith(
                            //           fontFamily: "Noto Kufi Arabic",
                            //           color: AppColors.greyDarker,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 16,
                            //       ),
                            //       Text(
                            //           "${val.orderDetails['data']['order']['description']}",
                            //           style:
                            //               AppTextStyles.style10W500(context)),
                            //     ],
                            //   ),
                            // ),
                            MyOrderDetailsItem(
                              title:
                                  "${langLocal.langLocal['packaging']!['${val.languagebox.get("language")}']}",
                              value: val.orderDetails['data']['order']
                                          ['cover'] ==
                                      "cover"
                                  ? "${langLocal.langLocal['packaged']!['${val.languagebox.get("language")}']}"
                                  : "${langLocal.langLocal['notPackaged']!['${val.languagebox.get("language")}']}",
                              isWhite: false,
                            ),
                            MyOrderDetailsItem(
                              title:
                                  "${langLocal.langLocal['fragility']!['${val.languagebox.get("language")}']}",
                              value: val.orderDetails['data']['order']
                                          ['break'] ==
                                      "cover"
                                  ? "${langLocal.langLocal['fragile']!['${val.languagebox.get("language")}']}"
                                  : "${langLocal.langLocal['notFragile']!['${val.languagebox.get("language")}']}",
                            ),
                            MyOrderDetailsItem(
                              title:
                                  "${langLocal.langLocal['packageWeight']!['${val.languagebox.get("language")}']}",
                              value:
                                  "${val.orderDetails['data']['order']['weight']} kg",
                              isWhite: false,
                            ),
                            MyOrderDetailsItem(
                              title:
                                  "${langLocal.langLocal['departurePoint']!['${val.languagebox.get("language")}']}",
                              value:
                                  "${val.orderDetails['data']['order']['city_sender']}${val.orderDetails['data']['order']['neighborhood_sender']} ${val.orderDetails['data']['order']['area_street_sender']} ${val.orderDetails['data']['order']['build_number_sender']}",
                            ),
                            MyOrderDetailsItem(
                              title:
                                  "${langLocal.langLocal['senderName']!['${val.languagebox.get("language")}']}",
                              value:
                                  "${val.orderDetails['data']['order']['name_sender']}",
                              isWhite: false,
                            ),
                            MyOrderDetailsItem(
                              title:
                                  "${langLocal.langLocal['senderPhone']!['${val.languagebox.get("language")}']}",
                              value:
                                  "${val.orderDetails['data']['order']['phone_sender']}",
                              isCall: true,
                            ),
                            MyOrderDetailsItem(
                              title:
                                  "${langLocal.langLocal['deliveryPoint']!['${val.languagebox.get("language")}']}",
                              value:
                                  "${val.orderDetails['data']['order']['city_receiver']} ${val.orderDetails['data']['order']['neighborhood_receiver']} ${val.orderDetails['data']['order']['area_street_receiver']} ${val.orderDetails['data']['order']['build_number_receiver']}",
                              isWhite: false,
                            ),
                            MyOrderDetailsItem(
                              title:
                                  "${langLocal.langLocal['recipientName']!['${val.languagebox.get("language")}']}",
                              value:
                                  "${val.orderDetails['data']['order']['name_receiver']}",
                            ),
                            MyOrderDetailsItem(
                                title:
                                    "${langLocal.langLocal['recipientPhone']!['${val.languagebox.get("language")}']}",
                                value:
                                    "${val.orderDetails['data']['order']['phone_receiver']}",
                                isWhite: false,
                                isCall: true),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${langLocal.langLocal['cost']!['${val.languagebox.get("language")}']}",
                                        style:
                                            AppTextStyles.style12W500(context)
                                                .copyWith(
                                          fontFamily: "Noto Kufi Arabic",
                                          color: AppColors.greyDarker,
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                        "${val.orderDetails['data']['order']['totalPrice']} ${val.orderDetails['data']['currency']}",
                                        style:
                                            AppTextStyles.style12W500(context)
                                                .copyWith(
                                          fontFamily: "Noto Kufi Arabic",
                                          color: AppColors.greyDarker,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Text(
                                        "${langLocal.langLocal['packagingService']!['${val.languagebox.get("language")}']}",
                                        style:
                                            AppTextStyles.style10W500(context),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${val.orderDetails['data']['order']['coverPrice']} ${val.orderDetails['data']['currency']}",
                                        style:
                                            AppTextStyles.style10W500(context),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 24,
                                      ),
                                      Text(
                                        "${langLocal.langLocal['deliveryService']!['${val.languagebox.get("language")}']}",
                                        style:
                                            AppTextStyles.style10W500(context),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${val.orderDetails['data']['order']['basePrice']} ${val.orderDetails['data']['currency']}",
                                        style:
                                            AppTextStyles.style10W500(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20),
                            Visibility(
                              visible: confirmedOrders,
                              child: ConfirmedOrderButtons(
                                onPressedOkFromConfirmOrder:
                                    onPressedOkFromConfirmOrder,
                                id: val.orderDetails['data']['order']['id'],
                                status: val.orderDetails['data']['order']
                                    ['status'],
                              ),
                            ),
                            Visibility(
                              visible: reservedOrders,
                              child: ReservedOrderButtons(
                                onPressedOk: onPressedOk,
                                id: val.orderDetails['data']['order']['id'],
                              ),
                            ),
                            Visibility(
                              visible: cancelledDoneOrders,
                              child: CancelledDoneButtons(
                                onPressedOkFromCancelledDoneOrder:
                                    onPressedOkFromCancelledDoneOrder,
                                id: val.orderDetails['data']['order']['id'],
                                status: val.orderDetails['data']['order']
                                    ['status'],
                              ),
                            ),
                            Visibility(
                              visible: homeOrders,
                              child: HomeOrderButtons(
                                  homeButtonOnPressed:
                                      onPressedHomeButtonDetails,
                                  id: val.orderDetails['data']['order']['id']),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
        ),
      );
    });
  }
}

//date

// showDatePicker(
  //   context: context,
  //   initialDate: DateTime.now(),
  //   firstDate: DateTime.now(),
  //   lastDate: DateTime(2050),
  // ).then((value) {
  //   if (value != null) {
  //     val.date = value.toString();
  //     val.date = Jiffy.parse('${val.date}').yMd;
  //     val.changedatepationt();
  //   }
  // });

  //time 

  // showTimePicker(
  //   initialTime: TimeOfDay.now(),
  //   context: context,
  // ).then((value) {
  //   if (value != null) {
  //     val.chosestarttime(
  //         value.format(context).toString());

  //     print(val.timestartnew);
  //   }
  // });