import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/custom_app_bar.dart';
import 'package:hwee_tawseel_driver/components/nodata.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import 'my_order_details.dart';
import 'widgets/my_order_button.dart';
import 'widgets/my_order_item.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Directionality(
        textDirection: val.direction,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8,
                children: [
                  SizedBox(width: 8),
                  MyOrderButton(
                    color: val.changeMyOrder == "bookOrder"
                        ? AppColors.orange
                        : null,
                    textColor: val.changeMyOrder == "bookOrder"
                        ? AppColors.white
                        : null,
                    onPressed: () {
                      val.GetOrderByStatus("bookOrder");
                    },
                    text:
                        "${langLocal.langLocal['reservedOrders']!['${val.languagebox.get("language")}']}",
                  ),
                  MyOrderButton(
                    color: val.changeMyOrder == "receiveOrder"
                        ? AppColors.orange
                        : null,
                    textColor: val.changeMyOrder == "receiveOrder"
                        ? AppColors.white
                        : null,
                    onPressed: () {
                      val.GetOrderByStatus("receiveOrder");
                    },
                    text:
                        "${langLocal.langLocal['receivedOrders']!['${val.languagebox.get("language")}']}",
                  ),
                  MyOrderButton(
                    color: val.changeMyOrder == "finished"
                        ? AppColors.orange
                        : null,
                    textColor: val.changeMyOrder == "finished"
                        ? AppColors.white
                        : null,
                    onPressed: () {
                      val.GetOrderByStatus("finished");
                    },
                    text:
                        "${langLocal.langLocal['deliveredOrders']!['${val.languagebox.get("language")}']}",
                  ),
                  MyOrderButton(
                    color:
                        val.changeMyOrder == "back" ? AppColors.orange : null,
                    textColor:
                        val.changeMyOrder == "back" ? AppColors.white : null,
                    onPressed: () {
                      val.GetOrderByStatus("back");
                    },
                    text:
                        "${langLocal.langLocal['returnedOrders']!['${val.languagebox.get("language")}']}",
                  ),
                  MyOrderButton(
                    color: val.changeMyOrder == "finishedBack"
                        ? AppColors.orange
                        : null,
                    textColor: val.changeMyOrder == "finishedBack"
                        ? AppColors.white
                        : null,
                    onPressed: () {
                      val.GetOrderByStatus("finishedBack");
                    },
                    text:
                        "${langLocal.langLocal['rejectedOrders']!['${val.languagebox.get("language")}']}",
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
            val.getOrderByStatus == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : val.getOrderByStatus['status'] == false ||
                        (val.getOrderByStatus['data']['order'] as List).isEmpty
                    ? Container(height: 500, child: Center(child: NoData()))
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8,
                          ),
                          child: ListView.separated(
                            itemCount:
                                val.getOrderByStatus['data']['order'].length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  val.OrderDetails(val.getOrderByStatus['data']
                                      ['order'][i]['id']);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyOrderDetails(
                                        reservedOrders:
                                            val.getOrderByStatus['data']
                                                            ['order'][i]
                                                        ['status'] ==
                                                    "bookOrder"
                                                ? true
                                                : false,
                                        confirmedOrders:
                                            val.getOrderByStatus['data']
                                                            ['order'][i]
                                                        ['status'] ==
                                                    "receiveOrder"
                                                ? true
                                                : false,
                                        cancelledDoneOrders:
                                            val.getOrderByStatus['data']
                                                            ['order'][i]
                                                        ['status'] ==
                                                    "back"
                                                ? true
                                                : false,
                                        onPressedOk: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        onPressedOkFromConfirmOrder: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        onPressedOkFromCancelledDoneOrder: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        onPressedHomeButtonDetails: () {},
                                      ),
                                    ),
                                  );
                                },
                                child: MyOrderItem(
                                  title: val.getOrderByStatus['data']['order']
                                      [i]['product_name'],
                                  numberOrder:
                                      'ID :  ${val.getOrderByStatus['data']['order'][i]['orderNumber']}',
                                  id: val.getOrderByStatus['data']['order'][i]
                                      ['id'],
                                  from:
                                      "${val.getOrderByStatus['data']['order'][i]['city_sender']}",
                                  to: "${val.getOrderByStatus['data']['order'][i]['city_receiver']}",
                                  dataFrom: "5 / 2 / 2025",
                                  dataTo: "5 / 2 / 2025",
                                  amount:
                                      "${val.getOrderByStatus['data']['order'][i]['totalPrice']}",
                                  currency:
                                      "${val.getOrderByStatus['data']['currency']}",
                                  onPressedOk: () {
                                    Navigator.pop(context);
                                  },
                                  onPressedOkFromConfirmOrder: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  onPressedOkFromCancelledDoneOrder: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  onPressedHomeButton: () {},
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 16,
                              );
                            },
                          ),
                        ),
                      ),
          ],
        ),
      );
    });
  }
}
