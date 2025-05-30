import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_app/Bloc/notes_bloc.dart';
import 'package:notes_firebase_app/firebase_options.dart';

import 'Constants/appConstants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => NoteBloc())],
      child: MaterialApp(initialRoute: App_Routes.ROUTE_HOMEPAGE,
          routes: App_Routes.getRoutes(),
          debugShowCheckedModeBanner: false),
    ),
  );
}
