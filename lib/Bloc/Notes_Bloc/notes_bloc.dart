import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_app/Bloc/Notes_Bloc/notes_state.dart';
import 'package:notes_firebase_app/Model/Models.dart';

import 'notes_event.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  /// This variable represents a reference to the "notes" collection in Firebase Firestore.
  /// It is used to interact with the Firestore database for operations like adding and retrieving notes.
  CollectionReference? notesCollection = FirebaseFirestore.instance.collection(
      "notes");

  NoteBloc() : super(NoteInitialState()) {

    // Handles the addition of a new note.
    on<AddNoteEvent>((event, emit) async {
      // Add the new note to Firestore.
      var res = await notesCollection!.add(
          event.noteModel.toMap()
      );
      // Check if the note was added successfully.
      if (res.id.isNotEmpty) {
        // The following commented-out code is an alternative way to fetch all notes.
        //QuerySnapshot mData = await notesCollection!.get();
        // List<NoteModel> allNotes = mData.docs.map((eachNote) {
        //   return NoteModel.fromMap(
        //       eachNote.data() as Map<String, dynamic>, // Document data
        //       id: eachNote.id); // Firestore document ID
        // }).toList();

        // Fetch all notes after adding the new one.
        List<NoteModel>allNotes = await fetchNotes();

        // Emit a success state with the updated notes and a success message.
        emit(NoteSuccessState(
            notes: allNotes, snackBarMsg: "Note added successfully !!"));
      } else {
        // If the note was not added, emit a failure state.
        emit(NoteFailureState(errorMessage: "Note not added"));
      }
    });

    //get notes for when app starting
    on<GetInitialNotesEvent>((event, emit) async {
      // Fetch initial notes from Firestore.
      // QuerySnapshot mData = await notesCollection!.get();
      //
      // List<NoteModel> allNotes = mData.docs.map((eachnote) {
      //   return NoteModel.fromMap(
      //       eachnote.data() as Map<String, dynamic>,
      //       id: eachnote.id);
      // }).toList();
      // Fetch all notes using the helper method.
      List<NoteModel>allNotes = await fetchNotes();
      // Emit a success state with the fetched notes.
      emit(NoteSuccessState(notes: allNotes));
    });

    // Handles the deletion of a note.
    on<DeleteNoteEvent>((event, emit) async {
      print("delete event called ${event.deleteID}");
      try {
        // Attempt to delete the note document from Firestore.
        await notesCollection?.doc(event.deleteID).delete();
        // The following commented-out code is an alternative way to fetch all notes after deletion.
        // QuerySnapshot mData = await notesCollection!.get();
        // List<NoteModel> allNotes = mData.docs.map((eachNote) {
        //   return NoteModel.fromMap(
        //       eachNote.data() as Map<String, dynamic>,
        //       id: eachNote.id); // Firestore document ID
        // }).toList();
        // Fetch the updated list of notes.
        List<NoteModel>allNotes = await fetchNotes();
        // Emit a success state with the updated notes and a success message.
        emit(NoteSuccessState(
            notes: allNotes, snackBarMsg: "Note deleted successfully !!"));
      } catch (e) {
        // If an error occurs, emit a failure state with an error message.
        emit(
            NoteFailureState(errorMessage: "Note not deleted ${e.toString()}"));
      }
    });
    // Handle the UpdateNoteEvent to update an existing note
    on<UpdateNoteEvent>((event, emit) async {
      try {
        // Update the note document in Firestore with the new data
        await notesCollection!.doc(event.noteModel.id).update(
            event.noteModel.toMap());

        // The following commented-out code is an alternative way to fetch all notes
        // QuerySnapshot mData = await notesCollection!.get();
        // List<NoteModel> allNotes = mData.docs.map((eachNote) {
        //   return NoteModel.fromMap(
        //       eachNote.data() as Map<String, dynamic>);
        // }).toList();

        // Fetch all notes after the update
        List<NoteModel>allNotes = await fetchNotes();
        // Emit a success state with the updated list of notes and a success message
        emit(NoteSuccessState(
            notes: allNotes, snackBarMsg: "Note Updated Successfully!!"));
      } catch (e) {
        // Emit a failure state if an error occurs during the update
        emit(NoteFailureState(
            errorMessage: "Note not updated !! ${e.toString()}"));
      }
    });
  }

  /// Fetches all notes from the Firestore "notes" collection.
  ///
  /// This method performs the following actions:
  /// 1. Retrieves a [QuerySnapshot] from the `notesCollection`.
  /// 2. Maps each document in the snapshot to a [NoteModel] object.
  ///    - It uses the `NoteModel.fromMap` factory constructor.
  ///    - It casts the document data to `Map<String, dynamic>`.
  ///    - It passes the document ID to the `NoteModel`.
  /// 3. Converts the resulting iterable of [NoteModel] objects to a [List].
  /// 4. Returns the list of all notes.
  ///
  /// Returns a [Future] that completes with a [List] of [NoteModel].
  Future<List<NoteModel>> fetchNotes() async {
    // Get all documents from the "notes" collection.
    QuerySnapshot mData = await notesCollection!.get();

    // Map each document to a NoteModel.
    List<NoteModel> allNotes = mData.docs.map((eachnote) {
      return NoteModel.fromMap(
          eachnote.data() as Map<String, dynamic>, // The data of the document.
          id: eachnote.id // The ID of the document.
          );
    }).toList(); // Convert the mapped iterable to a list.

    return allNotes; // Return the list of notes.
  }
}
