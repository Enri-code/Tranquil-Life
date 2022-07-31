class Note {
  final String title;
  final String description;
  final DateTime dateUpdated;
  final int colorInt;

  const Note({
    required this.title,
    required this.description,
    required this.dateUpdated,
    this.colorInt = 0xffACD5E8,
  });
}
