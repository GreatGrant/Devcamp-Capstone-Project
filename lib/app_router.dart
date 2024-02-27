import 'package:dev_camp_capstone/screens/DetailsScreen.dart';
import 'package:dev_camp_capstone/screens/HomeScreen.dart';
import 'package:dev_camp_capstone/screens/RepositoryDetailsScreen.dart';
import 'package:go_router/go_router.dart';

import 'models/github_models.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:username/:id/:avatarUrl/:url', // Include parameters in the path
      builder: (context, state) {
        // Extract parameters from path parameters
        final username = state.pathParameters['username']!;
        final id = int.parse(state.pathParameters['id']!);
        final avatarUrl = state.pathParameters['avatarUrl']!;
        final url = state.pathParameters['url']!;
        return DetailsScreen(
          user: GitHubUser(
            login: username,
            id: id,
            avatarUrl: avatarUrl,
            url: url,
          ),
        );
      },
    ),
    GoRoute(
      path: '/repository-details/:id',
      builder: (context, state) {
        final repositoryId = int.parse(state.pathParameters['id']!);
        return RepositoryDetailsScreen(repositoryId: repositoryId);
      },
    ),
  ],
);
