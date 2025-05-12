import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Api {
  String ip =
      "https://mangamediaa.com/tawsel-hawe/public"; //https://mangamediaa.com/tawsel-hawe/public "http://192.168.1.3/laravel/tawsel-hawe/public";
  late Box languagebox = Hive.box("language");
  late Box tokenbox = Hive.box("token");
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var register;
  Register(
    String fcm_token,
    String lat,
    String long,
    String country_id,
    String city,
    String neighborhood,
    File user_image,
    File card_image,
    File license_image,
    File license_self_image,
  ) async {
    register = null;
    final dio = Dio();
    FormData formData = FormData.fromMap({
      'fcm_token': fcm_token,
      'first_name': "${fname.text}",
      'last_name': "${lname.text}",
      'phone': "${phone.text}",
      'password': "${password.text}",
      'password_confirmation': "${confirmPassword.text}",
      'latitude': "$lat",
      'longitude': "$long",
      'country_id': "$country_id",
      'city': "$city",
      'neighborhood': "$neighborhood",
      'card_image': await MultipartFile.fromFile(
        card_image.path,
        filename: card_image.path.split('/').last,
      ),
      'license_image': await MultipartFile.fromFile(
        license_image.path,
        filename: license_image.path.split('/').last,
      ),
      'license_self_image': await MultipartFile.fromFile(
        license_self_image.path,
        filename: license_self_image.path.split('/').last,
      ),
      'image': await MultipartFile.fromFile(
        user_image.path,
        filename: user_image.path.split('/').last,
      ),
    });
    // إرسال الطلب

    try {
      Response response = await dio.post(
        '$ip/api/driver/register', // رابط الخادم الخاص بك
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            // "Authorization": "Bearer token",
            "lang": languagebox.get("language")
          },
        ),
      );

      // التحقق من حالة الرد
      if (response.statusCode == 200 || response.statusCode == 201) {
        register = jsonDecode(response.toString());
        print('تم إضافة السائق بنجاح: ${response.data}');
      } else {
        print('فشل في إضافة السائق: ${response.statusCode}');
        print('الرد من الخادم: ${response.data}');
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        register = jsonDecode(dioError.response.toString());
        ;
        // خطأ مع استجابة من الخادم
        print('خطأ من الخادم: ${dioError.response?.statusCode}');
        print('تفاصيل الخطأ: ${dioError.response?.data}');
      } else {
        // خطأ في الاتصال بالخادم
        print('فشل الاتصال بالخادم: ${dioError.message}');
      }
    } catch (e) {
      // لأي خطأ غير متوقع
      print('حدث خطأ غير متوقع: $e');
    }
    return register;
  }

  TextEditingController code = TextEditingController();

  var verfy;
  Future Verfy() async {
    verfy = null;
    String uri = "$ip/api/driver/verify-otp";
    try {
      var respons = await http.post(Uri.parse(uri), body: {
        "phone": "${phone.text}",
        "otp": code.text,
        //"${code1.text}${code2.text}${code3.text}${code4.text}${code5.text}${code6.text}",
      }, headers: {
        "lang": languagebox.get("language")
      });
      var responsbody = jsonDecode(respons.body);
      if (responsbody.isNotEmpty) {
        verfy = responsbody;
      }
      print("register user : ${responsbody}");
      print("register user : ${responsbody}");
      print("register user : ${responsbody}");
    } catch (e) {
      print(e);
    }
    return verfy;
  }

  TextEditingController phoneSignin = new TextEditingController();
  TextEditingController passSignin = new TextEditingController();
  var login;
  Future Login(String fcmToken) async {
    //User Created Successfully
    login = null;
    String uri = "$ip/api/driver/login";
    try {
      var respons = await http.post(Uri.parse(uri), body: {
        "phone": "${phoneSignin.text}",
        "password": "${passSignin.text}",
        "fcm_token": "${fcmToken}",
      }, headers: {
        "lang": languagebox.get("language")
      });
      var responsbody = jsonDecode(respons.body);
      if (responsbody.isNotEmpty) {
        login = responsbody;
      }
      print("login user : ${responsbody}");
      print("login user : ${responsbody}");
      print("login user : ${responsbody}");
    } catch (e) {
      print(e);
    }
    return login;
  }

  var reset;
  Future PhoneReset() async {
    //User Created Successfully
    reset = null;
    String uri = "$ip/api/driver/forget-password";
    try {
      var respons = await http.post(Uri.parse(uri), body: {
        "phone": "${phone.text}",
      }, headers: {
        "lang": languagebox.get("language")
      });
      var responsbody = jsonDecode(respons.body);
      if (responsbody.isNotEmpty) {
        reset = responsbody;
      }
      print("reset user : ${responsbody}");
      print("reset user : ${responsbody}");
      print("reset user : ${responsbody}");
    } catch (e) {
      print(e);
    }
    return reset;
  }

  TextEditingController passwordReset = new TextEditingController();
  TextEditingController password_confirmationReset =
      new TextEditingController();
  var resetPass;
  Future ResetPass() async {
    //User Created Successfully
    resetPass = null;
    String uri = "$ip/api/driver/reset-password";
    try {
      var respons = await http.post(Uri.parse(uri), body: {
        "phone": "${phone.text}",
        "password": "${passwordReset.text}",
        "password_confirmation": "${password_confirmationReset.text}",
      }, headers: {
        "lang": languagebox.get("language")
      });
      var responsbody = jsonDecode(respons.body);
      if (responsbody.isNotEmpty) {
        resetPass = responsbody;
      }
      print("resetPass user : ${responsbody}");
      print("resetPass user : ${responsbody}");
      print("resetPass user : ${responsbody}");
    } catch (e) {
      print(e);
    }
    return resetPass;
  }

  var contries = null;
  Future Countries() async {
    contries = null;
    String url = "$ip/api/admin/countries";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
          "lang": languagebox.get("language")
        },
      );
      if (!response.body.isEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        contries = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }
    return contries;
  }

  var areas = null;
  Future Areas() async {
    contries = null;
    String url = "$ip/api/driver/orders/areas";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': tokenbox.get("token"),
          "lang": languagebox.get("language")
        },
      );
      if (!response.body.isEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        contries = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }
    return contries;
  }

  var ordersCreated = null;
  Future OrdersCreated(int area_id, String order_type) async {
    ordersCreated = null;
    String url =
        "$ip/api/driver/orders/created?order_type=$order_type&area_id=$area_id";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': tokenbox.get("token"),
          "lang": languagebox.get("language")
        },
      );
      if (!response.body.isEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        ordersCreated = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }
    return ordersCreated;
  }

  var orderDetails = null;
  Future OrderDetails(int id) async {
    orderDetails = null;
    String url = "$ip/api/driver/orders/$id";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': tokenbox.get("token"),
          "lang": languagebox.get("language")
        },
      );
      if (!response.body.isEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        orderDetails = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }
    return orderDetails;
  }

  var updateOrder;
  Future UpdateOrder(int id, String dateRecive, String timeRecive,
      String dateFinish, String timeFinish, String status) async {
    //User Created Successfully
    updateOrder = null;
    String uri = "$ip/api/driver/orders/$id";
    try {
      var respons = await http.post(Uri.parse(uri), body: {
        "_method": "PUT",
        "status": "$status",
        "pickup_date": dateRecive,
        "pickup_time": timeRecive,
        "delivery_date": dateFinish,
        "delivery_time": timeFinish,
        "secret_key": code.text,
      }, headers: {
        'Accept': 'application/json',
        "lang": languagebox.get("language"),
        'Authorization': tokenbox.get("token"),
      });
      var responsbody = jsonDecode(respons.body);
      if (responsbody.isNotEmpty) {
        updateOrder = responsbody;
      }
      print("updateOrder : ${responsbody}");
      print("updateOrder : ${responsbody}");
      print("updateOrder : ${responsbody}");
    } catch (e) {
      print(e);
    }
    return updateOrder;
  }

  var getOrderByStatus = null;
  Future GetOrderByStatus(String status) async {
    getOrderByStatus = null;
    String url = "$ip/api/driver/orders-by-status?status=$status";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': tokenbox.get("token"),
          "lang": languagebox.get("language")
        },
      );
      if (!response.body.isEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        getOrderByStatus = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }
    return getOrderByStatus;
  }

  var cancelOrder = null;
  Future CancelOrder(int id) async {
    cancelOrder = null;
    String url = "$ip/api/driver/orders/cancel/$id";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': tokenbox.get("token"),
          "lang": languagebox.get("language")
        },
      );
      if (!response.body.isEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        cancelOrder = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }
    return cancelOrder;
  }

  var profile = null;
  Future Profile() async {
    profile = null;
    String url = "$ip/api/driver/profile";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': tokenbox.get("token"),
          "lang": languagebox.get("language")
        },
      );
      if (!response.body.isEmpty) {
        //response.statusCode == 200 &&
        var responsebody = jsonDecode(response.body);
        profile = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      }
    } catch (e) {
      print(e);
    }
    return profile;
  }

  TextEditingController current_password = new TextEditingController();
  var editProfile;
  EditProfile(
    String fcm_token,
    String lat,
    String long,
    String city,
    String neighborhood,
    File? user_image,
    File? card_image,
    File? license_image,
    File? license_self_image,
  ) async {
    editProfile = null;
    final dio = Dio();
    FormData formData = FormData.fromMap({
      '_method': "put",
      'first_name': "${fname.text}",
      'last_name': "${lname.text}",
      'phone': "${phone.text}",
      "current_password": current_password.text,
      'password': "${password.text}",
      'password_confirmation': "${confirmPassword.text}",
      'latitude': "$lat",
      'longitude': "$long",
      'city': "$city",
      'neighborhood': "$neighborhood",
      'card_image': card_image == null
          ? null
          : await MultipartFile.fromFile(
              card_image.path,
              filename: card_image.path.split('/').last,
            ),
      'license_image': license_image == null
          ? null
          : await MultipartFile.fromFile(
              license_image.path,
              filename: license_image.path.split('/').last,
            ),
      'license_self_image': license_self_image == null
          ? null
          : await MultipartFile.fromFile(
              license_self_image.path,
              filename: license_self_image.path.split('/').last,
            ),
      'image': user_image == null
          ? null
          : await MultipartFile.fromFile(
              user_image.path,
              filename: user_image.path.split('/').last,
            ),
    });
    // إرسال الطلب

    try {
      Response response = await dio.post(
        '$ip/api/driver/profile', // رابط الخادم الخاص بك
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            'Authorization': tokenbox.get("token"),
            "lang": languagebox.get("language")
          },
        ),
      );

      // التحقق من حالة الرد
      if (response.statusCode == 200 || response.statusCode == 201) {
        editProfile = jsonDecode(response.toString());
        print('تم إضافة السائق بنجاح: ${response.data}');
      } else {
        print('فشل في إضافة السائق: ${response.statusCode}');
        print('الرد من الخادم: ${response.data}');
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        editProfile = jsonDecode(dioError.response.toString());
        ;
        // خطأ مع استجابة من الخادم
        print('خطأ من الخادم: ${dioError.response?.statusCode}');
        print('تفاصيل الخطأ: ${dioError.response?.data}');
      } else {
        // خطأ في الاتصال بالخادم
        print('فشل الاتصال بالخادم: ${dioError.message}');
      }
    } catch (e) {
      // لأي خطأ غير متوقع
      print('حدث خطأ غير متوقع: $e');
    }
    return editProfile;
  }

  var logOut = null;
  Future LogOut() async {
    //User Created Successfully
    logOut = null;
    String uri = "$ip/api/driver/logout";
    try {
      var respons = await http.post(Uri.parse(uri), headers: {
        'Accept': 'application/json',
        'Authorization': tokenbox.get("token"),
        "lang": languagebox.get("language"),
      });
      var responsbody = jsonDecode(respons.body);
      if (responsbody.isNotEmpty && respons.statusCode == 200) {
        logOut = responsbody;
      } else {
        logOut = {'status': false, 'data': []};
      }
      print("logOut: ${responsbody}");
      print("logOut: ${responsbody}");
      print("logOut: ${responsbody}");
    } catch (e) {
      print(e);
    }
    return logOut;
  }

  var walet = null;
  Future Walet() async {
    //User Created Successfully
    walet = null;
    String uri = "$ip/api/driver/withdraws";
    try {
      var respons = await http.get(Uri.parse(uri), headers: {
        'Accept': 'application/json',
        'Authorization': tokenbox.get("token"),
        "lang": languagebox.get("language"),
      });
      var responsbody = jsonDecode(respons.body);
      if (responsbody.isNotEmpty && respons.statusCode == 200) {
        walet = responsbody;
      } else {
        walet = {'status': false, 'data': []};
      }
      print("walet: ${responsbody}");
      print("walet: ${responsbody}");
      print("walet: ${responsbody}");
    } catch (e) {
      print(e);
    }
    return walet;
  }

  var getMony = null;
  Future GetMony() async {
    //User Created Successfully
    getMony = null;
    String uri = "$ip/api/driver/withdraws";
    try {
      var respons = await http.post(Uri.parse(uri), body: {
        "amount": walet['data']['wallet']
      }, headers: {
        'Accept': 'application/json',
        'Authorization': tokenbox.get("token"),
        "lang": languagebox.get("language"),
      });
      var responsbody = jsonDecode(respons.body);
      if (responsbody.isNotEmpty) {
        getMony = responsbody;
      } else {
        getMony = {'status': false, 'message': 'error', 'data': []};
      }
      print("getMony: ${responsbody}");
      print("getMony: ${responsbody}");
      print("getMony: ${responsbody}");
    } catch (e) {
      print(e);
    }
    return getMony;
  }

  var notificat;
  Future Notificat(String token) async {
    notificat = null;
    String url = "$ip/api/driver/notification/index";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          "lang": languagebox.get("language")
        },
      );
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        notificat = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      } else {
        notificat = {'status': false, 'data': []};
      }
    } catch (e) {
      print(e);
    }

    return notificat;
  }

  var oneNotificat;
  Future OneNotificat(String token, int id) async {
    oneNotificat = null;
    String url = "$ip/api/driver/notification/show/$id";
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          "lang": languagebox.get("language")
        },
      );
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        oneNotificat = responsebody;
        print(responsebody.length);
        print(responsebody.length);
        print(responsebody);
        print(responsebody);
      } else {
        oneNotificat = {'status': false, 'data': []};
      }
    } catch (e) {
      print(e);
    }

    return oneNotificat;
  }
}
