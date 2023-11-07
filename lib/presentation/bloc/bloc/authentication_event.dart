import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;
  final String country;

  SignUpRequested(this.name, this.email, this.password, this.country);
}

class SignOutRequested extends AuthenticationEvent {}
