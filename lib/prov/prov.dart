import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hwee_tawseel_driver/prov/api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:image_picker/image_picker.dart';

class Control extends ChangeNotifier {
  Api api = new Api();
  var fbm = FirebaseMessaging.instance;
  String tokendevice = '';
  var data = null;
  // GetTokenDevice() async {
  //   await fbm.requestPermission();
  //   fbm.getToken().then((value) {
  //     tokendevice = value!;
  //     print("token== $value");
  //     print("token== $value");
  //     print("token== $value");
  //   });
  //   notifyListeners();
  // }
  Future<void> GetTokenDevice() async {
  // اطلب صلاحيات الإشعارات
  await fbm.requestPermission();

  // استنى الـ APNs Token الأول
  String? apnsToken;
  do {
    apnsToken = await fbm.getAPNSToken();
    if (apnsToken == null) {
      print("⏳ Waiting for APNs token...");
      await Future.delayed(const Duration(seconds: 2));
    }
  } while (apnsToken == null);

  print("📱 APNs Token ready: $apnsToken");

  // بعد ما يجهز، خد الـ FCM Token
  String? fcmToken = await fbm.getToken();
  if (fcmToken != null) {
    tokendevice = fcmToken;
    print("🔥 FCM Token: $fcmToken");
  } else {
    print("⚠️ No FCM token available yet");
  }

  notifyListeners();
}


  String lang = "";
  late Box languagebox = Hive.box("language");
  late Box tokenbox = Hive.box("token");
  late Box namebox = Hive.box("name");
  late Box imagebox = Hive.box("image");
  TextDirection direction = TextDirection.rtl;
  initLang() {
    direction = languagebox.get("language") == "ar"
        ? TextDirection.rtl
        : TextDirection.ltr;
    notifyListeners();
  }

  choseLangouge(String value) {
    lang = value;
    languagebox.put("language", value);
    direction = languagebox.get("language") == "ar"
        ? TextDirection.rtl
        : TextDirection.ltr;
    notifyListeners();
  }

  shwatchLanguage() {
    languagebox.get("language") == "en"
        ? languagebox.put("language", "ar")
        : languagebox.put("language", "en");
    print(languagebox.get("language"));
    direction = languagebox.get("language") == "ar"
        ? TextDirection.rtl
        : TextDirection.ltr;
    notifyListeners();
  }

  double lat = 0.0;
  double long = 0.0;

  Position? cl;

