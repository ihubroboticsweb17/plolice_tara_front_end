import 'package:edu_tara/features/welcome/service/volume_service.dart';
import 'package:flutter/material.dart';

class VolumeController extends ChangeNotifier {
  bool isLoading = false;
  int currentVolume = 0;

  // Fetch current volume from server
  Future<void> fetchVolume(String roboId) async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await VolumeService.getVolume(roboid: roboId);
      currentVolume = data['current_volume'] ?? 0; // ✅ updated key
    } catch (e) {
      print("Error fetching volume: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // Update volume on the server
  Future<void> updateVolume(String roboId, int volume) async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await VolumeService.setVolume(
        roboid: roboId,
        volume: volume,
      );
      currentVolume = data['current_volume'] ?? volume; // ✅ updated key
    } catch (e) {
      print("Error updating volume: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
