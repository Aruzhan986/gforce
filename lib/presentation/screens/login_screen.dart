import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gforce/generated/locale_keys.g.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_event.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_state.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';
import 'package:flutter_gforce/utils/lang.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String label, IconData icon) {
      return InputDecoration(
        labelText: label,
        hintText: 'Enter your $label',
        prefixIcon: Icon(icon, color: PrimaryColors.Colorthree),
        labelStyle: TextStyle(color: PrimaryColors.Colorthree),
        hintStyle: TextStyle(color: PrimaryColors.Colorthree),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: PrimaryColors.Colorthree),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: PrimaryColors.Colorthree, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(LocaleKeys.Login.tr(),
              style: TextStyle(color: PrimaryColors.Colorthree)),
          backgroundColor: PrimaryColors.Colorthree,
          actions: [Lang()]),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthenticationSuccess) {
            Navigator.pushReplacementNamed(context, '/homeScreen');
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Container(
                  decoration:
                      BoxDecoration(gradient: PrimaryGradients.primaryGradient),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Center(
                        child: Image.asset(
                          'assets/images/gforce.png',
                          height: 120.0,
                        ),
                      ),
                      SizedBox(height: 48.0),
                      TextField(
                        controller: _emailController,
                        decoration:
                            inputDecoration(LocaleKeys.Email.tr(), Icons.email),
                        style: TextStyle(color: PrimaryColors.Colorthree),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: _passwordController,
                        decoration: inputDecoration(
                            LocaleKeys.Password.tr(), Icons.lock),
                        style: TextStyle(color: PrimaryColors.Colorthree),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthenticationBloc>(context).add(
                            SignInRequested(
                              _emailController.text,
                              _passwordController.text,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: PrimaryColors.Colortwo,
                          backgroundColor: PrimaryColors.Colorthree,
                        ),
                        child: Text(LocaleKeys.Log.tr()),
                      ),
                      SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registrationScreen');
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: PrimaryColors.Colorthree),
                        child: Text(LocaleKeys.Dont_have_an.tr()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
