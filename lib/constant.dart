import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:hwee_tawseel_driver/prov/langlocal.dart';
LangLocal langLocal = new LangLocal();
late Box languagebox = Hive.box("language");
TextDirection direction = languagebox.get("language") == "ar" ?TextDirection.rtl :TextDirection.ltr;