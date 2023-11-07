import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString('profile_image');
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', pickedFile.path);
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthenticationBloc>().state;

    if (authState is AuthenticationSuccess) {
      final user = authState.user;

      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 224, 155, 16),
                Color.fromARGB(255, 255, 233, 6)
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    backgroundImage: imagePath != null
                        ? kIsWeb
                            ? NetworkImage(imagePath!) as ImageProvider
                            : FileImage(File(imagePath!)) as ImageProvider
                        : AssetImage('assets/images/default-avatar.png'),
                    radius: 60.0,
                    child: imagePath == null
                        ? Icon(Icons.camera_alt,
                            size: 60.0, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  user.displayName ?? 'User',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                Text(
                  user.email ?? 'Email not available',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Text('Not authenticated or waiting for user data...'),
        ),
      );
    }
  }
}
