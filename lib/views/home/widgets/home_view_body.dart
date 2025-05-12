import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/components/nodata.dart';
import 'package:hwee_tawseel_driver/constant.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/myOrders/my_order_details.dart';
import 'package:hwee_tawseel_driver/views/myOrders/widgets/my_order_item.dart';
import 'package:provider/provider.dart';

import '../../../prov/langlocal.dart';

class HomeViewBody extends StatefulWidget {
  HomeViewBody({
    super.key,
    required this.onPressedHomeButton,
    required this.onPressedHomeButtonDetails,
  });

  final Function() onPressedHomeButton;
  final Function() onPressedHomeButtonDetails;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  LangLocal langLocal = new LangLocal();

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Directionality(
        textDirection: val.direction,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                height: 64,
                decoration: BoxDecoration(
                  color: Color(0xFF2D3447),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        Assets.imagesShape3,
                        height: 47,
                      ),
                    ),
                    Container(
                      width: 260,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            left: val.isLogin ? val.direction ==TextDirection.rtl ?0:120 : val.direction ==TextDirection.ltr ?0:120,
                            top: 0,
                            bottom: 0,
                            right: val.isLogin ?val.direction ==TextDirection.ltr ?0:120 : val.direction ==TextDirection.rtl ?0:120,
                            child: Container(
                              width: 100,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.greenWhite,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  height: 32,
                                  // highlightColor: Colors.transparent,
                                  // splashColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  onPressed: () {
                                    val.choseTypeOrder("inside", false, false);
                                  },
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "${langLocal.langLocal['cityRequests']!['${val.languagebox.get("language")}']}",
                                    style: AppTextStyles.style10W700(context)
                                        .copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  height: 32,
                                  // highlightColor: Colors.transparent,
                                  // splashColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  onPressed: () {
                                    val.choseTypeOrder("outside", true, true);
                                  },
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "${langLocal.langLocal['outsideCityRequests']!['${val.languagebox.get("language")}']}",
                                    style: AppTextStyles.style10W700(context)
                                        .copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Image.asset(
                        Assets.imagesShape3,
                        height: 47,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            val.areas == null
                ? SizedBox()
                : val.areas['status'] == false
                    ? SizedBox()
                    : Container(
                        height: 40,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: val.areas['data'].length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding:  EdgeInsets.only(left:val.direction ==TextDirection.ltr ? i ==0? 12:0 :0
                                ,right: val.direction ==TextDirection.rtl ? i ==0? 12:0 :0
                                ),
                                child: CityButton(
                                  color: val.changeArea == i
                                      ? AppColors.orange
                                      : null,
                                  textColor: val.changeArea == i
                                      ? AppColors.white
                                      : null,
                                  onPressed: () {
                                    val.ChangeArea(i);
                                  },
                                  text: "${val.areas['data'][i]['name']}",
                                ),
                              );
                            }),
                      ),
            SizedBox(height: 16),
            val.ordersCreated == null
                ? Container(
                    height: 500,
                    child: Center(child: CircularProgressIndicator()))
                : val.ordersCreated['status'] == false
                    ? Container(height: 500, child: Center(child: NoData()))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: val.ordersCreated['data']['orders'].length,
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () {
                              val.OrderDetails(
                                  val.ordersCreated['data']['orders'][i]['id']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyOrderDetails(
                                    homeOrders: true,
                                    onPressedOk: () {},
                                    onPressedOkFromConfirmOrder: () {},
                                    onPressedOkFromCancelledDoneOrder: () {},
                                    onPressedHomeButtonDetails:
                                        widget.onPressedHomeButtonDetails,
                                  ),
                                ),
                              );
                            },
                            child: MyOrderItem(
                              title:
                                  "${val.ordersCreated['data']['orders'][i]['product_name']}",
                              numberOrder:
                                  'ID : ${val.ordersCreated['data']['orders'][i]['orderNumber']}',
                              id: val.ordersCreated['data']['orders'][i]['id'],
                              from:
                                  " ${val.ordersCreated['data']['orders'][i]['city_sender']}",
                              to: "${val.ordersCreated['data']['orders'][i]['city_receiver']}",
                              amount:
                                  "${val.ordersCreated['data']['orders'][i]['totalPrice']}",
                              currency:
                                  "${val.ordersCreated['data']['currency']}",
                              dataFrom: "5 / 2 / 2025",
                              dataTo: "5 / 2 / 2025",
                              homeOrders: true,
                              onPressedOk: () {},
                              onPressedOkFromConfirmOrder: () {},
                              onPressedOkFromCancelledDoneOrder: () {},
                              onPressedHomeButton: widget.onPressedHomeButton,
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                        ),
                      ),
            SizedBox(height: 10),
          ],
        ),
      );
    });
  }
}

class CityButton extends StatelessWidget {
  const CityButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
  });

  final String text;

  final VoidCallback onPressed;

  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: MaterialButton(
        elevation: 0,
        onPressed: onPressed,
        color: color ?? Color(0xffF6F6F6),
        minWidth: 124,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: AppTextStyles.style10W500(context).copyWith(
            color: textColor ?? AppColors.black,
            fontFamily: 'Noto Kufi Arabic',
          ),
        ),
      ),
    );
  }
}
