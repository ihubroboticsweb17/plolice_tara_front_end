import 'dart:convert';

import 'package:edu_tara/core/api/api_constants.dart';
import 'package:edu_tara/core/utils/helper_function.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static fetchAndUpdateBaseUrl() async {
    try {

      String url = "${ApiConstants.globalIP}/robot/get-last-ip/$roboId/";

      print('url $url');

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        String? ipAddress = jsonResponse['data']['ip_address'];
        if (ipAddress != null) {
          await ApiConstants.updateBaseUrl(ipAddress);
        }
      }
    } catch (e) {
      print("Error fetching IP: $e");
    }
  }
}
