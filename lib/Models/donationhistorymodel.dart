import 'package:intl/intl.dart';

class DonationHistoryModel {
  final int id;
  final double amount;
  final String note;
  final DateTime givingDate;
  final int pid;
  final String? fixedDate;

  DonationHistoryModel({
    required this.id,
    required this.amount,
    required this.note,
    required this.givingDate,
    required this.pid,
    this.fixedDate
  });

  factory DonationHistoryModel.fromJson(Map<String, dynamic> json) {
    DateTime parsedDateTime = DateTime.parse(json['givingDate'] as String);
  String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDateTime);
  DateTime givingDate = DateTime.parse(formattedDate);
    return DonationHistoryModel(
      id: json['id'] as int,
      amount:  (json['amount'] as num).toDouble(), // Convert amount to double
      note: json['note'] as String,
      givingDate: givingDate,
      fixedDate: formattedDate,
      pid: json['pid'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'note': note,
      'givingDate': DateFormat("yyyy-MM-dd").format(givingDate),
      'pid': pid,
    };
  }
}
