import 'package:notes_firebase_app/Model/Models.dart';

abstract class NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final NoteModel noteModel;
  AddNoteEvent({required this.noteModel});
}

class UpdateNoteEvent extends NoteEvent {
  NoteModel noteModel;

  UpdateNoteEvent({required this.noteModel});
}

class DeleteNoteEvent extends NoteEvent {
  String deleteID;

  DeleteNoteEvent({required this.deleteID});
}
class GetInitialNotesEvent extends NoteEvent{}