import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDetails extends StatefulWidget {
  //key google map == AIzaSyDR8GagcxyB0L7QNiST2A07mlHI_cEmNqs
  @override
  State<StatefulWidget> createState() {
    return _MapDetails();
  }
}

class _MapDetails extends State<MapDetails> {
  void initState() {
    //TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Control>(context, listen: false).getPosition();
      Provider.of<Control>(context, listen: false).getLifeLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Control>(builder: (context, val, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // title: AppBarBack(),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined)),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: val.kGooglePlex.target.latitude == 0.0
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
                mapType: MapType.hybrid,
                markers: val.mymarkerdriver,
                initialCameraPosition: val.kGooglePlex,
                // onTap: (argument) {
                //   val.pinMarcker(argument.latitude, argument.longitude);
                //   val.long = argument.longitude;
                //   val.lat = argument.latitude;
                //   print("new location${val.lat}///${argument.latitude}");
                // },
                onMapCreated: (GoogleMapController controller) {
                  // val.controller.complete(controller);
                  val.gmc = controller;
                  print(" loca${val.gmc}");
                },
              ),
      );
    });
  }
}

























// import 'package:flutter/material.dart';
// import 'package:gazhome/componanet/appbarapp.dart';
// import 'package:gazhome/componanet/colors.dart';
// import 'package:gazhome/componanet/dialogapp.dart';
// import 'package:gazhome/provider/langlocal.dart';
// import 'package:gazhome/provider/prov.dart';
// import 'package:provider/provider.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapDriver extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MapDriver();
//   }
// }

// class _MapDriver extends State<MapDriver> {
//   // قائمة لتخزين خطوط المسار (Polyline)
//   Set<Polyline> _polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Provider.of<Control>(context, listen: false).getPosion();
//       Provider.of<Control>(context, listen: false).getLifeLocation();
//     });

//     // إنشاء مسار بين نقطتين (مثال)
//     _createRoute();
//   }

//   void _createRoute() {
//     // تعريف النقاط التي تشكل المسار
//     List<LatLng> points = [
//       LatLng( 26.5533448, 31.7007446), // النقطة الأولى (مثال)
//       LatLng(26.5536000, 31.7004560), // النقطة الثانية (مثال)
//     ];

//     // إنشاء Polyline
//     Polyline polyline = Polyline(
//       polylineId: PolylineId("route1"),
//       color: Colors.blue,
//       width: 5,
//       points: points,
//     );

//     // إضافة المسار إلى قائمة المسارات
//     setState(() {
//       _polylines.add(polyline);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ColorApp colorApp = ColorApp();
//     return Consumer<Control>(builder: (context, val, child) {
//       return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: AppBarBack(),
//           backgroundColor: colorApp.colorbody,
//         ),
//         backgroundColor: colorApp.colorbody,
//         body: val.kGooglePlex.target.latitude == 0.0
//             ? Center(child: CircularProgressIndicator())
//             : GoogleMap(
//                 mapType: MapType.hybrid,
//                 // markers: val.mymarkerdriver,
//                 initialCameraPosition: val.kGooglePlex,
//                 polylines: _polylines, // إضافة المسارات إلى الخريطة
//                 onMapCreated: (GoogleMapController controller) {
//                   val.gmc = controller;
//                   print(" loca${val.gmc}");
//                 },
//               ),
//       );
//     });
//   }
// }

