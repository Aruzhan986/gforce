import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gforce/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_event.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration(String label, IconData icon) {
      return InputDecoration(
        labelText: label,
        hintText: 'Enter your $label',
        prefixIcon: Icon(icon, color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.black,
      ),
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 224, 155, 16),
                        Color.fromARGB(255, 255, 233, 64)
                      ],
                    ),
                  ),
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
                        decoration: inputDecoration('Email', Icons.email),
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: _passwordController,
                        decoration: inputDecoration('Password', Icons.lock),
                        style: TextStyle(color: Colors.black),
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
                          foregroundColor: Colors.yellow,
                          backgroundColor: Colors.black,
                        ),
                        child: Text('Login'),
                      ),
                      SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registrationScreen');
                        },
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.black),
                        child: Text('Don’t have an account? Sign up'),
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
