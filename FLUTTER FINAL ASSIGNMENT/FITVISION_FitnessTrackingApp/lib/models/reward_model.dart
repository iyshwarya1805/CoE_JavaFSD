class Reward {
  final String id;
  final String title;
  final String description;
  final int pointCost;
  final String imageUrl;
  
  Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.pointCost,
    required this.imageUrl,
  });
  
  factory Reward.fromMap(Map<String, dynamic> map, String id) {
    return Reward(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      pointCost: map['pointCost'] ?? 0,
      imageUrl: map['imageUrl'] ?? '',
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'pointCost': pointCost,
      'imageUrl': imageUrl,
    };
  }
}