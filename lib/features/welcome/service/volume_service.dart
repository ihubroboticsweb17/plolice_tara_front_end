import 'dart:convert';

import 'package:edu_tara/core/api/api_constants.dart';
import 'package:http/http.dart' as http;

class VolumeService {
  static Future<Map<String, dynamic>> setVolume({
    required String roboid,
    required int volume,
  }) async {
    String url =
        "${ApiConstants.localIp}${ApiConstants.setVolume}$roboid/$volume/";
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();
    var respString = await response.stream.bytesToString();
    return json.decode(respString);
  }

  static Future<Map<String, dynamic>> getVolume({
    required String roboid,
  }) async {
    String url = "${ApiConstants.localIp}${ApiConstants.getVolume}$roboid/";
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();
    var respString = await response.stream.bytesToString();
    print('volume_response $respString');
    return json.decode(respString);
  }
}
