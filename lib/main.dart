import 'package:flutter/material.dart';
import 'package:muslim_names/providers/category_provider.dart';
import 'package:muslim_names/providers/favorites_provider.dart';
import 'package:muslim_names/providers/names_provider.dart';
import 'package:muslim_names/screens/Splash%20Screen/splash_screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NameProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
