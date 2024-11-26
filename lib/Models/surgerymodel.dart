class SurgeryModel {
  int id;
  String name;
  String surgeryType;
  String money;
  String phone;
  String date;

  SurgeryModel({
    required this.id,
    required this.name,
    required this.surgeryType,
    required this.money,
    required this.phone,
    required this.date,
  });

  factory SurgeryModel.fromJson(Map<String, dynamic> json) {
    return SurgeryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      surgeryType: json['surgeryType'] as String,
      money: json['money'] as String,
      phone: json['phone'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surgeryType': surgeryType,
      'money': money,
      'phone': phone,
      'date': date,
    };
  }
}
