import 'package:ApiApp/models/note-for-listing.dart';

class NoteService {

  List<NoteForListing> getNotesList () {
      return [
      new NoteForListing(
          noteId: "1",
          createDateTime: DateTime.now(),
          lastEditDateTime: DateTime.now(),
          notetitle: "Note 1"),
      new NoteForListing(
          noteId: "2",
          createDateTime: DateTime.now(),
          lastEditDateTime: DateTime.now(),
          notetitle: "Note 2"),
      new NoteForListing(
          noteId: "3",
          createDateTime: DateTime.now(),
          lastEditDateTime: DateTime.now(),
          notetitle: "Note 3"),
    ];
  }
}