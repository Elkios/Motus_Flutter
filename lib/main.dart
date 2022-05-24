import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:motus_flutter/data/entities/word.dart';
import 'package:motus_flutter/ui/my_app.dart';
import 'package:motus_flutter/ui/screens/home/my_home_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MyHomeViewModel>(
      create: (_) => MyHomeViewModel(),
    ),
  ], child: const MyApp()));
}


