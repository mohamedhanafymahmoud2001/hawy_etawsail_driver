import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  ImageView({super.key, required this.image});
  late String image;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      '$image',
      width: double.infinity,
      height: 350,
      fit: BoxFit.contain,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        // في حال حدوث خطأ، يمكنك عرض صورة افتراضية
        return Image.asset(
          "assets/images/logo.png", // المسار إلى الصورة الافتراضية
          fit: BoxFit.cover,
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        // عرض مؤشر تحميل أثناء تحميل الصورة
        if (loadingProgress == null) return child;
        return Container(
          height: 350,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          ),
        );
      },
    );
  }
}
