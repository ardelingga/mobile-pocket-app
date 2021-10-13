import 'package:flutter/material.dart';

import 'business_logic/utils/theme_app.dart';
import 'views/ui/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
