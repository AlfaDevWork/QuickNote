
import 'package:flutter/material.dart';
import 'package:quicknote/database/db_helper.dart';
import 'package:quicknote/model/notes_model.dart';
import 'package:quicknote/screen/edit_notes.dart';


class DetailNotesScreen extends StatefulWidget {
  final Notes notes;
  const DetailNotesScreen({super.key, required this.notes});

  @override
  State<DetailNotesScreen> createState() => _DetailNotesScreenState();
}

class _DetailNotesScreenState extends State<DetailNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              width: 190,
              child: Text(widget.notes.nama, overflow: TextOverflow.ellipsis),
            ),
            Spacer(),
            IconButton(
              onPressed: () async {
                final konfirmasi = await showDialog<bool>(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: Text('Delete note?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
                if (konfirmasi == true) {
                  await DbHelper.deleteNotes(widget.notes.id!);
                  Navigator.pop(context, true);
                }
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(widget.notes.isi, style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(48)),
        ),
        backgroundColor: Color(0xffC4C4C4),
        onPressed: () async {
          final hasil = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditNotesScreen(notes: widget.notes),
            ),
          );
          if (hasil == true) {
            Navigator.pop(context, true);
          }
        },
        child: Image.asset('assets/images/Edit.png'),
      ),
    );
  }
}
