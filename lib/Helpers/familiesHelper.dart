import 'dart:convert';
import 'package:http/http.dart' as http;

class FamilyHelper {
  final String apiUrl = 'http://p4165386.eero.online/api/families';

  Future<List<FamilyModel>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => FamilyModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}

class FamilyModel {
  final int id;
  final String name;
  final String phone;
  final String city;
  final String apartment;
  final String house;
  final String life;
  final String famNo;
  final String note;

  FamilyModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.apartment,
    required this.house,
    required this.life,
    required this.famNo,
    required this.note,

  });

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    return FamilyModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      city: json['city'],
      apartment: json['apartment'],
      house: json['house'],
      life: json['life'],
      famNo: json['famNo'],
      note: json['note'],
    );
  }
}

