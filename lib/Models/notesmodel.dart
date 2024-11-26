class NotesModel {
  String name;
  String phone;
  String note;
  String year;
  String month;
  String day;
  String money;

  NotesModel({
    required this.name,
    required this.phone,
    required this.note,
    required this.year,
    required this.month,
    required this.day,
    required this.money,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      name: json['name'] as String,
      phone: json['phone'] as String,
      note: json['note'] as String,
      year: json['year'] as String,
      month: json['month'] as String,
      day: json['day'] as String,
      money: json['money'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'note': note,
      'year': year,
      'month': month,
      'day': day,
      'money': money,
    };
  }
}
