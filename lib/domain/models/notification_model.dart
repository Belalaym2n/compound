import 'package:intl/intl.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String? time; // Add a field for time (nullable)
  final String? date; // Add a field for time (nullable)

  NotificationModel({
    required this.id,
    required this.time,
    required this.date,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final int? dataTime = json['send_after'];

    final DateTime dateTime = dataTime != null
        ? DateTime.fromMillisecondsSinceEpoch(dataTime * 1000)
        : DateTime.now(); // fallback to current time if timestamp is null

    final String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

    String? imageUrl = json['big_picture'] ?? json['imageUrl'];
    print(imageUrl);
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['headings']?['en'] ?? '',
      description: json['contents']?['en'] ?? '',
      imageUrl: imageUrl,
      date: dateTime.toString(),
      time: formattedDate, // Use t she parsed time or a default value
    );
  }

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl, time: $time)';
  }
}
