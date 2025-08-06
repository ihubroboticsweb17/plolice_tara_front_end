import 'package:edu_tara/features/welcome/model/online_battery_model.dart';
import 'package:edu_tara/features/welcome/service/battery_service.dart';
import 'package:flutter/material.dart';

class BatteryProvider extends ChangeNotifier {
  BatteryModel? batteryModel;
  int batteryStatus = 0;

  Future<void> fetchOnlineBattery(String userID) async {
    try {
      final response = await BatteryService.battery(userId: userID);

      if (response['status'] == 'ok') {
        batteryModel = BatteryModel.fromJson(response);
      } else {
        batteryModel = null;
      }
    } catch (e) {
      batteryModel = null;
    }
  }
}
