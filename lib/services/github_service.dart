import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_models.dart';
import '../models/github_repository.dart';
import '../util/constants.dart';

class GitHubService {

  static Future<List<GitHubUser>> fetchUsers() async {
    final response = await http.get(Uri.parse('$BASE_URL/users'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => GitHubUser.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<GitHubUser> fetchUser(String username) async {
    final response = await http.get(Uri.parse('$BASE_URL/users/$username'));
    if (response.statusCode == 200) {
      return GitHubUser.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<List<GitHubUser>> searchUsers(String query) async {
    final response = await http.get(Uri.parse('$BASE_URL/users?q=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => GitHubUser.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search users');
    }
  }
  static Future<List<GitHubRepository>> fetchRepositories(String username) async {
    final response = await http.get(Uri.parse('$BASE_URL/users/$username/repos'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => GitHubRepository.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }

  static Future<GitHubRepository> fetchRepositoryDetails(int repositoryId) async {
    final response = await http.get(Uri.parse('$BASE_URL/repositories/$repositoryId'));
    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      return GitHubRepository.fromJson(responseData);
    } else {
      throw Exception('Failed to load repository details');
    }
  }

}
