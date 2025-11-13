import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/AppStyle.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/core/source/local/PrefsManager.dart';
import 'package:evently_c16/model/Event.dart';
import 'package:evently_c16/providers/ThemeProvider.dart';
import 'package:evently_c16/providers/UserProvider.dart';
import 'package:evently_c16/ui/create_event/provider/create_event_provider.dart';
import 'package:evently_c16/ui/create_event/screen/create_event_screen.dart';
import 'package:evently_c16/ui/create_event/screen/pick_location_screen.dart';
import 'package:evently_c16/ui/event_details_screen/event_details_screen.dart';
import 'package:evently_c16/ui/event_details_screen/provider/event_details_provider.dart';
import 'package:evently_c16/ui/home/screen/home_screen.dart';
import 'package:evently_c16/ui/login/screen/login_screen.dart';
import 'package:evently_c16/ui/register/screen/register_screen.dart';
import 'package:evently_c16/ui/splash/screen/splash_screen.dart';
import 'package:evently_c16/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await PrefsManager.int();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("en"), Locale("ar")],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale("en"),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider()..init(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: provider.mode,
      initialRoute: RoutesManager.splash,
      debugShowCheckedModeBanner: false,
      routes: {
        RoutesManager.splash: (_) => const SplashScreen(),
        RoutesManager.start: (_) => const StartScreen(),
        RoutesManager.login: (_) => LoginScreen(),
        RoutesManager.register: (_) => RegisterScreen(),
        RoutesManager.home: (_) => ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const HomeScreen(),
        ),
        RoutesManager.createEvent: (context) {
          Event? event = ModalRoute.of(context)?.settings.arguments as Event?;
          return ChangeNotifierProvider(
            create: (context) => CreateEventProvider(),
            child: CreateEventScreen(event: event),
          );
        },
        RoutesManager.pickLocationScreen: (context) {
          CreateEventProvider provider =
              ModalRoute.of(context)?.settings.arguments as CreateEventProvider;
          return PickLocationScreen(provider: provider);
        },
        RoutesManager.eventDetailsScreen: (context) {
          Event event = ModalRoute.of(context)?.settings.arguments as Event;
          return ChangeNotifierProvider(
            create: (context) => EventDetailsProvider(),
            child: EventDetailsScreen(event: event),
          );
        },
      },
    );
  }
}
