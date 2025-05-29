import 'package:notes_firebase_app/Model/Models.dart';

abstract class NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final NoteModel noteModel;
  AddNoteEvent({required this.noteModel});
}

class UpdateNoteEvent extends NoteEvent {
  UpdateNoteEvent({required NoteModel noteModel});
}

class DeleteNoteEvent extends NoteEvent {
  DeleteNoteEvent({required int deleteID});
}
class GetInitialNotesEvent extends NoteEvent{}