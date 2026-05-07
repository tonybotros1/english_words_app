class Word {
  int? id;
  String? enWord;
  String? arWord;
  String? description;
  String? date;
  int? favorite;

  Word({
    this.arWord,
    this.date,
    this.description,
    this.enWord,
    this.favorite,
    this.id,
  });

  Word.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enWord = json['enword'] ?? json['enWord'];
    arWord = json['arword'] ?? json['arWord'];
    description = json['description'];
    date = json['date'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enword'] = enWord;
    data['arword'] = arWord;
    data['description'] = description;
    data['date'] = date;
    data['favorite'] = favorite ?? 0;
    return data;
  }

  bool get isFavorite => favorite == 1;
}
