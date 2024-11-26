class MonthlyPaidModel {
  int id;
  String name;
  String moneyAmount;
  String date;

  MonthlyPaidModel({
    required this.id,
    required this.name,
    required this.moneyAmount,
    required this.date,
  });

  factory MonthlyPaidModel.fromJson(Map<String, dynamic> json) {
    return MonthlyPaidModel(
      id: json['id'] as int,
      name: json['name'] as String,
      moneyAmount: json['moneyAmount'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'moneyAmount': moneyAmount,
      'date': date,
    };
  }
}
