import 'package:chat_messanger/src/core/constants/constants_export.dart';
import 'package:chat_messanger/src/features/authentication/authentication_export.dart';
import 'package:chat_messanger/src/features/home/presentation/home_screen/home_screen.dart';
import 'package:chat_messanger/src/features/splash/presentation/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'firebase_options.dart';
import 'src/application/application_export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    SplashScreen(
      key: UniqueKey(),
      onInitializationComplete: () => runApp(
        const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProviderService>(
          create: (BuildContext context) => AuthenticationProviderService(),
        ),
      ],
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          breakpoints: [
            const ResponsiveBreakpoint.resize(350, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(600,
                name: TABLET, scaleFactor: 1.25),
            const ResponsiveBreakpoint.resize(800, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(1200,
                name: 'XL', scaleFactor: 1.2),
            const ResponsiveBreakpoint.autoScale(1700, name: '4K'),
          ],
        ),
        debugShowCheckedModeBanner: false,
        title: 'Chatify',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.appPrimaryBackgroundColor,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.appSecondaryBackgroundColor,
          ),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext context) => const LoginScreen(),
          '/register': (BuildContext context) => const RegisterScreen(),
          '/home': (BuildContext context) => const HomeScreen(),
        },
      ),
    );
  }
}
