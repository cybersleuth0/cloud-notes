import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_app/Bloc/notes_bloc.dart';
import 'package:notes_firebase_app/firebase_options.dart';
import 'package:notes_firebase_app/screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => NoteBloc())],
      child: MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false),
    ),
  );
}
