
import 'package:flutter/material.dart';
import 'package:quicknote/database/db_helper.dart';
import 'package:quicknote/model/notes_model.dart';
import 'package:quicknote/utils/custom_elevated_button.dart';
import 'package:quicknote/utils/custom_text_field.dart';

class EditNotesPage extends StatefulWidget {
  final Notes notes;
  const EditNotesPage({super.key, required this.notes});

  @override
  State<EditNotesPage> createState() => _EditNotesPageState();
}

class _EditNotesPageState extends State<EditNotesPage> {
  late TextEditingController namaController;
  late TextEditingController isiController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    namaController = TextEditingController(text: widget.notes.nama);
    isiController = TextEditingController(text: widget.notes.isi);
    super.initState();
  }

  void update() async {
    final updated = Notes(
      id: widget.notes.id,
      nama: namaController.text,
      isi: isiController.text,
      tanggal: widget.notes.tanggal,
    );
    await DbHelper.updateNotes(updated);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Edit ${widget.notes.nama}'),
        ),
        body: Column(
          children: [
            CustomTextField(
              controller: namaController,
              label: 'Title',
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? "You must fill out this field."
                          : null,
            ),
            CustomTextField(
              controller: isiController,
              label: 'Content',
              maxLines: 4,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? "You must fill out this field."
                          : null,
            ),
            CustomElevatedButton(
              text: 'Update',
              onPressed: () {
                if (_formKey.currentState!.validate()) update();
              },
              backgroundColor: Colors.black,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
