import 'package:edu_tara/core/utils/helper_function.dart';
import 'package:edu_tara/core/widgets/toast.dart';
import 'package:edu_tara/features/language/service/language_service.dart';
import 'package:edu_tara/features/welcome/controller/battery_controller.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  List<String> _languages = [];
  String _selectedLanguage = "";
  bool _isLoading = false;

  List<String> get languages => _languages;
  String get selectedLanguage => _selectedLanguage;
  bool get isLoading => _isLoading;

  /// Fetch all available languages from the API
  Future<void> fetchLanguages() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await LanguageService.fetchLanguages();
      _languages = List<String>.from(
        data['data'].map((item) => item['language']),
      );
    } catch (e) {
      debugPrint('Language Fetch Error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Set default/initial language
  Future<void> setInitialLanguage(String? defaultLang) async {
    _selectedLanguage = defaultLang ?? '';
    debugPrint('Currently selected language: $_selectedLanguage');
    notifyListeners();
  }

  /// Update selected language and sync with backend
  Future<void> updateLanguage({
    required String lang,
    required BuildContext context,
    required BatteryProvider batteryProvider,
    required String userId,
  }) async {
    _selectedLanguage = lang;
    notifyListeners();

    try {
      final response = await LanguageService.setLanguage(
        language: lang,
        robotId: roboId,
      );

      showTopRightToast(
        context: context,
        message: "Language updated successfully",
        color: Colors.green,
      );

      if (response['status'] == 'ok') {
        await batteryProvider.fetchOnlineBattery(userId);
      }
    } catch (e) {
      debugPrint('Update language error: $e');

      showTopRightToast(context: context, message: "$e", color: Colors.red);
    }
  }
}
