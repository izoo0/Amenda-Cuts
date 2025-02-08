import 'package:amenda_cuts/Provider/other_user_details_provider.dart';
import 'package:amenda_cuts/Provider/theme_provider.dart';
import 'package:amenda_cuts/Provider/user_details_provider.dart';
import 'package:amenda_cuts/Screens/SplashScreen/splash_screen.dart';
import 'package:amenda_cuts/Themes/dark_theme.dart';
import 'package:amenda_cuts/Themes/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider()..init(),
    ),
    ChangeNotifierProvider<UserDetailsProvider>(
      create: (context) => UserDetailsProvider()..init(),
    ),
    ChangeNotifierProvider<OtherUserDetailsProvider>(
      create: (context) => OtherUserDetailsProvider()..init(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.themeMode,
        theme: whiteTheme(),
        darkTheme: darkTheme(),
        home: const SplashScreen(),
      );
    });
  }
}
