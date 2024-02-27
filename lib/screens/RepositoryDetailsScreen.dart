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
            final repository = snapshot.data!;
            return Center( // Center the content vertically and horizontally
              child: SingleChildScrollView( // Allow scrolling for long descriptions
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Repository name with prominent style
                    Text(
                      repository.name,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // Custom color for the repository name
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Owner information with avatar
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(repository.imageUrl),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Owned by ${repository.name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(thickness: 1),
                    const SizedBox(height: 20),
                    // Description with optional formatting
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Description: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: repository.description ?? 'No description',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
