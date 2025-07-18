import 'package:flutter/material.dart';
import 'package:quicknote/database/db_helper.dart';
import 'package:quicknote/model/notes_model.dart';
import 'package:quicknote/pages/add_notes.dart';
import 'package:quicknote/pages/detail_notes.dart';

class HomePage extends StatefulWidget {
  static const String id = "/notes_page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Notes> daftarNotes = [];
  List<Notes> semuaNotes = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    muatData();
  }

  Future<void> muatData() async {
    final data = await DbHelper.getAllNotes();
    setState(() {
      daftarNotes = data;
      semuaNotes = data;
    });
  }

  void cariNotes(String query) {
    final hasil =
        semuaNotes.where((note) {
          final judul = note.nama.toLowerCase();
          final isi = note.isi.toLowerCase();
          final input = query.toLowerCase();
          return judul.contains(input) || isi.contains(input);
        }).toList();

    setState(() {
      daftarNotes = hasil;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: TextField(
                controller: _controller,
                onChanged: cariNotes,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffE5E5E5),
                  hintText: 'Search your notes',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon:
                      _controller.text.isNotEmpty
                          ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              cariNotes('');
                            },
                          )
                          : null,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffE5E5E5)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      // color: Color(0xffE5E5E5)
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            if (daftarNotes.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    _controller.text.isEmpty
                        ? 'No notes available'
                        : 'No matching result found',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: daftarNotes.length,
                itemBuilder: (context, index) {
                  final notes = daftarNotes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffE5E5E5),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: ListTile(
                        onTap: () async {
                          final hasil = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailNotesPage(notes: notes),
                            ),
                          );
                          if (hasil == true) muatData();
                        },
                        title: Row(
                          children: [
                            SizedBox(
                              width: 220,
                              child: Text(
                                notes.nama,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${notes.tanggal}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          notes.isi,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(48)),
          ),
          backgroundColor: Color(0xffC4C4C4),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddNotesPage()),
            );
            muatData();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
