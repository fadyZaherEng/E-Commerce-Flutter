import 'package:flutter/material.dart';
import 'package:flutter_technical_task/layout/home_provider.dart';
import 'package:flutter_technical_task/layout/home_screen.dart';
import 'package:flutter_technical_task/modules/splash/splash_screen.dart';
import 'package:flutter_technical_task/shared/network/local/cashe_helper.dart';
import 'package:flutter_technical_task/shared/network/remote/dio_helper.dart';
import 'package:flutter_technical_task/shared/styles/themes.dart';
import 'package:flutter_technical_task/utils/translation.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  await Firebase.initializeApp();
  DioHelper.Init();
  if (SharedHelper.get(key: 'theme') == null) {
    SharedHelper.save(value: 'Dark Theme', key: 'theme');
  }
  if (SharedHelper.get(key: 'lang') == null) {
    SharedHelper.save(value: 'en', key: 'lang');
  }
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (a, b, c) =>
          ChangeNotifierProvider(
            create: (ctx) => HomeProvider()..getCategories(),
            child: GetMaterialApp(
              translations: myTranslation(),
              locale: Locale(SharedHelper.get(key: 'lang')),
              fallbackLocale: Locale(SharedHelper.get(key: 'lang')),
              debugShowCheckedModeBanner: false,
              darkTheme: darkTheme(),
              theme: lightTheme(),
              themeMode: SharedHelper.get(key: 'theme') == 'Light Theme'
                  ? ThemeMode.light : ThemeMode.dark,
              home: startScreen(),
            ),
          ),
    );
  }
}
//
Widget startScreen() {
  bool? signIn = SharedHelper.get(key: 'signIn');
  if (signIn!=null&&signIn == true) {
    return SplashScreen('home');
  }
  return SplashScreen('logIn');
}
