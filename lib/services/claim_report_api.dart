import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/claim_report.dart';

class ClaimReportApi {
  static const String _baseUrl = 'http://10.0.2.2/lostandfoundAPI';

  Future<bool> submitClaimReport(ClaimReport claimReport) async {
    final jsonPayload = jsonEncode(claimReport.toJson());

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/claim_report.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonPayload,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['success'];
      } else {
        return false;
      }
    } catch (e) {
      print('Exception during form submission: $e');
      return false;
    }
  }
}
