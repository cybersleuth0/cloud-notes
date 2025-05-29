import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_app/Bloc/notes_state.dart';
import 'package:notes_firebase_app/Model/Models.dart';

import 'notes_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  FirebaseFirestore? firebaseFirestore;
  CollectionReference? collRef;

  NoteBloc() : super(NoteInitialState()) {
    on<AddNoteEvent>((event, emit) async {
      firebaseFirestore = FirebaseFirestore.instance;
      collRef = firebaseFirestore!.collection("notes");
      var res = await collRef!.add(
        NoteModel(
          title: event.noteModel.title,
          desc: event.noteModel.desc,
          createdAT: event.noteModel.createdAT,
        ).toMap(),
      );
      if (res.id.isNotEmpty) {
        QuerySnapshot mData = await collRef!.get();
        List<NoteModel> allNotes = [];

        for (QueryDocumentSnapshot eachnote
            in mData.docs) {
          allNotes.add(NoteModel.fromMap(eachnote.data() as Map<String, dynamic>));
        }
        emit(NoteSuccessState(notes: allNotes));
      } else {
        emit(NoteFailureState(errorMessage: "Something went wrong"));
      }
    });

    //get notes for when app starting
    on<GetInitialNotesEvent>((event, emit) async {
      firebaseFirestore = FirebaseFirestore.instance;
      collRef = firebaseFirestore!.collection("notes");

      QuerySnapshot mData = await collRef!.get();
      List<NoteModel> allNotes = [];

      for (QueryDocumentSnapshot eachnote
          in mData.docs) {
        allNotes.add(NoteModel.fromMap(eachnote.data() as Map<String, dynamic>));
      }
      emit(NoteSuccessState(notes: allNotes));
    });
  }
}
