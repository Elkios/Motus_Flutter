import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:motus_flutter/ui/my_app.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}


