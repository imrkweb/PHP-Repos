class RepoModel {
  final int id;
  final String name;
  final String url;
  final String createdAt;
  final String pushedAt;
  final String description;
  final int stargazersCount;

  RepoModel({
    required this.id,
    required this.name,
    required this.url,
    required this.createdAt,
    required this.pushedAt,
    required this.description,
    required this.stargazersCount,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json['id'],
      name: json['name'] ?? 'No Name',
      url: json['html_url'] ?? 'No Url',
      createdAt: json['created_at'] ?? 'No Data',
      pushedAt: json['pushed_at'] ?? 'No Data',
      description: json['description'] ?? 'No Data',
      stargazersCount: json['stargazers_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'created_at': createdAt,
      'pushed_at': pushedAt,
      'description': description,
      'stargazers_count': stargazersCount,
    };
  }
}
