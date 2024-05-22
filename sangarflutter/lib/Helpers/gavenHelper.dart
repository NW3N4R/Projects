import 'dart:convert';
import 'package:http/http.dart' as http;

class GavenHelper {
  final String apiUrl = 'http://p4165386.eero.online/api/gaven';

  Future<List<UserData>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => UserData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}

class UserData {
  final int id;
  final String name;
  final String money;
  final String note;
  final String year;
  final String month;
  final String day;
  final String address;
  final String phoneNo;
  final String date;

  UserData({
    required this.id,
    required this.name,
    required this.money,
    required this.note,
    required this.year,
    required this.month,
    required this.day,
    required this.address,
    required this.phoneNo,

  }): date = '$year' + ' - $month - ' + '$day';

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      money: json['money'],
      note: json['note'],
      year: json['year'],
      month: json['month'],
      day: json['day'],
      address: json['address'],
      phoneNo: json['phoneNo'],
    );
  }
}
