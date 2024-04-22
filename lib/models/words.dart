class Word {
  int? id;
  String? enWord;
  String? arWord;
  String? description;
  int? priority;
  String? date;
  bool? favorite;

  Word(
      {this.arWord,
      this.date,
      this.description,
      this.enWord,
      this.favorite,
      this.id,
      this.priority});


      Word.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enWord = json['enWord'];
    arWord = json['arWord'];
    description = json['description'];
    priority = json['priority'];
    date = json['date'];
    favorite = json['favorite'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enWord'] = enWord;
    data['arWord'] = arWord;
    data['description'] = description;
    data['priority'] = priority;
    data['date'] = date;
    data['favorite'] = favorite;
    return data;
  }
}
