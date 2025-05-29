class NoteModel {
  int? id;
  String title;
  String desc;
  String createdAT;

  NoteModel({
    required this.title,
    required this.desc,
    required this.createdAT,
    this.id,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      desc: map['desc'],
      createdAT: map['createdAT'],
    );
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "desc": desc, "createdAT": createdAT};
  }
}
