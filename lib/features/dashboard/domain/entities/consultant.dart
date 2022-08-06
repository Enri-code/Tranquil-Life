class Consultant {
  final String uid;
  final String name;
  final String avatarUrl;

  const Consultant({
    required this.uid,
    required this.name,
    this.avatarUrl = '',
  });
}
