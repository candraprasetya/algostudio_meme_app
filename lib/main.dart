import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MemeAlgoStudio',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/create', page: () => CreateScreen()),
        GetPage(name: '/download', page: () => DownloadScreen())
      ],
    );
  }
}
