import 'package:flutter/material.dart';
import 'package:hwee_tawseel_driver/components/dilaogApp.dart';
import 'package:hwee_tawseel_driver/prov/prov.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import '../../../components/app_button.dart';
import '../../../components/app_colors.dart';
import '../../../constant.dart';
import '../../../constant.dart' as val;
import '../my_orders_view.dart';

class HomeOrderButtons extends StatelessWidget {
  const HomeOrderButtons({
    super.key,
    required this.homeButtonOnPressed,
    required this.id,
  });
  final VoidCallback homeButtonOnPressed;
  final int id;
  @override
  Widget build(BuildContext context) {
    return AppButton(
      color: AppColors.greenDark,
      text: "${langLocal.langLocal['bookRequest']!['${val.languagebox.get(
          "language")}']}",
      //fun: homeButtonOnPressed,
      fun: () {
        dateRecive(context, homeButtonOnPressed, id);
      },
    );
  }
}

DialogApp dialogApp = new DialogApp();

timeRecive(BuildContext context, VoidCallback homeButtonOnPressed, int id) {
  showTimePicker(
    helpText: "${langLocal.langLocal['selectPickupTime']!['${val.languagebox.get(
        "language")}']}",
    initialTime: TimeOfDay.now(),
    context: context,
  ).then((value) {
    if (value != null) {
      // val.chosestarttime(
      //     value.format(context).toString());

      //print(val.timestartnew);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<Control>(context, listen: false)
            .TimeRecive(value.format(context).toString());
      });
      dateFinish(context, homeButtonOnPressed, id);
    }
  });
}

timeFinish(BuildContext context, VoidCallback homeButtonOnPressed, int id) {
  showTimePicker(
    helpText:"${langLocal.langLocal['selectDeliveryTime']!['${val.languagebox.get(
        "language")}']}",
    initialTime: TimeOfDay.now(),
    context: context,
  ).then((value) async {
    if (value != null) {
      // val.chosestarttime(
      //     value.format(context).toString());

      //print(val.timestartnew);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<Control>(context, listen: false)
            .TimeFinish(value.format(context).toString());
      });

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<Control>(context, listen: false)
            .UpdateOrder(id, "bookOrder");
      });

      dialogApp.checkdialog(context, () {
        homeButtonOnPressed();
      });

      ///check dialog
      print('dddddd');
    }
  });
}

dateRecive(BuildContext context, VoidCallback homeButtonOnPressed, int id) {
  showDatePicker(
    helpText: "${langLocal.langLocal['selectPickupDate']!['${val.languagebox.get(
        "language")}']}",
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2050),
  ).then((value) {
    if (value != null) {
      // val.date = ;
      // val.date = Jiffy.parse('${value.toString()}').yMd;
      // val.changedatepationt();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<Control>(context, listen: false)
            .DateRecive(Jiffy.parse('${value.toString()}').yMd);
      });
      timeRecive(context, homeButtonOnPressed, id);
    }
  });
}

dateFinish(BuildContext context, VoidCallback homeButtonOnPressed, int id) {
  showDatePicker(
    helpText: "${langLocal.langLocal['selectDeliveryDate']!['${val.languagebox.get(
        "language")}']}",
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2050),
  ).then((value) {
    if (value != null) {
      // val.date = value.toString();
      // val.date = Jiffy.parse('${val.date}').yMd;
      // val.changedatepationt();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<Control>(context, listen: false)
            .DateFinish(Jiffy.parse('${value.toString()}').yMd);
      });
      timeFinish(context, homeButtonOnPressed, id);
    }
  });
}
