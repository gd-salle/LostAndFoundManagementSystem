import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ItemReportApi {
  static const String _baseUrl = 'http://10.0.2.2/lostandfoundAPI';

  Future<bool> reportLostItem(Item item) async {
    final jsonPayload = jsonEncode(item.toJson());

    
    print('JSON Payload: $jsonPayload');

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/item_report.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonPayload,
      );

      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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

  Future<bool> reportFoundItem(Item item) async {
    final jsonPayload = jsonEncode(item.toJson());

    
    print('JSON Payload: $jsonPayload');

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/item_report.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonPayload,
      );

      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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

  Future<List<Item>> fetchAllReports() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/item_report.php'));
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => Item.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load reports');
      }
    } catch (e) {
      print('Exception during fetching reports: $e');
      throw e;
    }
  }
}
