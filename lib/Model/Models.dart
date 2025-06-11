import 'dart:ui';

class NoteModel {
  String? id;
  String title;
  String desc;
  String createdAT;
  int? bgColor;

  NoteModel({
    required this.title,
    required this.desc,
    required this.createdAT,
    this.id,
    this.bgColor
  });

  factory NoteModel.fromMap(Map<String, dynamic> map,{String? id}) {
    return NoteModel(
      id: id,
      title: map['title'],
      desc: map['desc'],
      createdAT: map['createdAT'],
        bgColor: map["bgColor"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "desc": desc,
      "createdAT": createdAT,
      "bgColor": bgColor
    };
  }
}
