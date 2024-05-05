class Word {
  int? id;
  String? enWord;
  String? arWord;
  String? description;
  String? date;
  int? favorite;

  Word(
      {this.arWord,
      this.date,
      this.description,
      this.enWord,
      this.favorite,
      this.id,
      });


      Word.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enWord = json['enWord'];
    arWord = json['arWord'];
    description = json['description'];
    date = json['date'];
    favorite = json['favorite'];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enWord'] = enWord;
    data['arWord'] = arWord;
    data['description'] = description;
    data['date'] = date;
    data['favorite'] = favorite;
    return data;
  }
}
