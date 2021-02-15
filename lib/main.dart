import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'cubit/cubits.dart';
import 'screens/screens.dart';
import 'utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MemeCubit()),
          BlocProvider(create: (context) => ScreenCubit())
        ],
        child: BlocBuilder<ScreenCubit, ScreenState>(
          builder: (context, state) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                (state is ThemeDarkState) ? theme.darkTheme : theme.lightTheme,
            title: 'MemeAlgoStudio',
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => SplashScreen()),
              GetPage(name: '/home', page: () => HomeScreen()),
              GetPage(name: '/create', page: () => CreateScreen()),
              GetPage(name: '/download', page: () => DownloadScreen()),
              GetPage(name: '/share', page: () => ShareScreen())
            ],
          ),
        ));
  }
}
