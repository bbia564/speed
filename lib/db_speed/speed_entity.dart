import 'package:intl/intl.dart';

class SpeedEntity {

  int id;
  DateTime createdTime;
  int type;
  int speed;

  SpeedEntity({
    required this.id,
    required this.createdTime,
    required this.type,
    required this.speed,
  });

  factory SpeedEntity.fromJson(Map<String, dynamic> json) => SpeedEntity(
    id: json["id"],
    createdTime: DateTime.parse(json["created_time"]),
    type: json["type"],
    speed: json["speed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_time": createdTime.toIso8601String(),
    "type": type,
    "speed": speed,
  };

  String get time {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(createdTime);
  }

}