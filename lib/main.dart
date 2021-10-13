import 'package:flutter/material.dart';
import 'package:mobile_pocket_app/business_logic/utils/theme_app.dart';

import 'views/ui/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Pcket App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MyColors.navy,
      ),
      home: MainPage(),
    );
  }
}
