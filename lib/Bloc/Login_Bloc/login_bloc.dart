import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_app/Bloc/Login_Bloc/login_event.dart';
import 'package:notes_firebase_app/Bloc/Login_Bloc/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialState()) {
    on<Login_BTN_Event>((event, emit) async {
      try {
        emit(LoadingState());
        UserCredential mUser = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: event.mail,
            password: event.passwd
        );
        if (mUser.user != null) {
          emit(SuccessState(snackMsg: "Login Successful!"));
          var prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(FailureState(errorMSG: "No user found for this email."));
          //print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          emit(
              FailureState(errorMSG: "Invalid credentials. Please try again."));
          //print('Wrong password provided for that user.');
        }
      }
    });
  }
}