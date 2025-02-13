import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../exception.dart';

abstract class ApiServices {
  Future<dynamic> get(String url, Map<String, String>? headers);
}

class ApiServicesImpl extends ApiServices {
  @override
  Future<dynamic> get(String url, Map<String, String>? headers) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception(response);
      }
    } on SocketException {
      throw InternetException('No Internet');
    } on RequestTimeOut {
      throw RequestTimeOut('Request Timeout');
    }
  }
}
