import 'package:flutter/material.dart';
import '../models/github_models.dart';
import '../models/github_repository.dart';
import '../services/github_service.dart';

class DetailsScreen extends StatelessWidget {
  final GitHubUser user;

  const DetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.login),
      ),
      body: FutureBuilder<List<GitHubRepository>>(
        future: GitHubService.fetchRepositories(user.login),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No repositories found'));
          } else {
            List<GitHubRepository>? repositories = snapshot.data;
            return ListView.builder(
              itemCount: repositories?.length ?? 0,
              itemBuilder: (context, index) {
                GitHubRepository? repository = repositories?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(
                        repository?.name ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(repository?.description ?? ''),
                      onTap: () {
                        // Add your onTap logic here
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
