import 'package:edu_tara/core/widgets/toast.dart';
import 'package:edu_tara/features/complaint_screen/model/complaint_model.dart';
import 'package:edu_tara/features/complaint_screen/service/comlaint_service.dart';
import 'package:flutter/material.dart';

class ComplaintController with ChangeNotifier {
  final ComplaintService _service = ComplaintService();

  bool _isLoadingForFetch = false;
  bool get isLoadingForFetch => _isLoadingForFetch;

  bool _isLoadingForCreate = false;
  bool get isLoadingForCreate => _isLoadingForCreate;



  bool _isLoadingForfetchDetails = false;
  bool get isLoadingForfetchDetails => _isLoadingForfetchDetails;

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;

  List<Data> _complaints = [];
  List<Data> get complaints => _complaints;

  Future<void> fetchComplaints(int userId) async {
    try {
      _isLoadingForFetch = true;
      notifyListeners();

      _complaints = await _service.getComplaints(userId);
    } catch (e) {
      print("Error fetching complaints: $e");
      _complaints = []; // fallback
    } finally {
      _isLoadingForFetch = false;
      notifyListeners();
    }
  }

  Future createComplaint(
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    _isLoadingForCreate = true;
    notifyListeners();
    Map response = await _service.createComplaint(data);

    _isLoadingForCreate = false;
    notifyListeners();

    if (response['status'] == "ok") {
      Navigator.pop(context);
      showTopRightToast(
        context: context,
        message: "Complaint submitted successfully",
        color: Colors.green,
      );

      return true;
    } else {
      showTopRightToast(
        context: context,
        message: response['message'] ?? "Submission failed",
        color: Colors.red,
      );
      return false;
    }
  }

 














  Future<bool> editComplaint(String id, Map<String, dynamic> data) async {
    return await _service.editComplaint(id, data);
  }

  Future<void> toggleSpeaking(bool status) async {
    final result = await _service.setSpeakingStatus(status);
    if (result) {
      _isSpeaking = status;
      notifyListeners();
    }
  }

  Future<void> loadSpeakingStatus() async {
    final list = await _service.getSpeakingStatus();
    if (list.isNotEmpty) {
      _isSpeaking = list.last['is_speaking'];
      notifyListeners();
    }
  }
}
