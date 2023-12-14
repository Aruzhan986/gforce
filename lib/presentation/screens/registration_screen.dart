import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gforce/generated/locale_keys.g.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_event.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_state.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';
import 'package:flutter_gforce/utils/lang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  void _showSuccessAndNavigate(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text(
                LocaleKeys.Success.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            LocaleKeys.Registration_Successful.tr(),
            style: TextStyle(
              color: PrimaryColors.Colorthree,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: PrimaryColors.Colorfive,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: PrimaryColors.Colorfour,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToHomeScreen(context);
              },
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: 10),
          elevation: 24.0,
          backgroundColor: PrimaryColors.Colorfour,
        );
      },
    );
  }

  void _navigateToHomeScreen(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRegistered', true);
    await prefs.setString('name', _nameController.text);
    await prefs.setString('country', _countryController.text);
    Navigator.pushReplacementNamed(context, '/homeScreen');
  }

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: PrimaryColors.Colorthree),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: PrimaryColors.Colorthree),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: PrimaryColors.Colorthree),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: PrimaryColors.Colorthree),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(LocaleKeys.Registration.tr(),
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          actions: [Lang()]),
      body: Container(
        decoration: BoxDecoration(gradient: PrimaryGradients.primaryGradient),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(state.message, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.black,
              ));
            }
            if (state is AuthenticationSuccess) {
              _showSuccessAndNavigate(context);
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
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 32),
                        Center(
                          child: Image.asset(
                            'assets/images/gforce.png',
                            height: 120,
                          ),
                        ),
                        SizedBox(height: 32),
                        TextField(
                          controller: _nameController,
                          decoration:
                              _buildInputDecoration(LocaleKeys.Full_Name.tr()),
                          style: TextStyle(color: PrimaryColors.Colorthree),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _emailController,
                          decoration:
                              _buildInputDecoration(LocaleKeys.Email.tr()),
                          style: TextStyle(color: PrimaryColors.Colorthree),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _countryController,
                          decoration: _buildInputDecoration('Country'),
                          style: TextStyle(color: PrimaryColors.Colorthree),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          decoration:
                              _buildInputDecoration(LocaleKeys.Password.tr()),
                          style: TextStyle(color: PrimaryColors.Colorthree),
                          obscureText: true,
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: PrimaryColors.Colortwo,
                            backgroundColor: PrimaryColors.Colorthree,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: state is! AuthenticationLoading
                              ? () {
                                  if (_validateInputs()) {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(
                                      SignUpRequested(
                                        _nameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                        _countryController.text,
                                      ),
                                    );
                                  }
                                }
                              : null,
                          child: Text(LocaleKeys.Register.tr()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (_nameController.text.isEmpty) {
      return false;
    }
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      return false;
    }

    return true;
  }
}
