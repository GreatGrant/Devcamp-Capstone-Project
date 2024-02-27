import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/github_models.dart';
import '../services/github_service.dart'; // Import GitHubService from the correct location

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<GitHubUser> _users; // Change User to GitHubUser
  bool _isLoading = true; // Initialize _isLoading as true

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Call _fetchUsers method to fetch users
  }

  void _fetchUsers() async {
    try {
      List<GitHubUser> fetchedUsers = await GitHubService.fetchUsers(); // Use await to wait for fetchUsers
      setState(() {
        _users = fetchedUsers; // Assign fetched users to _users
        _isLoading = false; // Set isLoading to false when users are fetched
      });
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Error: $e');
      }
      setState(() {
        _isLoading = false; // Set isLoading to false in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          GitHubUser user = _users[index];
          return Card(
            color: index % 2 == 0 ? Colors.blue : Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
              ),
              title: Text(user.login),
              onTap: () {
                final encodedAvatarUrl = Uri.encodeComponent(user.avatarUrl);
                final encodedUrl = Uri.encodeComponent(user.url);
                GoRouter.of(context).go(
                  '/details/${user.login}/${user.id}/$encodedAvatarUrl/$encodedUrl',
                );
              },
            ),
          );
        },
      ),
    );
  }
}
