import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_app/Bloc/Login_Bloc/login_bloc.dart';
import 'package:notes_firebase_app/Bloc/Notes_Bloc/notes_bloc.dart';
import 'package:notes_firebase_app/Bloc/Signup_Bloc/signup_bloc.dart';
import 'package:notes_firebase_app/firebase_options.dart';

import 'Constants/appConstants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteBloc()),
        BlocProvider(create: (context) => Signup_Bloc()),
        BlocProvider(create: (context) => LoginBloc())
      ],
      child: MaterialApp(initialRoute: App_Routes.ROUTE_SPLASHSCREEN,
          routes: App_Routes.getRoutes(),
          debugShowCheckedModeBanner: false),
    ),
  );
}
