import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gforce/data/repository/authentication_firebase_provider.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_event.dart';
import 'package:flutter_gforce/presentation/bloc/bloc/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationFirebaseProvider _authenticationFirebaseProvider;

  AuthenticationBloc(this._authenticationFirebaseProvider)
      : super(AuthenticationInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final userCredential = await _authenticationFirebaseProvider
            .signInWithEmailAndPassword(event.email, event.password);
        emit(AuthenticationSuccess(userCredential.user!));
      } on FirebaseAuthException catch (e) {
        emit(AuthenticationFailure(e.message ?? 'An unknown error occurred'));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthenticationLoading());
      try {
        final userCredential = await _authenticationFirebaseProvider.signUp(
            event.name, event.email, event.password, event.country);
        userCredential.user?.sendEmailVerification();
        emit(AuthenticationSuccess(userCredential.user!));
      } on FirebaseAuthException catch (e) {
        emit(AuthenticationFailure(e.message ?? 'An unknown error occurred'));
      }
    });
    on<SignOutRequested>((event, emit) async {
      await _authenticationFirebaseProvider.signOut();
      emit(AuthenticationInitial());
    });
  }
}
