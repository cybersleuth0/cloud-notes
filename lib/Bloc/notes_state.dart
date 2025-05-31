import '../Model/Models.dart';

abstract class NoteState {}

class NoteInitialState extends NoteState {

}

class NoteLoadingState extends NoteState {}

class NoteSuccessState extends NoteState {
  List<NoteModel> notes;
  String? snackBarMsg;

  NoteSuccessState({required this.notes, this.snackBarMsg});
}

class NoteFailureState extends NoteState {
  String errorMessage;

  NoteFailureState({required this.errorMessage});
}
