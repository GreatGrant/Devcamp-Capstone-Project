import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../util/constants.dart';

class ApiService {
  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<User> fetchUserDetails(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      return User.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }
}
