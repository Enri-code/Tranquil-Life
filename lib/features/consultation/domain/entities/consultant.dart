class Consultant {
  final String id;
  final String name;
  final String specialties;
  final String description;
  final String avatarUrl;

  const Consultant({
    required this.id,
    required this.name,
    this.specialties = '',
    this.description = '',
    this.avatarUrl = '',
  });
}
