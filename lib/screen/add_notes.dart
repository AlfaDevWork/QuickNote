
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quicknote/database/db_helper.dart';
import 'package:quicknote/model/notes_model.dart';
import 'package:quicknote/utils/custom_elevated_button.dart';
import 'package:quicknote/utils/custom_text_field.dart';


class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController isiController = TextEditingController();

  Future<void> simpanData() async {
    if (_formKey.currentState!.validate()) {
      final nama = namaController.text;
      final isi = isiController.text;
      final tanggal = DateFormat('dd/MM/yyyy').format(DateTime.now());

      await DbHelper.insertNotes(Notes(nama: nama, isi: isi, tanggal: tanggal));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Notes'), backgroundColor: Colors.white),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: namaController,
              label: 'Title',
              validator: (value) => value == null || value.isEmpty
                  ? "You must fill out this field."
                  : null,
            ),
            CustomTextField(
              validator: (value) => value == null || value.isEmpty
                  ? "You must fill out this field."
                  : null,
              controller: isiController,
              label: 'Content',
              maxLines: 4,
            ),
            CustomElevatedButton(
              text: 'Add',
              onPressed: simpanData,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
