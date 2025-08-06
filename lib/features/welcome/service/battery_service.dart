import 'dart:convert';

import 'package:edu_tara/core/api/api_constants.dart';
import 'package:http/http.dart' as http;

class BatteryService {
  static Future<Map<String, dynamic>> batteryOffline() async {
    String url = "${ApiConstants.localIp}${ApiConstants.batteryOffline}";
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();
    var respString = await response.stream.bytesToString();
    return json.decode(respString);
  }

  static Future<Map<String, dynamic>> battery({required String userId}) async {
    String url = "${ApiConstants.globalIP}${ApiConstants.battery}$userId/";
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();
    var respString = await response.stream.bytesToString();
    return json.decode(respString);
  }

  static Future<Map<String, dynamic>> getBatteryStatus() async {
    String url = "${ApiConstants.localIp}${ApiConstants.getBatteryStatus}";
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();
    var respString = await response.stream.bytesToString();
    print('offline battery response ${respString}');
    return json.decode(respString);
  }


}
