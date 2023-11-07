import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_event.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_state.dart';
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
                'Success',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Registration Successful!',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToHomeScreen(context);
              },
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: 10),
          elevation: 24.0,
          backgroundColor: Colors.white,
        );
      },
    );
  }

  void _navigateToHomeScreen(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRegistered', true);

    Navigator.pushReplacementNamed(context, '/homeScreen');
  }

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 224, 155, 16),
              Color.fromARGB(255, 255, 233, 64),
            ],
          ),
        ),
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
                          decoration: _buildInputDecoration('Full Name'),
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _emailController,
                          decoration: _buildInputDecoration('Email'),
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _countryController,
                          decoration: _buildInputDecoration('Country'),
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          decoration: _buildInputDecoration('Password'),
                          style: TextStyle(color: Colors.black),
                          obscureText: true,
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.yellow,
                            backgroundColor: Colors.black,
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
                          child: Text('Register'),
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
