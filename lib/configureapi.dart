import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:garmian_house_of_charity/Models/combinehistory.dart';
import 'package:garmian_house_of_charity/Models/donatedprofilesmodel.dart';
import 'package:http/http.dart' as http;

class ConfigureApi {
  final http.Client _httpClient;
  final Map<String, String> _defaultHeaders;
  final Uri _baseUri = Uri.parse("http://gch.aurorapro.org/api");
 static List<Donatedprofilesmodel>? mainProfilesList = [];
  static List<Donatedprofilesmodel>? subProfilesList = mainProfilesList;

  static List<CombinedHistories>? mainHistories = [];
  static List<CombinedHistories>? subHistories = mainHistories;


  ConfigureApi()
      : _httpClient = http.Client(),
        _defaultHeaders = {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Cookie": "ApiKey=D3ll7490",
        };
  Future<List<T>?> requestData<T>(
      String subUri, T Function(Map<String, dynamic>) fromJson) async {
    try {
      final Uri fullUri = Uri.parse('$_baseUri/$subUri');

      final response = await _httpClient.get(fullUri, headers: _defaultHeaders);
      debugPrint('response is ${response.reasonPhrase}');
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final List<dynamic> json = jsonDecode(responseBody);

        return json
            .map((item) => fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('exception from api response $e');
      return null;
    }
  }

  Future<String> post(String suburi, Object model) async {
    final body = json.encode(model);
    Uri uri = Uri.parse('$_baseUri/$suburi');
    // Send a POST request to the API
    final response = await http.post(
      uri,
      headers: _defaultHeaders,
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    return '-';
  }

  Future<bool> put(String suburi, Object model) async {
    final body = json.encode(model);
    Uri uri = Uri.parse('$_baseUri/$suburi');
    // Send a POST request to the API
    final response = await http.put(
      uri,
      headers: _defaultHeaders,
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> delete(String suburi, int id) async {
    Uri uri = Uri.parse('$_baseUri/$suburi/$id');
    // Send a POST request to the API
    final response = await http.delete(
      uri,
      headers: _defaultHeaders,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // ignore: non_constant_identifier_names
  Future<String> Login(String password) async {
    // Construct the full URL using the baseUri and subUri
    final Uri fullUri = Uri.parse('$_baseUri/home/Credentials');

    final response = await _httpClient.get(fullUri, headers: _defaultHeaders);
    if (response.statusCode == 200) {
      final responseBody = response.body;
      final String pass = jsonDecode(responseBody);
      return  pass;
    } else {
      return "-null";
    }
  }
}
