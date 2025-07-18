import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Notes {
  final int? id;
  final String nama;
  final String isi;
  final String? tanggal;
  Notes({this.id, required this.nama, required this.isi, this.tanggal});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'isi': isi,
      'tanggal': tanggal,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      isi: map['isi'] as String,
      tanggal: map['tanggal'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) =>
      Notes.fromMap(json.decode(source) as Map<String, dynamic>);
}
