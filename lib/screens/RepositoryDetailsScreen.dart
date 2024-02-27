import 'package:flutter/material.dart';
import '../models/github_repository.dart';
import '../services/github_service.dart';

class RepositoryDetailsScreen extends StatelessWidget {
  final int repositoryId;

  const RepositoryDetailsScreen({super.key, required this.repositoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Details'),
      ),
      body: FutureBuilder<GitHubRepository>(
        future: GitHubService.fetchRepositoryDetails(repositoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            GitHubRepository repository = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Owner: ${repository.fullName}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Repository ID: ${repository.id}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Name: ${repository.name}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description: ${repository.description ?? "No description"}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
