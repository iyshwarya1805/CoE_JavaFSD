class Challenge {
  final String id;
  final String title;
  final String description;
  final int points;
  final List<String> rewards;
  final bool isCompleted;
  final int currentProgress;
  final int targetValue;
  final String metric;
  final DateTime endDate;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.rewards,
    this.isCompleted = false,
    this.currentProgress = 0,
    this.targetValue = 100,
    this.metric = '',
    DateTime? endDate,
  }) : endDate = endDate ?? DateTime.now().add(const Duration(days: 30));

  factory Challenge.fromMap(Map<String, dynamic> map, String id) {
    return Challenge(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      points: map['points'] ?? 0,
      rewards: List<String>.from(map['rewards'] ?? []),
      isCompleted: map['isCompleted'] ?? false,
      currentProgress: map['currentProgress'] ?? 0,
      targetValue: map['targetValue'] ?? 100,
      metric: map['metric'] ?? '',
      endDate: map['endDate'] != null 
          ? (map['endDate'] as dynamic).toDate() 
          : DateTime.now().add(const Duration(days: 30)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'points': points,
      'rewards': rewards,
      'isCompleted': isCompleted,
      'currentProgress': currentProgress,
      'targetValue': targetValue,
      'metric': metric,
      'endDate': endDate,
    };
  }

  double get progressPercentage => 
      targetValue > 0 ? (currentProgress / targetValue).clamp(0.0, 1.0) : 0.0;
}