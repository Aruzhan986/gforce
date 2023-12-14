import 'package:flutter/material.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'GFORCE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PrimaryColors.Colortwo,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Lottie.asset(
              'assets/animation/phoenix.json',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: LinearProgressIndicator(
              backgroundColor: PrimaryColors.Colorsix,
              valueColor: AlwaysStoppedAnimation<Color>(
                PrimaryColors.Colortwo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
