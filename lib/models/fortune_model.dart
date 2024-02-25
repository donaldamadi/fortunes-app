class FortuneModel {
  final int? id;
  final String fortune;
  final DateTime date;
  final int color;

  FortuneModel({
    required this.id,
    required this.fortune,
    required this.date,
    required this.color,
  });

  factory FortuneModel.fromJson(Map<String, dynamic> json) {
    return FortuneModel(
      id: json['id'] as int,
      fortune: json['fortune'] as String,
      date: DateTime.parse(json['date'] as String),
      color: json['color'] as int,
    );
  }

  factory FortuneModel.empty() {
    return FortuneModel(
      id: null,
      fortune: '',
      date: DateTime.now(),
      color: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fortune': fortune,
      'date': date.toIso8601String(),
      'color': color.toString(),
    };
  }
}
