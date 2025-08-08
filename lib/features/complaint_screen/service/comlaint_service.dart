import 'dart:convert';
import 'package:edu_tara/core/api/api_constants.dart';
import 'package:edu_tara/features/complaint_screen/model/complaint_model.dart';
import 'package:http/http.dart' as http;

class ComplaintService {
  Future<List<Data>> getComplaints(int userId) async {
    final url = Uri.parse(
      '${ApiConstants.globalIP}${ApiConstants.complaintsList}$userId',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final ComplaintModel complaintModel = ComplaintModel.fromJson(jsonData);

      return complaintModel.results?.data ?? [];
    } else {
      return []; // or throw an exception
    }
  }

  static Future<Map<String, dynamic>?> getComplaintDetail(String id) async {
    final url = Uri.parse(
      '${ApiConstants.globalIP}${ApiConstants.getComplaintDetail}$id/',
    );
    final response = await http.get(url);

    print('detailsresponse ${response.body}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
      return null;
    }
  }

  Future<Map<String, dynamic>> createComplaint(
    Map<String, dynamic> data,
  ) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.globalIP}${ApiConstants.createComplaint}',
      );
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      return jsonDecode(response.body);
    } catch (e) {
      print('error $e');
      throw Exception('Failed to create complaint: $e');
    }
  }

  editComplaint(String id, Map<String, dynamic> data) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.globalIP}${ApiConstants.editComplaint}$id/',
      );
      final response = await http.put(
        url,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print('error $e');
      throw Exception('Failed to edit complaint: $e');
    }
  }

static  setSpeakingStatus(bool status) async {
    final url = Uri.parse(
      '${ApiConstants.globalIP}${ApiConstants.createSpeak}',
    );
    final response = await http.post(
      url,
      body: jsonEncode({'is_speaking': status}),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  static getSpeakingStatus() async {
    final url = Uri.parse(
      '${ApiConstants.globalIP}${ApiConstants.getCurrentSpeak}',
    );
    final response = await http.get(url);
    return jsonDecode(response.body);
  }
}
