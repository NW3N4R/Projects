// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeHelper {
  final String apiUrl = 'http://p4165386.eero.online/api/home';

  Future<List<HomeModel>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => HomeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}

class HomeModel {
  final int Families;
  final int GavenRows;
  final int GavenMoney;
  final int Alone;
  final int Divorced;
  final int Disabled;
  final int Billed;
  final int LongSick;
  final int MonthlyPaid;
  final int Notes;
  final int Orphans;
  final int poors;
  final int surgery;
  final int written;
  final int wholedb;

  HomeModel({
    required this.Families,
    required this.GavenRows,
    required this.GavenMoney,
    required this.Alone,
    required this.Divorced,
    required this.Disabled,
    required this.Billed,
    required this.LongSick,
    required this.MonthlyPaid,
    required this.Notes,
    required this.Orphans,
    required this.poors,
    required this.surgery,
    required this.written,
    required this.wholedb,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      Families: json['famCount'],
      GavenRows: json['gavenCount'],
      GavenMoney: json['gavenMoney'],
      Alone: json['alone'],
      Divorced: json['divorced'],
      Disabled: json['disabled'],
      Billed: json['billed'],
      LongSick: json['longSick'],
      MonthlyPaid: json['monthlyPaid'],
      Notes: json['noteCount'],
      Orphans: json['orphans'],
      poors: json['poors'],
      surgery: json['surgeryCount'],
      written: json['writtenCount'],
      wholedb: json['wholeDb'],
    );
  }
}

// void main() async {
//   final apiHelper = HomeHelper();
//   final List<HomeModel> userDataList = await apiHelper.fetchData();

//   // Print the retrieved data
//   for (final userData in userDataList) {
//     print(userData.Families);
//   }
// }
