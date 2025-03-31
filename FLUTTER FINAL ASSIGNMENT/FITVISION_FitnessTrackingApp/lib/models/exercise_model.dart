class Exercise {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final int defaultDuration; // in seconds

  Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.defaultDuration = 30,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? 'https://via.placeholder.com/150',
      defaultDuration: json['duration'] ?? 30,
    );
  }
}