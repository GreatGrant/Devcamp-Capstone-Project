class GitHubRepository {
  final int id;
  final String name;
  final String fullName;
  final String htmlUrl;
  final String description;
  final String imageUrl;

  GitHubRepository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.htmlUrl,
    required this.description,
    required this.imageUrl,
  });

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      id: json['id'],
      name: json['name'],
      fullName: json['full_name'],
      htmlUrl: json['html_url'],
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
