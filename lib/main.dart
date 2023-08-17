import 'package:flutter/material.dart';
import 'package:mstock/provider/stock_provider.dart';
import 'package:mstock/repository/stock_repository.dart';
import 'package:mstock/screen/home_screen.dart';
import 'package:mstock/usecase/get_stock_usecase.dart';
import 'package:provider/provider.dart';

import 'color/color.dart';
import 'di/injection.dart';

void main() async {
  initLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) =>
              StockProvider(sl<StockRepository>(), sl<GetStockUseCase>())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      theme: ThemeData(
        primaryColor: ThemeColor.primary,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
        brightness: Brightness.dark,
      ),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
