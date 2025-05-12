import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/app_button.dart';
import 'package:hwee_tawseel_driver/views/auth/widgets/app_bar_from_auth.dart';
import '../../../components/app_colors.dart';
import '../../../components/app_text_styles.dart';
import '../../constant.dart' as val;
import '../../prov/langlocal.dart';

class EditLocationView extends StatelessWidget {
   EditLocationView({super.key});
  LangLocal langLocal = new LangLocal();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: appBarFromAuth(context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Map', style: AppTextStyles.style32W400(context)),
                  ],
                ),
              ],
            ),
            Expanded(child: const SizedBox(height: 40)),
            AppButton(
              text:    "${langLocal.langLocal['Next']!['${val.languagebox.get("language")}']}",


              fun: () {},
            ),
          ],
        ),
      ),
    );
  }
}
