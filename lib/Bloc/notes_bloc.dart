import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_app/Bloc/notes_state.dart';
import 'package:notes_firebase_app/Model/Models.dart';

import 'notes_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  /// This variable represents a reference to the "notes" collection in Firebase Firestore.
  /// It is used to interact with the Firestore database for operations like adding and retrieving notes.
  CollectionReference? notesCollection = FirebaseFirestore.instance.collection(
      "notes");

  NoteBloc() : super(NoteInitialState()) {
    on<AddNoteEvent>((event, emit) async {
      var res = await notesCollection!.add(
          event.noteModel.toMap()
      );
      if (res.id.isNotEmpty) {
        QuerySnapshot mData = await notesCollection!.get();

        List<NoteModel> allNotes = mData.docs.map((eachNote) {
          return NoteModel.fromMap(
              eachNote.data() as Map<String, dynamic>, // Document data
              id: eachNote.id); // Firestore document ID
        }).toList();

        emit(NoteSuccessState(notes: allNotes));
      } else {
        emit(NoteFailureState(errorMessage: "Note not added"));
      }
    });

    //get notes for when app starting
    on<GetInitialNotesEvent>((event, emit) async {
      QuerySnapshot mData = await notesCollection!.get();

      List<NoteModel> allNotes = mData.docs.map((eachnote) {
        return NoteModel.fromMap(
            eachnote.data() as Map<String, dynamic>,
            id: eachnote.id);
      }).toList();

      emit(NoteSuccessState(notes: allNotes));
    });

    on<DeleteNoteEvent>((event, emit) {
      print("delete event called ${event.deleteID}");
    });
  }
}