  Future<void> getPosition() async {
    bool servicesEnabled;
    LocationPermission permission;

    // 🔹 التحقق مما إذا كان GPS مفعلاً
    servicesEnabled = await Geolocator.isLocationServiceEnabled();
    if (!servicesEnabled) {
      print("⚠️ خدمة الموقع غير مفعلة!");
      return;
    }

    // 🔹 التحقق من إذن الوصول للموقع
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          "🚫 إذن الموقع مرفوض نهائيًا! يجب على المستخدم تغييره من الإعدادات.");
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        cl = await getLatAndLong();
        if (cl != null) {
          lat = cl!.latitude;
          long = cl!.longitude;
          print("📍 الموقع: $lat, $long");

          // 🔹 استدعاء دالة جلب تفاصيل الموقع
          getDetailsLocation(lat, long);
        } else {
          print("❌ فشل في الحصول على الموقع!");
        }
      } catch (e) {
        print("❌ خطأ أثناء جلب الموقع: $e");
      }
    }
  }

  Future<Position?> getLatAndLong() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print("❌ خطأ أثناء الحصول على الموقع: $e");
      return null;
    }
  }

  List<Placemark> placemarks = [];
  Future getDetailsLocation(double lat, double long) async {
    placemarks = await placemarkFromCoordinates(lat, long);
    print(placemarks[0]);
    print(placemarks[0]);
    print(placemarks[0]);
    kGooglePlexUser = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
    addDetailsToInput();
    notifyListeners();
  }

  CameraPosition kGooglePlexUser = new CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  late GoogleMapController gmc;
  late Set<Marker> mymarker = {
    Marker(
        onTap: () {
          print("object");
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: "mohamed Hanafy"),
        markerId: MarkerId("1"),
        position: LatLng(cl!.latitude, cl!.longitude)),
  };
  String city = "";
  String neighbor = "";
  String country = "";
  addDetailsToInput() {
    city = placemarks[0].administrativeArea ?? "";
    country = placemarks[0].country ?? "";
    neighbor = placemarks[0].subAdministrativeArea ?? "";
    // api.street.text = placemarks[0].street ??"";
    notifyListeners();
  }

  pinMarcker(double lat, double long) async {
    mymarker = {
      Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(title: "mohamed Hanafy"),
          markerId: MarkerId("1"),
          position: LatLng(lat, long)),
    };
    getDetailsLocation(lat, long);
    notifyListeners();
  }

  late StreamSubscription<Position> ps;
  getLifeLocation() {
    print("start");
    ps = Geolocator.getPositionStream().listen((Position? position) {
      print("work");
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
      mymarkerdriver = {
        Marker(
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: "${namebox.get("name")}"),
            markerId: MarkerId("4"),
            position: LatLng(position!.latitude, position.longitude)),
        Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange),
            infoWindow: InfoWindow(title: "$nameclientReciver"),
            markerId: MarkerId("3"),
            position: LatLng(latclientRe, longclientRe)),
        Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueOrange),
            infoWindow: InfoWindow(title: "$nameclientSender"),
            markerId: MarkerId("5"),
            position: LatLng(latclientSe, longclientSe))
      };
      notifyListeners();
    });
    setdata();
    print("end");
    notifyListeners();
  }

  CameraPosition kGooglePlex = new CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 14.4746,
  );
  String nameclientReciver = "";
  String nameclientSender = "";
  double latclientRe = 0.0;
  double longclientRe = 0.0;
  double latclientSe = 0.0;
  double longclientSe = 0.0;
  setdata() {
    latclientRe = orderDetails['data']['order']['latitude_receiver'] as double;
    longclientRe =
        orderDetails['data']['order']['longitude_receiver	'] as double;
    latclientSe = orderDetails['data']['order']['latitude_sender'] as double;
    longclientSe = orderDetails['data']['order']['longitude_sender'] as double;
    nameclientReciver =
        "${orderDetails['data']['order']['name_receiver']} المستلم";
    nameclientSender = "${orderDetails['data']['order']['name_sender']} المرسل";
    mymarkerdriver = {
      Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(title: "$nameclientReciver"),
          markerId: MarkerId("3"),
          position: LatLng(longclientRe, latclientRe)),
      Marker(
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          infoWindow: InfoWindow(title: "$nameclientSender"),
          markerId: MarkerId("5"),
          position: LatLng(longclientSe, latclientSe))
    };
    kGooglePlex = CameraPosition(
      target: LatLng(latclientSe, longclientSe),
      zoom: 14.4746,
    );
    notifyListeners();
  }

  late Set<Marker> mymarkerdriver = {
    Marker(
        onTap: () {
          print("object");
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: "$nameclientReciver"),
        markerId: MarkerId("3"),
        position: LatLng(cl!.latitude, cl!.longitude)),
    Marker(
        onTap: () {
          print("object");
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: "$nameclientSender"),
        markerId: MarkerId("5"),
        position: LatLng(cl!.latitude, cl!.longitude)),

    //
    Marker(
        onTap: () {
          print("object");
        },
        draggable: true,
        onDragEnd: (value) {
          print(value);
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        // icon:await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty,"assets/images/accept.png"),
        infoWindow: InfoWindow(title: "${namebox.get("name")}"),
        markerId: MarkerId("4"),
        position: LatLng(cl!.latitude + 0.0001, cl!.longitude + 0.001))
  };

  File? card_image;
  void uploadcard_image() async {
    try {
      // فتح نافذة لاختيار ملف
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        card_image = File(result.files.single.path!);

        print(card_image!.path);
        print("image$card_image");
        notifyListeners();
      }
    } catch (e) {
      print('حدث خطأ أثناء رفع الصورة: $e');
    }
    notifyListeners();
  }

  File? user_image;
  void upload_User_image() async {
    try {
      // فتح نافذة لاختيار ملف
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        user_image = File(result.files.single.path!);

        print(user_image!.path);
        print("image$user_image");
        notifyListeners();
      }
    } catch (e) {
      print('حدث خطأ أثناء رفع الصورة: $e');
    }
    notifyListeners();
  }

  File? license_image;
  void uploadlicense_image() async {
    try {
      // فتح نافذة لاختيار ملف
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        license_image = File(result.files.single.path!);

        print(license_image!.path);
        print("image$license_image");
        notifyListeners();
      }
    } catch (e) {
      print('حدث خطأ أثناء رفع الصورة: $e');
    }
    notifyListeners();
  }

  File? license_self_image;
  void uploadlicense_self_image() async {
    try {
      // فتح نافذة لاختيار ملف
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        license_self_image = File(result.files.single.path!);

        print(license_self_image!.path);
        print("image$license_self_image");
        notifyListeners();
      }
    } catch (e) {
      print('حدث خطأ أثناء رفع الصورة: $e');
    }
    notifyListeners();
  }

  var register = null;
  Future Register() async {
    register = null;
    data = null;
    register = await api.Register(
        tokendevice,
        lat.toString(),
        long.toString(),
        country_id.toString(), //country_id
        city,
        neighbor,
        user_image!,
        card_image!,
        license_image!,
        license_self_image!);
    data = register;
    print("Register == $register");
    print("Register == $register");
    print("Register == $register");
    notifyListeners();
  }

  var verfy = null;
  Verfy() async {
    verfy = null;
    data = null;
    verfy = await api.Verfy();
    data = verfy;
    print(verfy);
    print(verfy);
    print(verfy);
    notifyListeners();
  }

  var login = null;
  Future Login() async {
    data = null;
    login = null;
    login = await api.Login(tokendevice);
    data = login;
    if (login != null) {
      if (login['status'] == true) {
        tokenbox.put("token", "Bearer ${login['data']['token']}");
        namebox.put("name",
            "${login['data']['first_name']} ${login['data']['last_name']}");
        imagebox.put("image", "${login['data']['image']}");
        print(tokenbox.get("token"));
        print(namebox.get("name"));
        print(imagebox.get("image"));
      }
    }
    print("login == $login");
    print("login == $login");
    print("login == $login");
    notifyListeners();
  }

  var phoneReset = null;
  Future PhoneReset() async {
    data = null;
    phoneReset = null;
    phoneReset = await api.PhoneReset();
    data = phoneReset;
    print("phoneReset == $phoneReset");
    print("phoneReset == $phoneReset");
    print("phoneReset == $phoneReset");
    notifyListeners();
  }

  var resetpass = null;
  Future PassReset() async {
    data = null;
    resetpass = null;
    resetpass = await api.ResetPass();
    data = resetpass;
    print("resetpass == $resetpass");
    print("resetpass == $resetpass");
    print("resetpass == $resetpass");
    notifyListeners();
  }

  int step = 1;
  changeresetpass(int value) {
    step = value;
    notifyListeners();
  }

  var countries = null;
  Future Countries() async {
    countries = null;
    countries = await api.Countries();
    data = countries;
    print("countries == $countries");
    print("countries == $countries");
    print("countries == $countries");
    notifyListeners();
  }

  int country_id = -1;
  choseCountry_id(int value) {
    country_id = value;
    notifyListeners();
  }

  var areas = null;
  Future Areas() async {
    areas = null;
    areas = await api.Areas();
    if (areas != null) {
      if (areas['status'] == false && areas['message'] == "unauthentecation") {
        tokenbox.put("token", "");
      }
      if (areas['status'] == true && (areas['data'] as List).isNotEmpty) {
        idArea = areas['data'][0]['id'];
        OrdersCreated();
      }
    }

    print("areas == $areas");
    print("areas == $areas");
    print("areas == $areas");
    notifyListeners();
  }

  int changeArea = 0;
  int idArea = 0;
  ChangeArea(int i) {
    changeArea = i;
    idArea = areas['data'][i]['id'];
    print(idArea);
    OrdersCreated();
    notifyListeners();
  }

  bool isLogin = false;
  bool showCity = false;
  String typeOrder = "inside";
  choseTypeOrder(String valu, bool showCity1, isLogin1) {
    isLogin = isLogin1;
    showCity = showCity1;
    typeOrder = valu;
    OrdersCreated();
    notifyListeners();
  }

  var ordersCreated = null;
  Future OrdersCreated() async {
    ordersCreated = null;
    changeMyOrder = "create";
    ordersCreated = await api.OrdersCreated(idArea, typeOrder);
    print("ordersCreated == $ordersCreated");
    print("ordersCreated == $ordersCreated");
    print("ordersCreated == $ordersCreated");
    notifyListeners();
  }

  var orderDetails = null;
  Future OrderDetails(int id) async {
    orderDetails = null;
    orderDetails = await api.OrderDetails(id);
    print("orderDetails == $orderDetails");
    print("orderDetails == $orderDetails");
    print("orderDetails == $orderDetails");
    notifyListeners();
  }

  String dateRecive = "";
  DateRecive(String value) {
    dateRecive = value;
    print(value);
    notifyListeners();
  }

  String timeRecive = "";
  TimeRecive(String value) {
    timeRecive = value;
    print(value);
    notifyListeners();
  }

  String dateFinish = "";
  DateFinish(String value) {
    dateFinish = value;
    print(value);
    notifyListeners();
  }

  String timeFinish = "";
  TimeFinish(String value) {
    timeFinish = value;
    print(value);
    notifyListeners();
  }

  var updateOrder = null;
  Future UpdateOrder(int id, String status) async {
    data = null;
    updateOrder = null;
    updateOrder = await api.UpdateOrder(
        id, dateRecive, timeRecive, dateFinish, timeFinish, status);
    data = updateOrder;
    if (updateOrder != null) {
      if (updateOrder['status'] == true) {
        OrdersCreated();
        if (status == "bookOrder") {
          GetOrderByStatus("bookOrder");
        } else if (status == "receiveOrder") {
          GetOrderByStatus("receiveOrder");
        } else if (status == "back") {
          GetOrderByStatus("back");
        } else if (status == "finishedBack") {
          GetOrderByStatus("finishedBack");
        }
      }
    }

    print("updateOrder == $updateOrder");
    print("updateOrder == $updateOrder");
    print("updateOrder == $updateOrder");
    notifyListeners();
  }

  var getOrderByStatus = null;
  String changeMyOrder = "create";
  Future GetOrderByStatus(String status) async {
    changeMyOrder = status;
    getOrderByStatus = null;
    getOrderByStatus = await api.GetOrderByStatus(status);

    print("getOrderByStatus == $getOrderByStatus");
    print("getOrderByStatus == $getOrderByStatus");
    print("getOrderByStatus == $getOrderByStatus");
    notifyListeners();
  }

  var cancelOrder = null;
  Future CancelOrder(int id) async {
    cancelOrder = null;
    data = null;
    cancelOrder = await api.CancelOrder(id);
    data = cancelOrder;
    if (cancelOrder != null) {
      if (cancelOrder["status"] == true) {
        GetOrderByStatus("bookOrder");
      }
    }

    print("cancelOrder == $cancelOrder");
    print("cancelOrder == $cancelOrder");
    print("cancelOrder == $cancelOrder");
    notifyListeners();
  }

  var profile = null;
  Future Profile() async {
    profile = null;
    profile = await api.Profile();
    print("profile == $profile");
    print("profile == $profile");
    print("profile == $profile");
    notifyListeners();
  }

  var editProfile = null;
  Future EditProfile() async {
    editProfile = null;
    data = null;
    editProfile = await api.EditProfile(
        tokendevice,
        lat.toString(),
        long.toString(), //country_id
        city,
        neighbor,
        user_image,
        card_image,
        license_image,
        license_self_image);
    data = editProfile;
    if (editProfile != null) {
      if (editProfile['status'] == true) {
        Profile();
        namebox.put("name",
            "${editProfile['data']['first_name']} ${editProfile['data']['last_name']}");
        imagebox.put("image", "${editProfile['data']['image']}");
      }
    }
    print("editProfile == $editProfile");
    print("editProfile == $editProfile");
    print("editProfile == $editProfile");
    notifyListeners();
  }

  inputEdit() {
    api.fname.text = profile['data']['first_name'];
    api.lname.text = profile['data']['last_name'];
    api.phone.text = profile['data']['phone'];
    notifyListeners();
  }

  var logOut = null;
  LogOut() async {
    logOut = null;
    data = null;
    logOut = await api.LogOut();
    if (logOut != null) {
      if (logOut['status'] == true) {
        tokenbox.put("token", "");
      }
    }
    data = logOut;
    print(logOut);
    print(logOut);
    print(logOut);
    notifyListeners();
  }

  var walet = null;
  Walet() async {
    walet = null;
    walet = await api.Walet();
    print(walet);
    print(walet);
    print(walet);
    notifyListeners();
  }

  var getMony = null;
  GetMony() async {
    getMony = null;
    data = null;
    getMony = await api.GetMony();

    data = getMony;
    if (getMony != null) {
      if (getMony['status'] == true) {
        Walet();
      }
    }

    print(getMony);
    print(getMony);
    print(getMony);
    notifyListeners();
  }

  var notificat;
  Notificat() async {
    notificat = null;
    notificat = await api.Notificat(tokenbox.get("token"));
    print(notificat);
    print(notificat);
    print(notificat);
    notifyListeners();
  }

  var oneNotificat;
  OneNotificat(int id, int i) async {
    oneNotificat = null;
    oneNotificat = await api.OneNotificat(tokenbox.get("token"), id);
    if (oneNotificat != null) {
      if (oneNotificat['status'] == true) {
        notificat['data'][i]['is_read'] = 1;
        OrdersCreated();
      }
    }
    print(oneNotificat);

    print(oneNotificat);
    print(oneNotificat);
    notifyListeners();
  }

  call(String number) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: '$number',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('error');
    }
  }

  //examole

  final ImagePicker picker = ImagePicker();
  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      if (type == "profile") {
        user_image = File(pickedFile.path);
      } else if (type == "card") {
        card_image = File(pickedFile.path);
      } else if (type == "license") {
        license_image = File(pickedFile.path);
      } else if (type == "license_self") {
        license_self_image = File(pickedFile.path);
      }
    } // إغلاق الـ BottomSheet بعد الاختيار
    notifyListeners();
  }
}
