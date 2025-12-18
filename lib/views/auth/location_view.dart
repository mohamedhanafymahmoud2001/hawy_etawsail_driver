import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MyLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ColorsApp colorsApp = new ColorsApp();
    // DialogApp dialogApp = new DialogApp();
    // BottomSheetApp bottomSheetApp = new BottomSheetApp();
    return Consumer<Control>(builder: (context, val, child) {
      return Column(children: [
        Container(
          height: 60,
          width: double.infinity,
          color: Colors.white,
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.keyboard_arrow_left,color: Colors.black,)),
        ),
        val.kGooglePlexUser.target.latitude == 0.0
            ? Expanded(
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator())),
            )
            : Expanded(
              child: GoogleMap(
                  mapType: MapType.hybrid,
                  markers: val.mymarker,
                  initialCameraPosition: val.kGooglePlexUser,
                  onTap: (argument) {
                    val.pinMarcker(argument.latitude, argument.longitude);
                    val.long = argument.longitude;
                    val.lat = argument.latitude;
                    print("new location${val.lat}///${argument.latitude}");
                  },
                  onMapCreated: (GoogleMapController controller) {
                    // val.controller.complete(controller);
                    val.gmc = controller;
                    print(" loca${val.gmc}");
                  },
                ),
            ),
      ]);
    });
  }
}
