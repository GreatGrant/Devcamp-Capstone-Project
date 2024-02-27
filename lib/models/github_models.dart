class GitHubUser {
  final String login;
  final int id;
  final String avatarUrl;
  final String url;

  GitHubUser({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.url,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
    );
  }
}

