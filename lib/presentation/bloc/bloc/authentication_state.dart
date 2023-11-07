import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User user;

  AuthenticationSuccess(this.user);
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure(this.message);
}
