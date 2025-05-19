import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hwee_tawseel_driver/components/app_colors.dart';
import 'package:hwee_tawseel_driver/components/app_text_styles.dart';
import 'package:hwee_tawseel_driver/components/generated/assets.dart';
import 'package:hwee_tawseel_driver/components/image.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:hwee_tawseel_driver/views/home/home_view.dart';
import 'package:hwee_tawseel_driver/views/myOrders/my_orders_view.dart';
import 'package:hwee_tawseel_driver/views/notifcat/notificat.dart';
import 'package:hwee_tawseel_driver/views/profile/profile_view.dart';
import 'package:provider/provider.dart';
import '../../constant.dart';
import '../../prov/langlocal.dart';
import '../wallet/wallwt_view.dart';
import 'bottom_nav_btn.dart';
import 'clipper.dart';
import 'size_config.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  LangLocal langLocal = new LangLocal();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Control>(context, listen: false).Areas();
    });
  }

  int _currentIndex = 0;
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Consumer<Control>(builder: (context, val, child) {
      return Scaffold(
        bottomNavigationBar: Directionality(
          textDirection: val.direction,
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
                right: 16,
                left: 16,
              ),
              child: bottomNav(),
            ),
          ),
        ),
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leadingWidth: 0,
          leading: SizedBox(),
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Directionality(
            textDirection: val.direction,
            child: Row(
              spacing: 8,
              children: [
                Container(
                  height: 48,
                  padding: EdgeInsets.only(
                      right: val.direction == TextDirection.rtl ? 2 : 24,
                      left: val.direction == TextDirection.rtl ? 24 : 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 1,
                      color: AppColors.greenWhite,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: val.direction == TextDirection.ltr
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: ImageView(
                                image:
                                    "${val.api.ip}/${val.imagebox.get('image')}"),
                          )

                          //Image.asset(Assets.imagesTest1),
                          ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${langLocal.langLocal['hello']!['${val.languagebox.get("language")}']}",
                            style: AppTextStyles.style10W500(context).copyWith(
                              color: AppColors.greenWhite,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("${val.namebox.get("name")}",
                              style: AppTextStyles.style10W500(context)),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF9F9F9),
                  ),
                  child: IconButton(
                    onPressed: () {
                      val.shwatchLanguage();
                    },
                    icon: Center(
                        child: Text(
                      "${val.languagebox.get("language")}",
                      style: AppTextStyles.style10W500(context),
                    )),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF9F9F9),
                      ),
                      child: IconButton(
                        icon: Center(
                          child: SvgPicture.asset(
                            // "assets/images/bell.svg",
                            Assets.imagesBell,
                            width: 20,
                          ),
                        ),
                        onPressed: () {
                          val.Notificat();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationsView()));
                        },
                      ),
                    ),
                    val.ordersCreated == null
                        ? SizedBox()
                        : val.ordersCreated['status'] == false
                            ? Container()
                            : val.ordersCreated['data']['notifications'] == 0
                                ? SizedBox()
                                : CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 8,
                                    child: Text(
                                      "${val.ordersCreated['data']['notifications']}",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    )),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(Assets.imagesLogo),
                  ),
                ),
              ],
            ),
          ),
          actions: [],
        ),
        body: Directionality(
          textDirection: val.direction,
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      _currentIndex = value;
                    });
                  },
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    HomeView(
                      onPressedHomeButton: () {
                        animateToPage(1);
                      },
                      onPressedHomeButtonDetails: () {
                        Navigator.pop(context);
                        print('back');
                        animateToPage(1);
                      },
                    ),
                    MyOrder(),
                    WalletView(),
                    ProfileView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget bottomNav() {
    ColorsApp colorsApp = new ColorsApp();
    return Consumer<Control>(builder: (context, val, child) {
      return Directionality(
        textDirection: val.direction,
        child: Material(
          borderRadius: BorderRadius.circular(30),
          color: Colors.transparent,
          elevation: 6,
          child: Container(
            height: AppSizes.blockSizeHorizontal * 18,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: colorsApp.colorblackApp,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: AppSizes.blockSizeHorizontal * 3,
                  right: AppSizes.blockSizeHorizontal * 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BottomNavBTN(
                        title:
                            "${langLocal.langLocal['requests']!['${val.languagebox.get("language")}']}",
                        onPressed: (value) {
                          animateToPage(value);
                          val.OrdersCreated();
                        },
                        icon: Assets.imagesBox2,
                        currentIndex: _currentIndex,
                        index: 0,
                      ),
                      BottomNavBTN(
                        title:
                            "${langLocal.langLocal['myRequests']!['${val.languagebox.get("language")}']}",
                        onPressed: (value) {
                          animateToPage(value);
                          val.GetOrderByStatus("bookOrder");
                        },
                        icon: Assets.imagesTruck,
                        currentIndex: _currentIndex,
                        index: 1,
                      ),
                      BottomNavBTN(
                        title:
                            "${langLocal.langLocal['wallet']!['${val.languagebox.get("language")}']}",
                        onPressed: (value) {
                          val.Walet();
                          animateToPage(value);
                        },
                        icon: Assets.imagesWallet,
                        currentIndex: _currentIndex,
                        index: 2,
                      ),
                      BottomNavBTN(
                        title:
                            "${langLocal.langLocal['myAccount']!['${val.languagebox.get("language")}']}",
                        onPressed: (value) {
                          val.Profile();
                          animateToPage(value);
                        },
                        icon: Assets.imagesUser,
                        currentIndex: _currentIndex,
                        index: 3,
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                  top: 0,
                  left: animatedPositionedLeftValue(context, _currentIndex),
                  child: Column(
                    children: [
                      Container(
                        height: AppSizes.blockSizeHorizontal * 1.0,
                        width: AppSizes.blockSizeHorizontal * 12,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      ClipPath(
                        clipper: MyCustomClipper(),
                        child: Container(
                          height: AppSizes.blockSizeHorizontal * 15,
                          width: AppSizes.blockSizeHorizontal * 12,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: gradient,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

final List<Color> gradient = [
  Colors.orange.withOpacity(0.5),
  Colors.orange.withOpacity(0.2),
  Colors.transparent
];

double animatedPositionedLeftValue(BuildContext context, int currentIndex) {
  final direction = Provider.of<Control>(context, listen: false).direction;

  switch (currentIndex) {
    case 0:
      return direction == TextDirection.ltr
          ? AppSizes.blockSizeHorizontal * 7.5
          : AppSizes.blockSizeHorizontal * 72;

    case 1:
      return direction == TextDirection.ltr
          ? AppSizes.blockSizeHorizontal * 29
          : AppSizes.blockSizeHorizontal * 50.5;

    case 2:
      return direction == TextDirection.ltr
          ? AppSizes.blockSizeHorizontal * 50.5
          : AppSizes.blockSizeHorizontal * 29;

    case 3:
      return direction == TextDirection.ltr
          ? AppSizes.blockSizeHorizontal * 72
          : AppSizes.blockSizeHorizontal * 7.5;

    default:
      return 0;
  }
}
