import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_gforce/presentation/screens/splash_screen.dart';
import 'package:flutter_gforce/presentation/screens/home_screen.dart';
import 'package:flutter_gforce/presentation/screens/login_screen.dart';
import 'package:flutter_gforce/presentation/screens/registration_screen.dart';

import 'package:flutter_gforce/data/providers/authentication_firebase_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationFirebaseProvider = AuthenticationFirebaseProvider();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(authenticationFirebaseProvider),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
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
