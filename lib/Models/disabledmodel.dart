class DisabledModel {
  String name;
  String phone;
  String city;
  String apart;
  String famNum;
  String house;
  String life;
  String note;
  String personTitle;
  String disabledSort;

  DisabledModel({
    required this.name,
    required this.phone,
    required this.city,
    required this.apart,
    required this.famNum,
    required this.house,
    required this.life,
    required this.note,
    required this.personTitle,
    required this.disabledSort,
  });

  factory DisabledModel.fromJson(Map<String, dynamic> json) {
    return DisabledModel(
      name: json['name'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      apart: json['apart'] as String,
      famNum: json['famNum'] as String,
      house: json['house'] as String,
      life: json['life'] as String,
      note: json['note'] as String,
      personTitle: json['personTitle'] as String,
      disabledSort: json['disabledSort'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'city': city,
      'apart': apart,
      'famNum': famNum,
      'house': house,
      'life': life,
      'note': note,
      'personTitle': personTitle,
      'disabledSort': disabledSort,
    };
  }
}
