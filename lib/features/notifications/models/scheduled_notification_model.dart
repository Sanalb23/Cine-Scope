import 'dart:convert';

class ScheduledNotificationModel {
  final int id;
  final String title;
  final String body;
  final DateTime scheduledTime;
  final String channelId;
  final String channelName;
  final String? localPosterPath;
  final String? localBackdropPath;

  ScheduledNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledTime,
    required this.channelId,
    required this.channelName,
    this.localPosterPath,
    this.localBackdropPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'scheduledTime': scheduledTime.toIso8601String(),
      'channelId': channelId,
      'channelName': channelName,
      'posterPath': localPosterPath,
      'backdropPath': localBackdropPath,
    };
  }

  factory ScheduledNotificationModel.fromMap(Map<String, dynamic> map) {
    return ScheduledNotificationModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      scheduledTime: DateTime.parse(map['scheduledTime']),
      channelId: map['channelId'] ?? '',
      channelName: map['channelName'] ?? '',
      localPosterPath: map['posterPath'],
      localBackdropPath: map['backdropPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduledNotificationModel.fromJson(String source) =>
      ScheduledNotificationModel.fromMap(json.decode(source));
}
