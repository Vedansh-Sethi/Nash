class Notification {
  final String content;
  final DateTime createdAt;

  Notification({required this.content, required this.createdAt});

  factory Notification.fromJSON(Map<String, dynamic> json) => Notification(
    content: json['content'],
    createdAt: DateTime.parse(json['created_at']),
  );
}
