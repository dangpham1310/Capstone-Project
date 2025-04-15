import 'package:flutter/material.dart';

class ScheduleModel {
  final String description;
  TimeOfDay timeOfDay;
  final bool isDone;
  final bool isRepat;

  ScheduleModel({
    required this.description,
    required this.timeOfDay,
    required this.isDone,
    required this.isRepat,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      description: json['description'] as String,
      timeOfDay: TimeOfDay(
        hour: json['hour'] as int,
        minute: json['minute'] as int,
      ),
      isDone: json['isDone'] as bool,
      isRepat: json['isRepat'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'hour': timeOfDay.hour,
      'minute': timeOfDay.minute,
      'isDone': isDone,
      'isRepat': isRepat,
    };
  }

  ScheduleModel copyWith({
    String? description,
    TimeOfDay? timeOfDay,
    bool? isDone,
    bool? isRepat,
  }) {
    return ScheduleModel(
      description: description ?? this.description,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      isDone: isDone ?? this.isDone,
      isRepat: isRepat ?? this.isRepat,
    );
  }
}
