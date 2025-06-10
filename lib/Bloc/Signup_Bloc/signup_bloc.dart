import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_app/Bloc/Signup_Bloc/signup_event.dart';
import 'package:notes_firebase_app/Bloc/Signup_Bloc/signup_state.dart';

class Signup_Bloc extends Bloc<Signup_Event, Signup_State> {
  Signup_Bloc() : super(Initial_State()) {
    on<SignupBTN_Event>((event, emit) async {
      emit(Loading_State());
      try {
        UserCredential mUser = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: event.mail,
              password: event.passwd,
            );
        FirebaseFirestore.instance.collection("users").doc(mUser.user!.uid).set(
          {
            "email": event.mail,
            "name": event.name,
            "createdAT": DateTime
                .now()
                .millisecondsSinceEpoch,
          },
        );
        if (mUser.user != null) {
          emit(Success_State(snackMsg: "Signup Successful!"));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(Failure_State(errorMSG: "The password provided is too weak."));
        } else if (e.code == 'email-already-in-use') {
          emit(
            Failure_State(
              errorMSG: "The account already exists for that email.",
            ),
          );
        }
      } catch (e) {
        emit(Failure_State(errorMSG: "$e"));
      }
    });
  }
}
