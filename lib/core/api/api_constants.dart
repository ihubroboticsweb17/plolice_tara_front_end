class ApiConstants {
  static String ip = "192.168.1.26";

  static String defaultBaseUrl1 = "http://$ip:8000";
  static String localIp = defaultBaseUrl1;

  static String globalIP = "http://3.88.46.127";

  static Future<void> updateBaseUrl(String newIp) async {
    String newUrl = "http://$newIp:8000";
    ip = newIp;
    print('newIP $newIp');
    localIp = newUrl;
  }

  // language
  static String getLanguage = "/robot/languages/list/";
  static String setLanguage = "/robot/update-robots/";

  // battery online and offline
  static String batteryOffline = "/robot-battery/list/";
  static String battery = "/robot/sale/user/list/";
  static String getBatteryStatus = "/charging/get/";

  // Module & PDF
  static const String uploadPdf = '/upload-pdf/';
  static const String pdfList = '/pdfs/list/';
  static const String pdfEdit = '/pdfs/edit/';
  static const String pdfDelete = '/pdfs/delete/';
  static const String lastModule = '/lastmodule/';

  // volume
  static String setVolume = "/volume/set/";
  static String getVolume = "/volume/get/";

  // complaint
  static String createComplaint = "/police/complaints/create/";
  static String complaintsList = "/police/complaints/list/?user=";
  static String createSpeak = "/police/speak/create/";
  static String getCurrentSpeak = "/police/speak/list/";
}
