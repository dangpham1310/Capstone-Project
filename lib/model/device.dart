import 'package:project/model/weather.dart';
import 'package:project/model/schedule.dart';

class DeviceModel {
  final int id;
  final int clientId;
  final String name;
  final String description;
  final String createdAt;
  final String? lastSeen;

  DeviceModel({
    required this.id,
    required this.clientId,
    required this.name,
    required this.description,
    required this.createdAt,
    this.lastSeen,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'],
      clientId: json['client_id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['created_at'],
      lastSeen: json['last_seen'],
    );
  }
}
