class Consultant {
  final String id;
  final String name;
  final String summary;
  final String description;
  final String avatarUrl;

  const Consultant({
    required this.id,
    required this.name,
    required this.summary,
    required this.description,
    this.avatarUrl = '',
  });
}
