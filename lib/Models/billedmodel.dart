class BilledModel {
  int id;
  String kidName;
  String gender;
  String age;
  String apart;
  String city;
  String kidPhone;
  String manName;
  String money;
  String manPhone;
  String manAdress;
  String note;

  BilledModel({
    required this.id,
    required this.kidName,
    required this.gender,
    required this.age,
    required this.apart,
    required this.city,
    required this.kidPhone,
    required this.manName,
    required this.money,
    required this.manPhone,
    required this.manAdress,
    required this.note,
  });

  factory BilledModel.fromJson(Map<String, dynamic> json) {
    return BilledModel(
      id: json['id'] as int,
      kidName: json['kidName'] as String,
      gender: json['gender'] as String,
      age: json['age'] as String,
      apart: json['apart'] as String,
      city: json['city'] as String,
      kidPhone: json['kidPhone'] as String,
      manName: json['manName'] as String,
      money: json['money'] as String,
      manPhone: json['manPhone'] as String,
      manAdress: json['manAdress'] as String,
      note: json['note'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kidName': kidName,
      'gender': gender,
      'age': age,
      'apart': apart,
      'city': city,
      'kidPhone': kidPhone,
      'manName': manName,
      'money': money,
      'manPhone': manPhone,
      'manAdress': manAdress,
      'note': note,
    };
  }
}
