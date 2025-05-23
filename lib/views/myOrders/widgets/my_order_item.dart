import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/myOrders/widgets/reserved_order_buttons.dart';
import 'package:provider/provider.dart';
import '../../../constant.dart';
import 'cancelled_done_buttons.dart';
import 'confirmed_order_buttons.dart';
import 'home_order_buttons.dart';

class MyOrderItem extends StatelessWidget {
  const MyOrderItem({
    super.key,
    required this.title,
    required this.from,
    required this.to,
    required this.currency,
    required this.amount,
    required this.numberOrder,
    required this.id,
    // required this.bottomOnTapOk,
    // required this.bottomOnTapNotOk,
    this.reservedOrders = false,
    this.confirmedOrders = false,
    this.cancelledDoneOrders = false,
    this.homeOrders = false,
    required this.dataFrom,
    required this.dataTo,
    required this.onPressedOk,
    required this.onPressedOkFromConfirmOrder,
    required this.onPressedOkFromCancelledDoneOrder,
    required this.onPressedCanselOrder,
    required this.onPressedHomeButton,
  });

  final String title;
  final String numberOrder;
  final int id;
  final String from;
  final String to;
  final String dataFrom;
  final String dataTo;
  final String currency;
  final String amount;
  final bool reservedOrders;
  final bool confirmedOrders;
  final bool cancelledDoneOrders;
  final bool homeOrders;
  final Function() onPressedOk;
  final Function() onPressedOkFromConfirmOrder;
  final Function() onPressedOkFromCancelledDoneOrder;
  final Function() onPressedCanselOrder;
  final Function() onPressedHomeButton;

// final Function() bottomOnTapOk;
// final Function() bottomOnTapNotOk;

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.shade200,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: AppTextStyles.style12W500(context).copyWith(
                      color: AppColors.greenWhite,
                    ),
                  ),
                  Spacer(),
                  Text(
                    numberOrder,
                    style: AppTextStyles.style12W500(context).copyWith(),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greenDark,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.imagesBox2,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Divider(
                color: AppColors.border.withAlpha(128),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${langLocal.langLocal['deliveryValue']!['${val.languagebox.get("language")}']}",
                    style: AppTextStyles.style12W500(context),
                  ),
                  Text(
                    "$amount $currency",
                    style: AppTextStyles.style12W700(context),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Visibility(
                        visible: !cancelledDoneOrders &&
                            !confirmedOrders &&
                            !reservedOrders &&
                            !homeOrders,
                        child: Text(
                          dataTo,
                          style: AppTextStyles.style12W500(context),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        to,
                        style: AppTextStyles.style12W500(context),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_back),
                  Column(
                    children: [
                      // Visibility(
                      //   visible: !cancelledDoneOrders &&
                      //       !confirmedOrders &&
                      //       !reservedOrders &&
                      //       !homeOrders,
                      //   child: Text(
                      //     dataFrom,
                      //     style: AppTextStyles.style12W500(context),
                      //   ),
                      // ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        from,
                        style: AppTextStyles.style12W500(context),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Visibility(
                visible: val.changeMyOrder == "receiveOrder" ? true : false,
                child: ConfirmedOrderButtons(
                  onPressedOkFromConfirmOrder: onPressedOkFromConfirmOrder,
                  onPressedCanselOrder: onPressedCanselOrder,
                  id: id,
                  status: "finished",
                ),
              ),
              Visibility(
                visible: val.changeMyOrder == "bookOrder" ? true : false,
                child: ReservedOrderButtons(
                  onPressedOk: () {},
                  id: id,
                ),
              ),
              Visibility(
                visible: val.changeMyOrder == "back" ? true : false,
                child: CancelledDoneButtons(
                  onPressedOkFromCancelledDoneOrder:
                      onPressedOkFromCancelledDoneOrder,
                  id: id,
                  status: "finishedBack",
                ),
              ),
              Visibility(
                visible: val.changeMyOrder == "create" ? true : false,
                child: HomeOrderButtons(
                  homeButtonOnPressed: onPressedHomeButton,
                  id: id,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
