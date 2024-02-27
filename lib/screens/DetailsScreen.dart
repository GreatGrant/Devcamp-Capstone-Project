import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class DetailsScreen extends StatelessWidget {
  final String userId;

  const DetailsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Fetch user details based on userId
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: FutureBuilder<User>(
        future: ApiService.fetchUserDetails(int.parse(userId)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching user details'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final user = snapshot.data!;
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
            );
          }
        },
      ),
    );
  }
}
