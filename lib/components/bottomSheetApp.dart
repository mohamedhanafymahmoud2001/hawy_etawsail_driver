import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BottomSheetApp {
  void showPicker(BuildContext context, String type) {
    showModalBottomSheet(
        context: context,
        builder: (_) => Consumer<Control>(builder: (context, val, child) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'اختر طريقة تحميل الصورة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade50,
                          child: Icon(Icons.photo_camera, color: Colors.blue),
                        ),
                        title: Text('التقاط صورة بالكاميرا'),
                        onTap: () {
                          val.pickImage(ImageSource.camera, type);
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade50,
                          child: Icon(Icons.photo_library, color: Colors.green),
                        ),
                        title: Text('اختيار من المعرض'),
                        onTap: () {
                          val.pickImage(ImageSource.gallery, type);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
