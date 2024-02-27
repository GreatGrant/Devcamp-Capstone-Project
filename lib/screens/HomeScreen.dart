import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/github_models.dart';
import '../services/github_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<GitHubUser> _users = [];

  @override
  void initState() {
    super.initState();
    _searchUsers('');
  }

  void _searchUsers(String query) async {
    try {
      List<GitHubUser> users = await GitHubService.searchUsers(query);
      setState(() {
        _users = users;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search GitHub users',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: _searchUsers,
        ),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          GitHubUser user = _users[index];
          return ListTile(
            title: Text(user.login),
            onTap: () {
              final encodedAvatarUrl = Uri.encodeComponent(user.avatarUrl);
              final encodedUrl = Uri.encodeComponent(user.url);
              GoRouter.of(context).go(
                '/details/${user.login}/${user.id}/$encodedAvatarUrl/$encodedUrl',
              );
            },
          );
        },
      ),
    );
  }
}

