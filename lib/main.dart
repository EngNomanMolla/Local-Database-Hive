import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lesson_15/dashboard_screen.dart';
import 'package:lesson_15/home_page.dart';
import 'package:lesson_15/text_editing_value_adapter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
  // Register the custom adapter
  Hive.registerAdapter(TextEditingValueAdapter());
  await Hive.openBox('students');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}
