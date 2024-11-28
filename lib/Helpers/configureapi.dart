import 'dart:convert';
import 'package:http/http.dart' as http;

class ConfigureApi {
  final http.Client _httpClient;
  final Map<String, String> _defaultHeaders;
  final Uri _baseUri = Uri.parse("http://p4165386.eero.online/api");

  // Constructor initializes _httpClient and default headers
  ConfigureApi()
      : _httpClient = http.Client(),
        _defaultHeaders = {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Cookie":
              "ApiKey=D3ll7490", // Ensure the API key is included as a cookie
        };

  // Request method that takes a subUri and a function to convert JSON to a model (T)
  Future<List<T>?> requestData<T>(
      String subUri, T Function(Map<String, dynamic>) fromJson) async {
    try {
      // Construct the full URL using the baseUri and subUri
      final Uri fullUri = Uri.parse('$_baseUri/$subUri');

      // Perform the GET request with the headers (including the Cookie header for ApiKey)
      final response = await _httpClient.get(fullUri, headers: _defaultHeaders);

      // Check if the request was successful
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final List<dynamic> json = jsonDecode(responseBody);

        // Map the JSON to a list of objects of type T
        return json
            .map((item) => fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        // Handle non-2xx responses (e.g., 404, 500)
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> post(String suburi, Object model) async {
    final body = json.encode(model);
    Uri uri = Uri.parse('$_baseUri/$suburi');
    // Send a POST request to the API
    final response = await http.post(
      uri,
      headers: _defaultHeaders,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> put(String suburi, Object model) async {
    final body = json.encode(model);
    print(body);
    Uri uri = Uri.parse('$_baseUri/$suburi');
    // Send a POST request to the API
    final response = await http.put(
      uri,
      headers: _defaultHeaders,
      body: body,
    );
    print(response.body);
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> Login(String password) async {
    // Construct the full URL using the baseUri and subUri
    final Uri fullUri = Uri.parse('$_baseUri/home/Credentials');

    final response = await _httpClient.get(fullUri, headers: _defaultHeaders);
    if (response.statusCode == 200) {
      final responseBody = response.body;
      final String pass = jsonDecode(responseBody);
      return password == pass;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
