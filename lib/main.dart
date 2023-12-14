import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gforce/data/repository/authentication_firebase_provider.dart';
import 'package:flutter_gforce/data/repository/news_repository.dart';
import 'package:flutter_gforce/generated/codegen_loader.g.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/data_bloc/database_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_gforce/presentation/screens/splash_screen.dart';
import 'package:flutter_gforce/presentation/screens/home_screen.dart';
import 'package:flutter_gforce/presentation/screens/login_screen.dart';
import 'package:flutter_gforce/presentation/screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru'), Locale('kk')],
      path: 'assets/translation',
      fallbackLocale: Locale('en'),
      child: MyApp(),
      assetLoader: CodegenLoader()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationFirebaseProvider = AuthenticationFirebaseProvider();
    final newsProvider = NewsProvider();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(authenticationFirebaseProvider),
        ),
        BlocProvider<DatabaseBloc>(
          create: (context) => DatabaseBloc(newsProvider),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(color: Colors.black),
        ),
        home: SplashScreen(),
        routes: {
          '/loginScreen': (context) => LoginScreen(),
          '/registrationScreen': (context) => RegistrationScreen(),
          '/homeScreen': (context) => HomeScreen(),
        },
      ),
    );
  }
}
