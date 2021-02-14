import 'dart:developer';

import 'package:ApiApp/models/note-for-listing.dart';
import 'package:ApiApp/services/note-service.dart';
import 'package:ApiApp/views/note-delete.dart';
import 'package:ApiApp/views/note-modify.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NoteService get service => GetIt.I<NoteService>();

  List<NoteForListing> notes = [];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    notes = service.getNotesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NoteModify(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_, __) => Divider(
          height: 1,
          color: Colors.green,
        ),
        itemBuilder: (_, index) {
          return Dismissible(
            key: ValueKey(notes[index].noteId),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {},
            confirmDismiss: (direction) async {
              final result = await showDialog(
                  context: context, builder: (_) => NoteDelete());
              return result;
            },
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.only(left: 16),
              child: Align(
                child: Icon(Icons.delete, color: Colors.white),
                alignment: Alignment.centerLeft,
              ),
            ),
            child: ListTile(
              title: Text(
                notes[index].notetitle,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                  'Last edited on ${formatDateTime(notes[index].lastEditDateTime)}'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => NoteModify(noteID: notes[index].noteId)));
              },
            ),
          );
        },
        itemCount: notes.length,
      ),
    );
  }
}
