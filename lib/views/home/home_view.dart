import 'package:flutter/material.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  HomeView(
      {super.key,
      required this.onPressedHomeButton,
      required this.onPressedHomeButtonDetails});

  final Function() onPressedHomeButton;
  final Function() onPressedHomeButtonDetails;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8),
            HomeViewBody(
              onPressedHomeButton: onPressedHomeButton,
              onPressedHomeButtonDetails: onPressedHomeButtonDetails,
            )
          ],
        ),
      ),
    );
  }
}
