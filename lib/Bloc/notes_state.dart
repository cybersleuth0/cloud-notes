import '../Model/Models.dart';

abstract class NoteState {}

class NoteInitialState extends NoteState {

}

class NoteLoadingState extends NoteState {}

class NoteSuccessState extends NoteState {
  List<NoteModel> notes;
  NoteSuccessState({required this.notes});
}

class NoteFailureState extends NoteState {
  String errorMessage;

  NoteFailureState({required this.errorMessage});
}
